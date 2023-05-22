const Property = require('../Models/PropertyModel');

// Create a new property
const createProperty = async (req, res) => {
  try {
    const { isForSale, isForRent } = req.body;
    if (isForSale && isForRent) {
      return res.status(400).json({ error: 'Property can only be for sale or for rent, not both' });
    }
    const property = new Property(req.body);
    const savedProperty = await property.save();
    res.status(201).json(savedProperty);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get a property by ID
const getPropertyById = async (req, res) => {
  try {
    const property = await Property.findById(req.params.id)
    //.populate('seller');
    if (!property) {
      return res.status(404).json({ error: 'Property not found' });
    }
    res.json(property);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};



// Get all properties
const getAllProperties = async (req, res) => {
  try {
    const properties = await Property.find();
    //.populate('seller');
    console.log(properties);
    res.json(properties);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  createProperty,
  getPropertyById,
  getAllProperties
};
