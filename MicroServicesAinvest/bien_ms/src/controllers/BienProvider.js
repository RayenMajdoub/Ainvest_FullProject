import { APIError,STATUS_CODES } from "../middlewares/app-errors.js";
import { getAllBien,searchBien } from "../services/Bien.js";
import amqp from "amqplib";



 export async function AllBiens(req,res) {
    try{
      const data = await getAllBien()
      console.log(data)
      return res.json(data)
    }
    catch(err)
    {
      res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
   }
    }

    
    export   async function getBiensVendus(req,res){
      try
      {
        console.log(req.query)
        const data = await searchBien(req.query)
        console.log(data)
        console.log("connection")
        const connection = await amqp.connect('amqp://localhost:5672');
        const channel = await connection.createChannel();
        const exchangeName = 'test1';
        const routingKey = 'test1';
        const queueName = 'my-queue1';
        await channel.assertQueue(queueName, { durable: false });
        await channel.assertExchange(exchangeName, 'direct', { durable: false });
        const message = data;
        const messageBuffer = Buffer.from(JSON.stringify(message));
        channel.sendToQueue(queueName, messageBuffer);
        channel.publish(exchangeName, routingKey, messageBuffer);
        console.log("Message sent:"+ JSON.stringify(message));
        await channel.close();
        await connection.close();
        res.status(200).json("filter published")
      } 
      catch(err)
      {
        res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
     }
      
    }
      

/*
 async function SubscribeEvents(payload){
 
    console.log('Triggering.... Bien Events')

    payload = JSON.parse(payload)

    const { event, data } =  payload;

    const { userId, product, order, qty } = data;

    switch(event){
        case 'GET_ALL_BIENS':
            this.AllBiens(userId,product)
            break;
        case 'REMOVE_FROM_WISHLIST':
            this.AddToWishlist(userId,product)
            break;

        default:
            break;
    }

}*/
