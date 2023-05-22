import express from "express";
import {CreateUserdata,getTransactionsBySearch,AddTransaction,getUserDatabyUserIdPremium,getAllUserData} from "../controllers/Controller.js";

const router = express.Router();

router
.route("/getAllUserData")
.get(getAllUserData)
router
.route("/CreateUserdata")
.post(CreateUserdata)
router
.route("/AddTransaction")
.post(AddTransaction)

router
.route("/getUserDatabyUserIdPremium")
.post(getUserDatabyUserIdPremium)

router
.route("/getTransactionsBySearch")
.post(getTransactionsBySearch)



  export default router