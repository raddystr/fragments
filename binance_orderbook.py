import requests
import websocket
import json 
import concurrent.futures



class Client():
    def __init__(self, pair):
        self.pair = pair
        self.ws = websocket.WebSocketApp(
            url=f'wss://stream.binance.com:9443/ws/{pair}@depth',
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
                print(f'Update: {self.pair_prettify()}\n')
                self.process_updates(data)
            else:
                print(f'Update: {self.pair_prettify()}\n')
                print('discard update')            
        
        elif data['U'] == last_updateId + 1:
            print('process this update')
            self.orderbook['lastUpdateId'] = data['u']
            print(f'Update: {self.pair_prettify()}\n')
            self.process_updates(data)
            
        else:
            print('Out of sync, abort')


    def on_error(self, ws, error):
        print(error)


    def on_close(self, ws):
        print('### Closed ###')


    def on_open(self, ws):
        print(f'Connected to Binance...\nGetting data for {self.pair_prettify()}...\n')


    def get_snapshot(self):
        r = requests.get(f'https://www.binance.com/api/v1/depth?symbol={self.pair.upper()}&limit=1000')
        return json.loads(r.content.decode())


    def process_updates(self, data):
        for update in data['b']:
            self.manage_orderbook('bids', update)
        for update in data['a']:
            self.manage_orderbook('asks', update)
        print()


    def manage_orderbook(self, side, update):

        price, quantity = update

        for x in range(0, len(self.orderbook[side])):
            if price == self.orderbook[side][x][0]:
                if quantity == 0:
                    del self.orderbook[side]
                    print(f'Removed on {self.pair_prettify()} price: {price} | quantity: {quantity}')
                    break
                else:
                    self.orderbook[side][x] = update
                    print(f'Updated on {self.pair_prettify()} price: {price} | quantity: {quantity}')
                    break
            elif price > self.orderbook[side][x][0]:
                if quantity != 0:
                    self.orderbook[side].insert(x, update)  
                    print(f'New on {self.pair_prettify()} price: {price} | quantity: {quantity}')
                    break
                else:
                    break


    def pair_prettify(self):
        pretty_pair = f'{self.pair[:3].upper()}/{self.pair[3:6].upper()}'
        return pretty_pair



def main(pair) -> None:
    client = Client(pair)

    client.run_forever()


if __name__ == "__main__":
    
    pairs = ['1inchbtc','1inchusdt','aaveusdt','adabnb','adabtc','adabusd','adaeth','adatusd',
    'adausdc','adausdt','algobtc','algousdt',
    'atombtc','atometh','atomusdc','atomusdt',
    'avaxbnb','avaxbtc','avaxeur','avaxusdt','axsbtc',
    'axseth','axsusdt','badgerbtc','badgerusdt',
    'balusdt','bchbtc','bchusdc','bchusdt','betheth','bnbbtc',
    'bnbdai','bnbeth','bnbtusd','bnbusdc','bnbusdp','btcbusd','btcdai','btctusd',
    'btcusdc','btcusdp','btcusdt','busdusdt','cakebtc','cakeusdt',
    'crvbtc','crveth','crvusdt','dogebtc','dogebusd','dogeusdt','dotbnb','dotbtc',
    'dotbusd','dotusdt','dydxusdt','enjbtc','enjusdt','eosbtc','eoseth','eosusdc',
    'eosusdt','etcusdt','ethbtc','ethbusd','ethdai','ethtusd','ethusdc',
    'ethusdp','ethusdt','ethust','eurusdt','ftmbtc','ftmeth','ftmusdt','fttbtc',
    'fttusdt','gbpusdt','hbarusdt','kavausdt','ksmbtc','ksmusdt','linkbtc',
    'linketh','linkgbp','linkusdc','linkusdt','ltcbtc','ltceth','ltcusdc','ltcusdt'
    ,'lunabnb','lunabtc','lunabusd','lunaeur','lunausdt','lunaust',
    'manabtc','manaeth','manausdt','maticbnb','maticbtc','maticbusd','maticeth',
    'maticeur','maticgbp','maticusdt','nearbtc','neareth','nearusdt',
    'paxgbtc','paxgusdt','runebtc','runeusdt','sandbtc','sandeth','sandusdt',
    'solbtc','solbusd','soleth','solusdc','solusdt','sushibtc','sushiusdt',
    'trxbtc','trxeth','trxtusd','trxusdc','trxusdt','tusdusdt','unibnb','unibtc'
    ,'unieur','uniusdt','usdcusdt','usdpusdt','usdtdai','ustbtc',
    'ustusdt','vetbtc','veteth','vetusdt','vthousdt',
    'waxpbtc','waxpusdt','xecusdt','xlmbtc','xlmeth',
    'xlmusdt','xrpbtc','xrpeth','xrptusd','xrpusdc','xrpusdt']

#    with concurrent.futures.ThreadPoolExecutor() as executor:
#        executor.map(main, pairs)

    with concurrent.futures.ProcessPoolExecutor() as executor:
        executor.map(main, pairs)
