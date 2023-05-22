
import express from 'express';

import { createAgence,getAllAgences,getAgenceById,getTypeLocalAgences , updateAgence} from '../controllers/immobilierController.js';
const router = express.Router();

router
  .route('/createAgence')
  .post(createAgence);
  router
  .route('/AllAgences')
  .get(getAllAgences);
  router
  .route('/AgencesById')
  .post(getAgenceById);
  router
  .route('/AgencesTypeLocal')
  .get(getTypeLocalAgences);
  router 
  .route('/updateAgences')
  .post(updateAgence)

  export default router;