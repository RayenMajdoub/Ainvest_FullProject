const nodemailer = require("nodemailer");
const { google } = require("googleapis");
const CLIENT_ID = process.env.CLIENT_ID;
const CLIENT_SECRET = process.env.CLIENT_SECRET;
const REDIRECT_URI = "https://developers.google.com/oauthplayground";
const REFRESH_TOKEN = process.env.REFRESH_TOKEN;
const OAuth2Client = new google.auth.OAuth2(
  CLIENT_ID,
  CLIENT_SECRET,
  REDIRECT_URI
);
OAuth2Client.setCredentials({ refresh_token: REFRESH_TOKEN });
// console.log(OAuth2Client.getAccessToken())
const sendVerificationEmail = async (email, Actor) => {
  try {
    const { token } = await OAuth2Client.getAccessToken();
    console.log(token)
    const transport = nodemailer.createTransport({
      service: "gmail",
      auth: {
        type: "OAuth2",
        user: process.env.USER,
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        refreshToken: REFRESH_TOKEN,
      },
    });
   
    const mailOptions = {
      from: process.env.USER,
      to: email,
      subject: "Verify your email",
      html: `<h1>Click on the link to verify your email</h1>
            <a href="http://localhost:${
              process.env.PORT || 5000
            }/${Actor}/verify/${token}">Verify</a>`,
    };
    await transport.sendMail(mailOptions);
    return token;
  } catch (err) {
    throw err;
  }
};

const sendForgetPasswordMail = async (email) => {
  try {
    let generatedCode = Math.floor(1000 + Math.random() * 9000);
    const transport = nodemailer.createTransport({
      service: "gmail",
      auth: {
        type: "OAuth2",
        user: process.env.USER,
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        refreshToken: REFRESH_TOKEN,
      },
    });
    const mailOptions = {
      from: process.env.USER,
      to: email,
      subject: "Forget Password",
      html: `<h1>Forget password code:</h1>
                  <p>${generatedCode}</p>`,
    };
    await transport.sendMail(mailOptions);
    return generatedCode;
  } catch (err) {
    throw err;
  }
};

module.exports = { sendVerificationEmail, sendForgetPasswordMail };
