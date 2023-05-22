import mongoose from "mongoose";

const { Schema } = mongoose;

const BienSchema = new Schema({
  "_id": {
    type: mongoose.Schema.Types.ObjectId, 
  },
  "Date mutation" : { type: String},
  "Nature mutation": { type: String},
  "Valeur fonciere": { type: Number},
  "Type de voie": { type: String},
  "Voie":{ type: String},
  "Code postal": { type: Number},
  "Commune": { type: String },
  "Code departement":{ type: Number},
  "Code commune": { type: Number},
  "Section":  { type: String},
  "No plan":{ type: Number},
  "Nombre de lots":{ type: Number},
  "Type local": { type: String},
  "Surface reelle bati":{ type: Number},
  "Nombre pieces principales": { type: Number},
  "Nature culture": { type: String},
  "Surface terrain": { type: Number}
});

const Bien = mongoose.model("bien", BienSchema);

export { Bien };
