import mongoose from "mongoose";

const { Schema } = mongoose;

const UserDataSchema = new Schema({
  User: {type: mongoose.Schema.Types.ObjectId
    ,  ref : "User"},
    Properties : {type: [mongoose.Schema.Types.ObjectId]
      ,  ref : "bien" },
    Transactions: { type: [mongoose.Schema.Types.ObjectId]
    ,  ref : "transaction" },
  TotalRoi:{ type: Number},
  Level: { type: Number},
  Experience: { type: Number },
  Acheivments:{ type: [String]},

});

const Userdata = mongoose.model("userdata", UserDataSchema);

export { Userdata };
