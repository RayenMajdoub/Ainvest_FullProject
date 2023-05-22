import pika
import threading
from queue import Queue

from flask_socketio import SocketIO
import eventlet

queue = Queue()
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')
# socket io 
sio = socketio.Server(cors_allowed_origins='*')    
app = socketio.WSGIApp(sio)

# define a function to emit messages to clients
def emit_message(msg):
    sio.emit('message', msg)

@sio.event
def connect(sid, environ):
    print(f'Connected: {sid}')

@sio.event
def disconnect(sid):
    print(f'Disconnected: {sid}')

def listen_to_queue():
    parameters = pika.URLParameters('amqp://localhost:5672')
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()
    exchange_name = 'test1'
    channel.exchange_declare(exchange=exchange_name, exchange_type='direct')
    queue_name = 'my-queue1'
    channel.queue_declare(queue=queue_name)
    channel.queue_bind(exchange=exchange_name, queue=queue_name, routing_key='test1')
    
    def callback(ch, method, properties, body):
        print('Received message:', body)
        # put message into queue
        queue.put(body.decode())

    channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)
    print('Waiting for messages...')
    channel.start_consuming()
    connection.close()
    print("Rabbitmq close:")

def emit_messages():
    while True:
        if not queue.empty():
            msg = queue.get()
            print('Emitting message:', msg)
        # emit message to connected clients
            sio.emit('message', msg)

if __name__ == '__main__':
    # start the RabbitMQ consumer thread
    Rabbit_thread = threading.Thread(target=listen_to_queue, args=())
    Rabbit_thread.start()

    # start the message emitter function as a background task in the same thread as the server
    app.config['bg_tasks'] = [app.start_background_task(emit_messages)]

    # start the SocketIO server
    port = 3333
    print('Server started on port 3333')
    eventlet.wsgi.server(eventlet.listen(('', port)), app)
