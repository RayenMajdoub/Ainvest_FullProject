import { APIError,STATUS_CODES } from "../middlewares/app-errors.js";
import { Bien } from "../models/Bien.js";
import { getAllBien ,searchBien } from "../services/Bien.js";
import fs from 'fs';


export  async function getAllBiens(req,res) {
  try{
    const data = await getAllBien()
    console.log(data)
    return res.json(data)
  }
  catch(err)
  {
    res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
 }
  }
  
  export async function getBiensVendu(req,res){
    try
    {
      const data = await searchBien(req.query)
      console.log(data)
      return res.status(STATUS_CODES.OK).json(data)
    }catch {
      res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
   }
  }
  export async function getUniqueCommunesAndSections(req, res) {
    try {
      const pipeline = [
        { $group: { _id: '$Commune', sections: { $addToSet: '$Section' } } }
      ];
      
      const results = await Bien.aggregate(pipeline);
  
      const transformedResults = {};
      results.forEach(({ _id, sections }) => {
        transformedResults[_id] = sections;
      });
      
      const jsonString = JSON.stringify(transformedResults, null, 2);
      console.log(jsonString);
      fs.writeFile('output.json', JSON.stringify(transformedResults, null, 2), (err) => {
        if (err) {
          console.error(err);
        } else {
          console.log('Data written to file');
        }
      });
  
      res.status(200).json(transformedResults);
    } catch (err) {
      console.error(err);
      res.status(500).send('An error occurred while retrieving the data.');
    } 
  }
  