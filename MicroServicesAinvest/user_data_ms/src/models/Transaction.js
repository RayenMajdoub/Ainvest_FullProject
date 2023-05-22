import mongoose from "mongoose";

const { Schema } = mongoose;

const TransactionSchema = new Schema({

 State : { type: String},
 Date: { type: String},
 Property: { type: mongoose.Schema.Types.ObjectId,
 ref:"bien"},
  Montant: { type: Number},

});

const Transaction = mongoose.model("transaction", TransactionSchema);

export { Transaction };
