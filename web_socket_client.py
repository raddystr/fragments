import json


###IF YOU WANT ADDITIONAL CRYPTO PAIRS APPEND THEM HERE
#ACCORDING TO KRAKEN'S OUTPUTS CURRENTLY IT IS XBT/USD INSTEAD OF BTC/USD
PAIRS = ["XBT/USD", "ETH/USD"]

#STRING/ADDRESS FOR ESTABLISHING CONNECTION
WS_URL = "wss://ws.kraken.com/"
WS_CONNECT_STRING = f'{{"event":"subscribe","subscription":\
                        {{"name":"book"}},\
                        "pair":{json.dumps(PAIRS)}}}'

        

def create_all_pairs_dict(pairs_list):
    """
    This function creates dictionary 
    for storing asks and bids lists for every CRYPTO/USD pair
    """

    pairs_dict = dict()
    for pair in pairs_list:
        pairs_dict[pair] = {'asks':[], 'bids':[]}
    return pairs_dict


def write_to_csv(pair_info, type, pair, date):   
    """
    Writes crypto pairs data to csv file\n
    creates directories structure for storing the csv files\n
    and set csv's structure(columns/header)\n
    """

    import csv
    from os import makedirs, path

    
    current_time = date
    dir_path = f'pseudolake/{current_time.year}/{current_time.month}/{current_time.day}/{current_time.hour}'
    filename = f'{dir_path}/data_{current_time.minute}.csv'

    if not path.exists(dir_path):
        makedirs(dir_path)
    
    header = ''
    
    if not path.exists(filename):
        header = ['value', 'volume', 'type', 'pair', 'date']

    with open(filename, 'a+', encoding='UTF-8') as d:
        writer = csv.writer(d)
    
        if header:
            writer.writerow(header)                        
    
        for pi in pair_info:
            writer.writerow([pi[0], pi[1], type, pair, date])                        

def wrtite_to_influx(pair_info, type, pair):
    from influxdb import InfluxDBClient
    from datetime import datetime

    client = InfluxDBClient('localhost', 8086, 'admin', 'mypass', 'mydb')
    client.create_database('mydb')
    client.get_list_database()
    client.switch_database('mydb')
    
    json_data = []

    data = {
            "measurement": "pairs",
            "tags":{
                "ticker":f"{pair}"
            },
            "time":datetime.now(),
            "fields": {
                'price':pair_info[0],
                'volume':pair_info[1],
                'type':type
            }
        }

    json_data.append(data)
    client.write_points(json_data)


def append_pair_info(pair_info_stream, asks_list, bids_list, pair):
    """
    Appends price and volume data from the websocket
    stream to the list with asks and bids
    \n
    pair_info_stream[pi][0][0]) --> price
    \n
    pair_info_stream[pi][0][1]) --> volume
    """

    for pi in pair_info_stream.keys():
        if pi == 'a':
            asks_list.append((float(pair_info_stream[pi][0][0]), float(pair_info_stream[pi][0][1])))
            if float(pair_info_stream[pi][0][1]) > 0:
                wrtite_to_influx((float(pair_info_stream[pi][0][0]), float(pair_info_stream[pi][0][1])), 'a', pair)
        elif pi == 'b':
            bids_list.append((float(pair_info_stream[pi][0][0]), float(pair_info_stream[pi][0][1])))
            if float(pair_info_stream[pi][0][1]) > 0:
                wrtite_to_influx((float(pair_info_stream[pi][0][0]), float(pair_info_stream[pi][0][1])), 'b', pair)
            
            

