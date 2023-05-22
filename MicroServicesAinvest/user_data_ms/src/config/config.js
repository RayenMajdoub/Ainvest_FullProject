import * as dotenv from "dotenv";


  dotenv.config();

export  const Config = {
  PORT: process.env.PORT,
  DB_URL: process.env.DBNAME,
  APP_SECRET: process.env.APP_SECRET,
  BASE_URL: process.env.BASE_URL,
  EXCHANGE_NAME: process.env.EXCHANGE_NAME,
  MSG_QUEUE_URL: process.env.MSG_QUEUE_URL,
  BIEN_SERVICE: "bien_service",
  MARKETPLACE_SERVICE: "marketplace_service",
  STATISTIQUE_SERVICE: "statistique_"
};