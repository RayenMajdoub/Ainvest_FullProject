import Immobiliers from "../models/immobilier.js";




export async function createAgence(req,res) {
  const { TypeLocal, adresse, TypePro, Nom } = req.body;
  const immobilier = new Immobiliers();
  immobilier.TypeLocal = TypeLocal;
  immobilier.adresse = adresse;
  immobilier.TypePro = TypePro;
  immobilier.Nom = Nom;
  await immobilier.save();
  res.status(201).send(immobilier);
}

export async function getAllAgences(req, res){
  const { TypeLocal } = req.query;
  let query = {};
  if (TypeLocal) {
    query.TypeLocal = TypeLocal;
  }
  const immobiliers = await Immobiliers.find(query);
  res.status(200).send({ immobiliers });
}

export async function getTypeLocalAgences(req, res){
    const TypeLocal = req.body.TypeLocal
    const adresse = req.body.adresse
    const TypePro = req.body.TypePro

    const agences = await Immobiliers.find({ TypeLocal : TypeLocal ,adresse : adresse,TypePro : TypePro});
    res.status(200).send(agences);
  }


export async function getAgenceById(req, res){
  const id = req.params.id;
  console.log(id);
  const immobilier = await Immobiliers.findById(id);
  res.status(200).send(immobilier);
}

export async function updateAgence(req, res){
  const { idagence, TypeLocal, adresse, TypePro, Nom } = req.body;
  const immobilier = await Immobiliers.findById(idagence);
  if (immobilier) {
    immobilier.TypeLocal = TypeLocal;
    immobilier.adresse = adresse;
    immobilier.TypePro = TypePro;
    immobilier.Nom = Nom;   
    await immobilier.save();
    res.status(201).send(immobilier);
  } else {
    res.status(404).send("Agence immobilière non trouvée.");
  }
}