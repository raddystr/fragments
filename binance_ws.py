
from datetime import datetime
from email import message_from_string
import json
import websocket
import pandas as pd
import csv
import sys



cc = 'btcusd'
WS = f'wss://stream.binance.com:9443/ws/{cc}t@trade'


def time_and_volume_csv(time, volume):
    with open('test_time.csv', 'a+') as f:
        writer = csv.writer(f)
        writer.writerow([time, volume])

def rec_message(ws, message):
    message_dict = json.loads(message)
    time = datetime.fromtimestamp(int(int(message_dict['T'])/1000))
    volume = message_dict['q']
    print(message_dict)
    time_and_volume_csv(time, volume)
    
def main(WS):
    if len(sys.argv) == 2:
        if sys.argv[1] == '-w':
            print(f'WEB SOCKET OPEN: {WS}')
            ws = websocket.WebSocketApp(WS, on_message=rec_message)
            ws.run_forever()
        elif sys.argv[1] == '-r':
            data = pd.read_csv('test_time.csv', sep=',' , names=['time' ,'volume'])
            data['time'] = pd.to_datetime(data['time'])
            print(data.resample('min', on='time').volume.sum())
    else:
        print(f"Please run {sys.argv[0]} with '-w' or ''-r' parameters")

if __name__ == '__main__':
    main(WS)
    
