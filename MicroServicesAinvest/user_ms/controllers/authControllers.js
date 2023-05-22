const bcrypt = require("bcryptjs");
const { generateAuthToken } = require("../utils/generateAccessToken");
const UserModel = require("../models/user");
const appError = require("../middlewares/error");
const { OAuth2Client } = require("google-auth-library");
const { AUTH_ROLES } = require("../middlewares/auth");
const {
  sendVerificationEmail,
  sendForgetPasswordMail,
} = require("../utils/sendMail");
const client = new OAuth2Client();
async function signInUser(req, res) {
  try {
    const { email, password } = req.body;
    const user = await UserModel.findOne({ email }).lean();
    if (!user) throw new appError("No user found!", 404);
    if (user && user.ban) {
      throw new appError("you are banned", 401);
    }
    let checkPassword = await bcrypt.compare(password, user.password);
    if (!checkPassword) throw new appError("UnAuthorized user!", 401);
    if (!user.verified) throw new appError("Please verify your email!", 401);
    const token = generateAuthToken(user, AUTH_ROLES.USER);
    delete user.password;
    res.status(200).json({ user, token });
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function editUserInformations(req, res) {}

async function signUp(req, res) {
  try {
    const { password, email } = req.body;
    const checkIfUserExist = await UserModel.findOne({ email }).lean();
    if (checkIfUserExist) {
      throw new appError("email already exist", 409);
    }
    const accessToken = await sendVerificationEmail(email, "users");
    const registredUser = {
      ...req.body,
      password: bcrypt.hashSync(password, 12),
      accessToken,
    };
    const user = await UserModel.create(registredUser);

    res.status(201).json(user);
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function verifyAccount(req, res, next) {
  try {
    const { accessToken } = req.params;
    const user = await UserModel.findOne({ accessToken }).lean();
    if (!user) throw new appError("UnAuthorized user!", 401);
    await UserModel.findOneAndUpdate(
      { _id: user._id },
      {
        $set: {
          verified: true,
        },
      }
    ).lean();
    res.status(200).json({
      message: "user verified!",
    });
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function signInWithGoogle(req, res) {
  try {
    const { idToken } = req.body;
    if (!idToken) throw new appError("Missing Google login infos!", 400);
    let response = await client.verifyIdToken({
      idToken,
    });
    const { email } = response.payload;
    console.log(email);
    if (!email) {
      throw new appError("email does not exist!", 400);
    }
    let user = await UserModel.findOne({ email });
    if (user) {
      const token = generateAuthToken(user, AUTH_ROLES.USER);
      res.json({
        user,
        token,
      });
    } else {
      let password = bcrypt.hashSync(email, 12);
      user = new UserModel({
        lastName: "ainvest-LastnameUser",
        firstName: "ainvest-FirstnameUser",
        email,
        username: "ainvest",
        password,
        verified: true,
      });
      let info = await user.save();
      const token = generateAuthToken(user, AUTH_ROLES.USER);
      res.json({
        user: info,
        token,
      });
    }
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function forgetPassword(req, res, next) {
  try {
    const { email } = req.body;
    console.log(email);
    const user = await UserModel.findOne({ email }).lean();
    if (!user) {
      throw new appError("user not found!", 404);
    }
    let otpCode = await sendForgetPasswordMail(email);
    await UserModel.findOneAndUpdate(
      { email },
      {
        $set: {
          otpCode,
        },
      }
    );
    res.status(200).json({ otpCode });
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function changePassword(req, res, next) {
  try {
    const { newPassword, newPasswordConfirmation, otpCode, email } = req.body;
    const user = await UserModel.findOne({ email }).lean();
    if (!user) {
      throw new appError("user not found!", 404);
    }
    if (newPassword !== newPasswordConfirmation) {
      throw new appError("password mismatch!", 400);
    }
    if (otpCode != user.otpCode) {
      throw new appError("otp code mismatch!", 400);
    }
    await UserModel.findOneAndUpdate(
      { email },
      {
        $set: {
          password: bcrypt.hashSync(newPassword, 12),
          otpCode: Math.floor(1000 + Math.random() * 9000),
        },
      }
    );
    res.status(200).json({ message: "Password Changed Successfully!" });
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function userList(req, res) {
  try {
    const users = await UserModel.find({ role: "admins" }).lean();
    if (!users) {
      throw new appError("users not found!", 404);
    }
    res.status(200).json(users);
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function banUser(req, res){
  try {
    const {userId} = req.params;
    const user = await UserModel.findById(userId).lean();
    if(!user){
      throw new Error("user not found", 404);
    }
    await UserModel.findByIdAndUpdate(userId, {
      $set: {
        ban: true,
      },
    })
    res.status(200).json("user banned!");
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}

async function unBanUser(req, res){
  try {
    const {userId} = req.params;
    const user = await UserModel.findById(userId).lean();
    if(!user){
      throw new Error("user not found", 404);
    }
    await UserModel.findByIdAndUpdate(userId, {
      $set: {
        ban: false,
      },
    })
    res.status(200).json("user unbanned!");
  } catch (error) {
    res.status(error.code || 500).json({ message: error.message });
  }
}
module.exports = {
  signInUser,
  signUp,
  verifyAccount,
  signInWithGoogle,
  forgetPassword,
  changePassword,
  userList,
  unBanUser,
  banUser
};
