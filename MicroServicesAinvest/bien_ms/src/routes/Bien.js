import express from "express";
import {getAllBiens,getUniqueCommunesAndSections,getBiensVendu} from "../controllers/Bien.js";
import {getBiensVendus} from "../controllers/BienProvider.js";

const router = express.Router();

router
  .route("/")
  .get(getAllBiens);
  
router
.route("/PublishFilterStat")
.post(getBiensVendus);
  
router
.route("/getBiensVendu")
.post(getBiensVendu);

router.route("/getSections")
.get(getUniqueCommunesAndSections)



  export default router