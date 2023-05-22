const express = require('express');
const payement = require('../Controllers/paiement');

const router = express.Router();


// Payment sheet
router.get('/payment-sheet', payement.payement);

module.exports = router;
