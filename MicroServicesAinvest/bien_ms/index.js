import express from "express";
import * as dotenv from "dotenv";
import morgan from "morgan";
import BienRoutes from "./src/routes/Bien.js"
import { NotFoundError,errorHandler } from "./src/middlewares/error-handler.js";
import connectDb from "./src/config/db.js";
import cors from "cors"

const app = express();
dotenv.config();
app.use(cors());

const port = process.env.SERVERPORT;

app.use(morgan("tiny"));
connectDb()
app.use(express.json());
app.use(express.urlencoded({ extended: true }));





app.use("/", BienRoutes);
app.use(NotFoundError);
app.use(errorHandler);




//publishMessage();

app.listen(port, () => {
  console.log(`Statistique running on :${port}`);
});
