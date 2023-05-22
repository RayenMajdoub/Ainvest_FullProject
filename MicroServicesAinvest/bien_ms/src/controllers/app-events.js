// import ShoppingService from "../services/shopping-service.js";
import { SubscribeEvents } from "./BienProvider.js";

export default (app) => {
  app.use('/app-events', async (req, res, next) => {
    const { payload } = req.body;
    console.log("============= Bien Subscriber ================");
    console.log(payload);
    //handle subscribe events
    SubscribeEvents(payload)
    return res.status(200).json({message: 'notified!'});
  });
};
