import { Bien } from "../models/UserData.js"; // add validate
import { APIError,STATUS_CODES } from "../middlewares/app-errors.js";
import { FormateData } from "../middlewares/utility.js";



export  async function getAllBien() {
  try{
  const biens = await Bien.find({});
      return FormateData(biens)
    }
     catch(err){
      //res.status(500).json({ error: err });
      throw  APIError('API ERROR',STATUS_CODES.INTERNAL_ERROR,"Unable To getAllBien")
    };
}

export async function searchBien(queryparam) {
  try {
    let query = {};
console.log(queryparam)
    if (queryparam["Date mutation"]) {
      const date = new Date(queryparam["Date mutation"]);
      query["Date mutation"] = { $gte: date };
    }

    if (queryparam["Nature mutation"]) {
      query["Nature mutation"] = queryparam["Nature mutation"];
    }

    if (queryparam["Valeur fonciere"]) {
      const value = parseInt(queryparam["Valeur fonciere"]);
      query["Valeur fonciere"] = { $gte: value };
    }

    if (queryparam["Type de voie"]) {
      query["Type de voie"] = queryparam["Type de voie"];
    }

    if (queryparam["Voie"]) {
      query["Voie"] = queryparam["Voie"];
    }

    if (queryparam["Code postal"]) {
      const codePostal = parseInt(queryparam["Code postal"]);
      query["Code postal"] = codePostal;
    }

    if (queryparam["Commune"]) {
      query["Commune"] = queryparam["Commune"];
    }

    if (queryparam["Code departement"]) {
      const codeDept = parseInt(queryparam["Code departement"]);
      query["Code departement"] = codeDept;
    }

    if (queryparam["Code commune"]) {
      const codeCommune = parseInt(queryparam["Code commune"]);
      query["Code commune"] = codeCommune;
    }

    if (queryparam["Section"]) {
      query["Section"] = queryparam["Section"];
    }

    if (queryparam["No plan"]) {
      const noPlan = parseInt(queryparam["No plan"]);
      query["No plan"] = noPlan;
    }

    if (queryparam["Nombre de lots"]) {
      const nbLots = parseInt(queryparam["Nombre de lots"]);
      query["Nombre de lots"] = nbLots;
    }

    if (queryparam["Type local"]) {
      query["Type local"] = queryparam["Type local"];
    }

    if (queryparam["Surface reelle bati"]) {
      const surface = parseInt(queryparam["Surface reelle bati"]);
      query["Surface reelle bati"] = { $gte: surface };
    }

    if (queryparam["Nombre pieces principales"]) {
      const nbPieces = parseInt(queryparam["Nombre pieces principales"]);
      query["Nombre pieces principales"] = { $gte: nbPieces };
    }

    if (queryparam["Nature culture"]) {
      query["Nature culture"] = queryparam["Nature culture"];
    }

    if (queryparam["Surface terrain"]) {
      const surfaceTerrain = parseInt(queryparam["Surface terrain"]);
      query["Surface terrain"] = { $gte: surfaceTerrain };
    }

    const results = await Bien.find(query).exec();
    return FormateData(results)
  } catch (error) {
    throw  APIError('API ERROR',STATUS_CODES.INTERNAL_ERROR,"Unable To getAllBien")
  }
}



/*
export async function getBienByFilters(req, res) {
  Bien.find({})
  .where("team").equals(req.params.team)
    .then((docs) => {
      res.status(200).json(docs);
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}
export async function getBienById(req, res) {
  Bien.findById(req.params.id)
    .then((docs) => {
      res.status(200).json(docs);
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}


export async function addOnce(req, res) {
  if (!validationResult(req).isEmpty()) {
    res.status(400).json({ errors: validationResult(req).array() });
  } else {
    Bien.create({
      fullname: req.body.fullname,
      phone: req.body.phone,
      team:req.body.team,
      // facon dynamique bech tkhabi lien el image : req.protocol = http , req host = localhost 
      image: `${req.protocol}://${req.get("host")}${process.env.IMGURL}/${
        req.file.filename
      }`,
    })
      .then((docs) => {
        res.status(201).json(docs);
      })
      .catch((err) => {
        res.status(500).json({ error: err });
      });
  }
}

export async function updateOnce(req, res) {
  Bien.findOneAndUpdate(
    { _id: req.params.id },
    {
      Name: req.body.Name,
      Year: req.body.Year,
    }
  )
    .then((docs) => {
      res.status(200).json(docs);
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}

export function deleteOnce(req, res) {
  Bien.findOneAndRemove(req.id, req.body)
    .then((docs) => {
      res.status(200).json(docs);
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}
*/