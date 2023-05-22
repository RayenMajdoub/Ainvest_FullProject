var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.json('Welcome to Express');
});

module.exports = router;
