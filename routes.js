const { Router } = require('express');
const router = Router();

router.use('/users', require('./agencies'));

module.exports = {
  router
}