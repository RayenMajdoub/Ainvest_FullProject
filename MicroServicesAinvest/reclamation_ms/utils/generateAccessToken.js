const { sign } = require("jsonwebtoken");
const generateAuthToken = (payload, role) => {
  const token = sign(
    { _id: payload._id, role: role },
    process.env.TOKEN_SECRET,
    {
      expiresIn: "7d",
    }
  );
  return token;
};
module.exports = {
  generateAuthToken,
};
