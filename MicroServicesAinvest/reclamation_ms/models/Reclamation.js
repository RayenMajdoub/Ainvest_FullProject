const mongoose = require("mongoose");

const reclamationSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  status: {
    type: String,
    enum: ["pending", "done", "canceled", "not_visualized"],
    default: "pending",
  },
  description: {
    type: String,
    required: true,
  },
  response: {
    type: String,
    default: "",
  },
  date: {
    type: Date,
    default: Date.now(),
  },
  image: {
    type: String,
    default: "",
  },
});

const Reclamation = mongoose.model("Reclamation", reclamationSchema);

module.exports = Reclamation;
