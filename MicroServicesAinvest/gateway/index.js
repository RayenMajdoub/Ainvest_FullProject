import express from "express";
import * as dotenv from "dotenv";
import morgan from "morgan";
import cors from "cors"
import proxy from "express-http-proxy"
const app = express();
dotenv.config();

const port = 8000//process.env.SERVERPORT;

app.use(morgan("tiny"));

app.use('/User',proxy('http://localhost:8001'))
app.use('/Marketplace',proxy('http://localhost:8002'))
app.use('/Reclamation',proxy('http://localhost:8003'))
app.use('/Payement',proxy('http://localhost:8004'))
app.use('/Post',proxy('http://localhost:8005'))
app.use('/Bien',proxy('http://localhost:8006'))
app.use('/Agence',proxy('http://localhost:8007'))
app.use('/Transactions',proxy('http://localhost:8008'))
app.use('/Statistique',proxy('http://127.0.0.1:5000'))
app.use('/Prediction',proxy('http://127.0.0.1:5001'))
app.use('/MapData',proxy('http://127.0.0.1:5002'))

  
app.use('/',(req,res,next)=>
{
    return res.status(200).json({"msg": "hello from Gateway"})
})
app.listen(port, () => {
    console.log(`Gateway running on :${port}`);
  });