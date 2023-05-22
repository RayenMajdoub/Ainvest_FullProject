const express = require('express');
const propertyController = require('../Controllers/property.controller');
const propertyMiddleware = require('../Middlewares/property.middleware');

const router = express.Router();

// Create a new property
router.post('/', propertyMiddleware.validateCreateProperty, propertyController.createProperty);

// Get a property by ID
router.get('/:id', propertyController.getPropertyById);

// Get all properties
router.get('/', propertyController.getAllProperties);

// Payment sheet

module.exports = router;