def print_pair_info(asks_list, bids_list, pair_type):  
    """
    Print the console output(I've created a representation list\n
    because the output is 2k+ rows and will be hard to be tracked).\n
    This function sorts the price/volume output,removes the \n
    zero-volumes(it is not part of the tasks nevertheless sounds\n
    logic to me), finds the best ask/bid and calls `write_to_csv`\n
    fucntion to store the data.
    """        
    
    from datetime import datetime

    print('<----------------------------------------------------->')        
    print('asks:')
    asks_list = sorted(asks_list, key= lambda x: x[0])
    asks_list =[i for i in asks_list if i[1] > 0]
    write_to_csv(asks_list, 'a', pair_type, datetime.now())
    repr_list = asks_list[0:10][::-1]
    print(*repr_list, sep='\n')
    print('bids:')
    bids_list = sorted(bids_list, key = lambda x: x[0])
    bids_list =[i for i in bids_list if i[1] > 0]
    write_to_csv(bids_list, 'b', pair_type, datetime.now())
    repr_list = bids_list[0:10][::-1]
    print(*repr_list, sep='\n')
    print('<----------------------------------------------------->')
    print(f'best ask: ', asks_list[0])
    print(f'best bid: ', bids_list[0])
    print('<----------------------------------------------------->')
    print( datetime.now(),'\n', pair_type)
    print('>-----------------------------------------------------<')


def print_pair_info_fast(asks_list, bids_list, pair_type):  
    """
    Prints the console output, sorts the price/volume\n 
    output, removes the zero-volumes, finds the best\n 
    ask/bid. Also a bit redundant feel free to remove the call of it\n
    from the code if you want more slow but readable output\n
    """        
        
    from datetime import datetime

    print('<----------------------------------------------------->')        
    print('asks:')
    asks_list_sorted = sorted(asks_list, key= lambda x: x[0])
    asks_list_sorted =[i for i in asks_list_sorted if i[1] > 0]
    asks_list_sorted_rev = asks_list_sorted[::-1]
    print(*asks_list_sorted_rev, sep='\n')
    print('bids:')
    bids_list_sorted = sorted(bids_list, key = lambda x: x[0])
    bids_list_sorted =[i for i in bids_list_sorted if i[1] > 0]
    bids_list_sorted_rev = bids_list_sorted[::-1]
    print(*bids_list_sorted_rev, sep='\n')
    print('<----------------------------------------------------->')
    print(f'best ask: ', asks_list_sorted[0])
    print(f'best bid: ', bids_list_sorted[0])
    print('<----------------------------------------------------->')
    print( datetime.now(),'\n', pair_type)
    print('>-----------------------------------------------------<')


def main(PAIRS, WS_URL, WS_CONNECT_STRING):
    import json
    import time

    from websocket import create_connection

    #CREATING CONNECTION AND SENDING REQUEST
    ws = create_connection(WS_URL)
    ws.send(WS_CONNECT_STRING)

    #CREATE DICTIONARY TO STORE ALL ASK/BIDS PER PAIR
    all_crypto_pairs = create_all_pairs_dict(PAIRS)

    #COUNTS PAIRS WRITES
    debug_counter = 0
    flush_counter = 0

    while True:

        #KRAKEN RESPONSE
        ws_res = json.loads(ws.recv())
                
        #REMOVE HEADER AND METAINFO
        if type(ws_res) != list:
            continue
                
        pairs_info_stream = ws_res[1]
        pair_label = ws_res[-1]

        timer_round = time.localtime(time.time())

        for p in PAIRS:
                        
            if p == pair_label:
                append_pair_info(
                        pairs_info_stream, 
                        all_crypto_pairs[p]['asks'], 
                        all_crypto_pairs[p]['bids'],
                        p)
               
                
                debug_counter += 1

                if len(all_crypto_pairs[p]['asks']) > 10 and len(all_crypto_pairs[p]['bids']) > 10:                
                    print_pair_info_fast(
                        all_crypto_pairs[p]['asks'], 
                        all_crypto_pairs[p]['bids'], 
                        p)

                    if timer_round.tm_sec == 0:
                                            
                        print_pair_info(
                            all_crypto_pairs[p]['asks'], 
                            all_crypto_pairs[p]['bids'], p)
                        flush_counter += 1
                                            
                    #IF ALL DATA IS WRITTEN - RECRECREATE AN EMPTY DICTIONARY
                    if flush_counter == len(PAIRS):
                        all_crypto_pairs = create_all_pairs_dict(PAIRS)
                        flush_counter = 0
        print('DEBUG:', debug_counter, "PAIRS INFO PROCESSED") 

if __name__ == '__main__':
    main(PAIRS, WS_URL, WS_CONNECT_STRING)
