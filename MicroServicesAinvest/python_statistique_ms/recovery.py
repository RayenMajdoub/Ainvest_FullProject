import json
import pandas as pd
import seaborn as sns
import pika
import socket
import threading

# Set up RabbitMQ connection parameters
parameters = pika.URLParameters('amqp://localhost:5672')
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

# Declare the exchange we will consume from
exchange_name = 'test1'
channel.exchange_declare(exchange=exchange_name, exchange_type='direct')

# Declare the queue we will consume from and bind it to the exchange
queue_name = 'my-queue1'
channel.queue_declare(queue=queue_name)
channel.queue_bind(exchange=exchange_name, queue=queue_name, routing_key='test1')

# Define a Socket.IO event handler for processing data
def process_data(sid, data):
    print("Received data:", data)
    socketio.emit('data_processed', data)

# Define a function to handle incoming messages
def callback(ch, method, properties, body):
    data = json.loads(body)
    print("Received message:", data)
    process_data(None, data)

# Define a function to start consuming messages from the queue
def consume():
    # Start consuming messages from the queue
    print('Waiting for messages...')
    channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)
    channel.start_consuming()

# Create a new thread to run the consume function
thread = threading.Thread(target=consume)
thread.start()

# Define a Socket.IO server
socketio = socket.socket()
socketio.bind(('localhost', 5000))
socketio.listen()

# Define a function to handle incoming Socket.IO connections
def handle_client(client):
    # Receive data from the client
    request = client.recv(1024)
    if request:
        # Parse the incoming data as JSON
        data = json.loads(request.decode('utf-8'))
        # Call the process_data function with the received data
        process_data(None, data)

    # Close the client connection
    client.close()

# Define a function to accept incoming Socket.IO connections
def accept_connections():
    while True:
        # Accept incoming connections
        client, address = socketio.accept()
        # Create a new thread to handle each incoming connection
        client_thread = threading.Thread(target=handle_client, args=(client,))
        client_thread.start()

# Create a new thread to accept incoming Socket.IO connections
thread = threading.Thread(target=accept_connections)
thread.start()
