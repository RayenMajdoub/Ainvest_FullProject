require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const port = process.env.PORT || 3333;

// Import property routes
const propertyRoutes = require('./Routes/property.routes');

// Use body-parser middleware to parse incoming requests
app.use(bodyParser.json());

// Use property routes as middleware
app.use('/properties', propertyRoutes);

// Use payement as middleware for /paiement route

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
