import express from "express";
import * as dotenv from "dotenv";
import morgan from "morgan";
import amqp from "amqplib";

const app = express();
dotenv.config();

const port = 8002//process.env.SERVERPORT;

app.use(morgan("tiny"));

app.use('/first',(req,res,next)=>
{
    return res.status(200).json({"msg": "hello from first"})
})



app.post('/publish', async function(req, res)  {
    try {
  
      console.log("connection")
  
      const connection = await amqp.connect('amqp://localhost:5672');
      const channel = await connection.createChannel();
      const exchangeName = 'test1';
      const routingKey = 'test1';
      const queueName = 'my-queue1';
      await channel.assertQueue(queueName, { durable: false });
      await channel.assertExchange(exchangeName, 'direct', { durable: false });
  
      const message = { text: 'Hello, world!' };
      const messageBuffer = Buffer.from(JSON.stringify(message));
      channel.sendToQueue(queueName, messageBuffer);
      channel.publish(exchangeName, routingKey, messageBuffer);
      console.log("Message sent:"+ JSON.stringify(message));
  
      await channel.close();
      await connection.close();
      res.status(200).json("done")
    } catch (error) {
      console.error(error);
    }
  })
app.use('/',(req,res,next)=>
{
    return res.status(200).json({"msg": "hello from Markerplace"})
})
app.listen(port, () => {
    console.log(`Markerplace running on :${port}`);
  });