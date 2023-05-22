// Validate request body when creating a new property
const validateCreateProperty = (req, res, next) => {
    const { title, desc, location, "Valeur fonciere": price, "Nombre pieces principales": rooms, "Nombre de lots": bathrooms, isForSale, isForRent } = req.body;
    if (!title || !desc || !location || !price || !rooms || !bathrooms || (isForSale && isForRent) || (!isForSale && !isForRent)) {
      return res.status(400).json({ error: 'Invalid property information' });
    }
    next();
  };
  
  module.exports = {
    validateCreateProperty
  };
  