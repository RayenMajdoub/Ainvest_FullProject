
import express from 'express';
import mongoose from 'mongoose';
import AgenceRoutes from './routes/immobilierRoutes.js';

const app = express();
const port = process.env.PORT || 8007;
const databaseName = 'ainvest';

mongoose.set('debug', true);
mongoose.Promise = global.Promise;

mongoose
  .connect(`mongodb://localhost:27017/${databaseName}`)
  .then(() => {
    console.log(`Connected to ${databaseName}`);
  })
  .catch(err => {
    console.log(err);
  });

app.use(express.json());

app.use('/agence', AgenceRoutes);


app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});