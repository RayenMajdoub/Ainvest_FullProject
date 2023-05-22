import socketio
import pika
import threading
from queue import Queue
# create a Socket
import eventlet

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
        print('Received message:', body)
        # send message to connected clients
        queue.put("body.decode")
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
                    print(message)
                    # emit the message to all connected clients
                    sio.emit(event="hello", data=message, to=sid)
                    print(message)
                    break
    
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
 
   

