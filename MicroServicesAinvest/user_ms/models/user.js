const mongoose = require("mongoose");
const userSchema = new mongoose.Schema(
  {
    firstName: String,
    lastName: String,
    numTel: Number,
    numFix: Number,
    email: String,
    username: String,
    password: String,
    adress: String,
    profileImage: String,
    verified: {
      type: Boolean,
      default: false,
    },
    otpCode: {
      type: String,
    },
    accessToken: String,
    otpCode: String,
    ban: {type: Boolean, default: false},
    role:{type: String, default: "users"}
  },
  { timestamps: true }
);

const User = mongoose.model("User", userSchema);
module.exports = User;
