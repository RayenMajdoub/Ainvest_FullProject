import json
import socketio
import pika
import threading
from queue import Queue
import seaborn as sns
# create a Socket
import eventlet
import pandas as pd
import numpy as np

# rabbitmq config

# dictionary to store thread objects
queue = Queue()
sio = socketio.Server(cors_allowed_origins='*')    
app = socketio.WSGIApp(sio)
#rabbit mq consuming
def listen_to_queue():
    parameters = pika.URLParameters('amqp://localhost:5672')
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()
    exchange_name = 'test1'
    channel.exchange_declare(exchange=exchange_name, exchange_type='direct')
    # Declare the queue we will consume from and bind it to the exchange
    queue_name = 'my-queue1'
    channel.queue_declare(queue=queue_name)
    channel.queue_bind(exchange=exchange_name, queue=queue_name, routing_key='test1')
    def callback(ch, method, properties, body):
        #print('Received message:', body)
        #DATA
        dataset = pd.DataFrame(json.loads(body.decode())['data'])
        #Statistique nbr de peice battons
        test = sns.countplot(x="Nombre pieces principales", data=dataset)
        x_data = [float(tick.get_text()) for tick in test.get_xticklabels()]
        y_data = [patch.get_height() for patch in test.patches]
        max_x = max(x_data)
        max_y = max(y_data)
        #statistique range de prix  camembert
        ranges = [(0, 250000), (250000, 500000), (500000, 750000), (750000, 1000000), (1000000, np.inf)]
        total_rows = len(dataset)
                # initialize a dictionary to store the percentages
        percentages = {}
        most_frequent_type_local = dataset["Type local"].mode()[0]
        print("Le type local le plus fréquent est :", most_frequent_type_local)
        moyen_prix =  dataset["Valeur fonciere"].mean()/100
        # calculate the percentage of rows in each price range          moyen prix top commune  nombre de transactions
        for r in ranges:
            count = len(dataset[(dataset['Valeur fonciere'] >= r[0]) & (dataset['Valeur fonciere'] < r[1])])
            percentage = round(count / total_rows * 100, 2)
            label = '{}k-{}k'.format(r[0] // 1000, r[1] // 1000)
            percentages[label] = percentage


        data_result = {'axe_x': x_data, 'axe_y': y_data ,'max_x':max_x ,'max_y':max_y ,'percentages':percentages , 'nbr_transaction':total_rows , 'moyen_prix':moyen_prix , "type_local": most_frequent_type_local}
        # send message to connected clients
        print(data_result)
        queue.put(data_result)
    channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)
    print('Waiting for messages...')
    channel.start_consuming()
    connection.close()
    print("Rabbitmq close:") 

# async def echo(websocket):
#     async for message in websocket:
#         print("recieved message")
#         while True :
#             if queue.not_empty():
#                 data = queue.get()
#                 await websocket.send(data)

# async def main():
#     async with serve(echo, "192.168.1.251", 3333,):
#         await asyncio.Future()  # run forever
@sio.event
def connect(sid, environ):
        print(f'Connected: {sid}')
        print("done")
        while True:
                # check if there are any messages in the queue
                if not queue.empty():
                    # get the message from the queue
                    message = queue.get()
                    # emit the message to all connected clients
                    sio.emit(event="hello", data=message)#, to=sid)
                    print("sentto"+sid)
                    break
        return connect        
         
                    

    
@sio.event
def disconnect(sid):
        print(f'Disconnected: {sid}')

if __name__ == '__main__':
    # start the SocketIO server
    Rabbit_thread = threading.Thread(target=listen_to_queue, args=())
    Rabbit_thread.start()
    port = 3333
    print('Server started on port 3333')
    eventlet.wsgi.server(eventlet.listen(('', port)), app)
 
   
