const mongoose = require('mongoose');

const propertySchema = new mongoose.Schema({
    "Date mutation": { type: String, required: true },
    "Nature mutation": { type: String, required: true },
    "Valeur fonciere": { type: Number, required: true },
    "Type de voie": { type: String, required: true },
    "Voie": { type: String, required: true },
    "Code postal": { type: Number, required: true },    
    "Commune": { type: String, required: true },
    "Code departement": { type: Number, required: true },
    "Code commune": { type: Number, required: true },
    "Section": { type: String, required: true },
    "No plan": { type: Number, required: true },
    "Nombre de lots": { type: Number, required: true },
    "Type local": { 
        type: String,
        enum: ['Maison', 'Appartement', 'Dependance', 'Local_industriel'],
        required: true
    },
    "Surface reelle bati": { type: Number, required: true },
    "Nombre pieces principales": { type: Number, required: true },
    "Nature culture": { type: String, required: true },
    "Surface terrain": { type: Number, required: true },
    "title": { type: String, required: true },
    "desc": { type: String, required: true },
    "location": {
        "longitude": {
            type: Number,
            required: true
        },
        "latitude": {
            type: Number,
            required: true
        }
    },
    "isForSale": { 
        type: Boolean,
        default: false,
        validate: {
            validator: function(v) {
                return !(v && this.isForRent);
            },
            message: "A property cannot be both for sale and for rent"
        },
        required: true
    },
    "isForRent": { 
        type: Boolean,
        default: false,
        validate: {
            validator: function(v) {
                return !(v && this.isForSale);
            },
            message: "A property cannot be both for sale and for rent"
        },
        required: true
    },
    "state": { 
        type: String, 
        enum: ['pending', 'sold', 'rented', 'cancelled'],
        required: true
    },
  /*  seller: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
      },*/
    "image": { type: String, required: true }
});

const Property = mongoose.model('Property', propertySchema);

module.exports = Property;
