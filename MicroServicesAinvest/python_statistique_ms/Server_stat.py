import json
import pandas as pd
import seaborn as sns
import pika
from flask import Flask,request
import socketio
app = Flask(__name__)

# Set up RabbitMQ connection parameters
parameters = pika.URLParameters('amqp://localhost:5672')
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

# Declare the input queue
channel.queue_declare(queue='test')

# Declare the result queue
result_topic = 'test'
# Declare the exchange we will consume from
@app.route('/test', methods=['POST'])
def dumytest():
        exchange_name = 'test1'
        channel.exchange_declare(exchange=exchange_name, exchange_type='direct')

        # Declare the queue we will consume from and bind it to the exchange
        queue_name = 'my-queue1'
        channel.queue_declare(queue=queue_name)
        channel.queue_bind(exchange=exchange_name, queue=queue_name, routing_key='test1')

        # Define a callback function to handle incoming messages
        def callback(ch, method, properties, body):
            host = '192.168.1.2'  # replace with the IP address where your Flutter client is running
            port = 3333
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            print("Received message:", body.decode())
            s.connect((host, port))
            print("S connect:") 
            s.send(body)
            print("S send:")  # send the received message to the Flutter client
            s.close()
            print("S CLOSE:")
        # Start consuming messages from the queue
        channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)
        print('Waiting for messages...')
        channel.start_consuming()
        print("Rabbitmq start consuming:") 
# Close the connection when finished
        connection.close()
        print("Rabbitmq close:") 
        return "Data processed successfully."


if __name__ == '__main__':
    app.run(debug=True, port=5000)
