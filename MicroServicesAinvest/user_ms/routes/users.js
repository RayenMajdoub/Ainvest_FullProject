var express = require("express");
const {
  signUp,
  signInUser,
  verifyAccount,
  signInWithGoogle,
  forgetPassword,
  changePassword,
  userList,
  banUser,
  unBanUser
} = require("../controllers/authControllers");
var router = express.Router();

router.post("/signup", signUp);
router.post("/signin", signInUser);
router.get("/verify/:accessToken", verifyAccount);
router.post("/signingoogle", signInWithGoogle);
router.post("/forgetPassword", forgetPassword);
router.post("/changePassword", changePassword);
router.get("/userslist", userList);
router.post("/banuser/:userId", banUser)
router.post("/unbanuser/:userId", unBanUser)

module.exports = router;
