import requests
import websocket
import json 
import concurrent.futures
import datetime 
import pandas as pd
import awswrangler as wr

class Client():
    def __init__(self, pair):
        self.raw_pair = pair
        self.pair = self.pair_concat()

        self.ws = websocket.WebSocketApp(
            url=f'wss://stream.binance.com:9443/ws/{self.pair}@depth',
            on_message=self.on_message,
            on_error=self.on_error,
            on_close=self.on_close,
            on_open=self.on_open
        )

        self.orderbook = {}
        self.updates = 0


    def run_forever(self):
        self.ws.run_forever()


    def on_message(self, ws, message):

        data = json.loads(message)
        
        if len(self.orderbook) == 0:
            self.orderbook = self.get_snapshot()

        last_updateId = self.orderbook['lastUpdateId']

        if self.updates == 0:
            if data['U'] <= last_updateId + 1 and data['u'] >= last_updateId + 1:
                print('process this update')
                self.orderbook['lastUpdateId'] = data['u']
                print(f'Update: {self.pair}\n')
                self.process_updates(data)
            else:
                print(f'Update: {self.pair}\n')
                print('discard update')            
                pass
        elif data['U'] == last_updateId + 1:
            print('process this update')
            self.orderbook['lastUpdateId'] = data['u']
            print(f'Update: {self.pair}\n')
            self.process_updates(data)
            
        else:
            print('Out of sync, abort')


    def on_error(self, ws, error):
        print(error)


    def on_close(self, ws):
        print('### Closed ###')


    def on_open(self, ws):
        print(f'Connected to Binance...\nGetting data for {self.pair}...\n')


    def get_snapshot(self):
        r = requests.get(f'https://www.binance.com/api/v1/depth?symbol={self.pair.upper()}&limit=1000')
        return json.loads(r.content.decode())


    def process_updates(self, data):
        time = data['E']
        
        temp_data = {'timestamp':[],
                    'pair':[],
                    'price':[],
                    'quantity':[],
                    'side':[]
                    }
        
        for update in data['b']:
            self.manage_orderbook('bids', update, time, temp_data)

        for update in data['a']:
            self.manage_orderbook('asks', update, time, temp_data)
        
        
        timer = (datetime.datetime.utcfromtimestamp(time // 1000))

        if timer.second == 0:
            write_to_s3(temp_data)
            
            temp_data = {'timestamp':[],
                    'pair':[],
                    'price':[],
                    'quantity':[],
                    'side':[]
                    }


    def manage_orderbook(self, side, update, time, temp_data):   
        price, quantity = update
        price = float(price)
        quantity = float(quantity)

        for x in range(0, len(self.orderbook[side])):
            if price == self.orderbook[side][x][0]:
                if quantity == 0:
                    del self.orderbook[side]
                    print(f"Removed on {time} {self.pair} price: {price} | quantity: {quantity} --> {side}")
                    break
                else:
                    self.orderbook[side][x] = update
                    print(f"Updated on {time} {self.pair} price: {price} | quantity: {quantity} --> {side}")
                    temp_data['timestamp'].append(time)
                    temp_data['pair'].append(self.raw_pair)
                    temp_data['price'].append(price)
                    temp_data['quantity'].append(quantity)
                    temp_data['side'].append(side)
                    break
            elif price > float(self.orderbook[side][x][0]):
                if quantity > 0:
                    self.orderbook[side].insert(x, update)  
                    print(f"New on {time} {self.pair} price: {price} | quantity: {quantity} --> {side}")
                    temp_data['timestamp'].append(time)
                    temp_data['pair'].append(self.raw_pair)
                    temp_data['price'].append(price)
                    temp_data['quantity'].append(quantity)
                    temp_data['side'].append(side)
                    break
                else:
                    break
            

    def pair_concat(self):
        base, quote = self.raw_pair.split('_')
        concat_pair = f'{base}{quote}'
        return concat_pair



def write_to_s3(dict) -> None:

    df = pd.DataFrame(dict)

    pairs = set(df['pair'].to_list())

    df.loc[:, "timestamp"] = pd.to_datetime(df.loc[:, "timestamp"], unit='ms')
    df.loc[:, "price"] = df.loc[:, "price"].astype(float)
    df.loc[:, "quantity"] = df.loc[:, "quantity"].astype(float)
    df.loc[:, "side"] = df.loc[:, "side"].astype(object)
    df = df.drop_duplicates().reset_index(drop=True)

    

    for pair in pairs:
        df_write_ready = df[df['pair'] == pair]    

        wr.s3.to_parquet(df=df_write_ready[['timestamp', 'price', 'quantity', 'side']],
                    path=f's3://radi-test-influx/orderbook_data/exchange=binance/symbol={pair}/',
                    mode='append', 
                    dataset=True)


def main(pair) -> None:
    client = Client(pair)

    client.run_forever()


if __name__ == "__main__":
    
    pairs = ['1inch_btc','1inch_usdt','aave_usdt','ada_bnb','ada_btc','ada_busd',
    'ada_eth','ada_tusd','ada_usdc','ada_usdt','algo_btc','algo_usdt','atom_btc',
    'atom_eth','atom_usdc','atom_usdt','avax_bnb','avax_btc','avax_eur','avax_usdt',
    'axs_btc','axs_eth','axs_usdt','badger_btc','badger_usdt','bal_usdt','bch_btc',
    'bch_usdc','bch_usdt','beth_eth','bnb_btc','bnb_dai','bnb_eth','bnb_tusd','bnb_usdc',
    'bnb_usdp','btc_busd','btc_dai','btc_tusd','btc_usdc','btc_usdp','btc_usdt','busd_usdt',
    'cake_btc','cake_usdt','crv_btc','crv_eth','crv_usdt','doge_btc','doge_busd','doge_usdt',
    'dot_bnb','dot_btc','dot_busd','dot_usdt','dydx_usdt','enj_btc','enj_usdt','eos_btc',
    'eos_eth','eos_usdc','eos_usdt','etc_usdt','eth_btc','eth_busd','eth_dai','eth_tusd',
    'eth_usdc','eth_usdp','eth_usdt','eth_ust','eur_usdt','ftm_btc','ftm_eth','ftm_usdt',
    'ftt_btc','ftt_usdt','gbp_usdt','hbar_usdt','kava_usdt','ksm_btc','ksm_usdt','link_btc',
    'link_eth','link_gbp','link_usdc','link_usdt','ltc_btc','ltc_eth','ltc_usdc','ltc_usdt',
    'luna_bnb','luna_btc','luna_busd','luna_eur','luna_usdt','luna_ust','mana_btc','mana_eth',
    'mana_usdt','matic_bnb','matic_btc','matic_busd','matic_eth','matic_eur','matic_gbp','matic_usdt',
    'near_btc','near_eth','near_usdt','paxg_btc','paxg_usdt','rune_btc','rune_usdt','sand_btc',
    'sand_eth','sand_usdt','sol_btc','sol_busd','sol_eth','sol_usdc','sol_usdt','sushi_btc',
    'sushi_usdt','trx_eth','trx_btc','trx_usdc','trx_tusd','tusd_usdt','trx_usdt','uni_btc',
    'uni_bnb','uni_usdt','uni_eur','usdp_usdt','usdc_usdt','ust_btc','usdt_dai','vet_btc',
    'ust_usdt','vet_usdt','vet_eth','waxp_btc','vtho_usdt','xec_usdt','waxp_usdt','xlm_eth',
    'xlm_btc','xrp_btc','xlm_usdt','xrp_eth','xrp_tusd','xrp_usdc','xrp_usdt']


with concurrent.futures.ThreadPoolExecutor(max_workers=300) as executor:
    executor.map(main, pairs)  
    #with concurrent.futures.ProcessPoolExecutor(max_workers=120) as executor:
    #    executor.map(main, pairs)
