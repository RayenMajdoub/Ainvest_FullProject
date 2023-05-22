require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const port = process.env.PORT || 3333;

// Import property routes
const { payement } = require('./Controllers/paiement');

// Use body-parser middleware to parse incoming requests
app.use(bodyParser.json());

// Use property routes as middleware

// Use payement as middleware for /paiement route
app.get('/paiement', payement);

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
}).then(() => {
  console.log('Connected to MongoDB');
}).catch((err) => {
  console.error('Error connecting to MongoDB', err);
});

// Start the server
app.listen(port ,()=> {
  console.log(`Server listening on port ${port}`);
});
