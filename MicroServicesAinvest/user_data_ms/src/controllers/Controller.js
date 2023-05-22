import { APIError,STATUS_CODES } from "../middlewares/app-errors.js";
import { Userdata } from "../models/UserData.js";
import { Transaction } from "../models/Transaction.js";
import moment from "moment";
import { Bien } from "../models/Bien.js";

export async function getAllUserData(req, res) {
  try {
    const data = await Userdata.find().sort({ Experience: -1 });
    console.log(data);
    return res.json(data);
  } catch (err) {
    res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
  }
}

 export async function getTransactionsBySearch(req, res) {
  try {
    const { userId, month, year, amount } = req.body;

    const userdata = await Userdata.findOne({ User: userId }).populate({
      path: "Transactions",
      model: "transaction",
    });

    let query = {};
    if (month) {
      query["Date.month"] = parseInt(month, 10);
    }
    if (year) {
      const startDate = new Date(`${year}-01-01`);
      const endDate = new Date(`${year}-12-31`);
      query["Date"] = { $gte: startDate, $lte: endDate };
    }
    if (amount) {
      query["Montant"] = { $gte: amount };
    }

    const filteredTransactions = userdata.Transactions.filter((t) => {
      for (let key in query) {
        if (key === "Montant") {
          if (t[key] < query[key]) return false;
        } else if (key === "Date") {
          const transactionDate = new Date(t[key]);
          if (
            transactionDate.getTime() < query[key].$gte.getTime() ||
            transactionDate.getTime() > query[key].$lte.getTime()
          ) {
            return false;
          }
        } else {
          if (
            typeof t[key] === "undefined" ||
            !t[key].toString().match(query[key])
          ) {
            return false;
          }
        }
      }
      return true;
    });

    const sortedTransactions = filteredTransactions.sort((a, b) => {
      const dateA = new Date(a.Date);
      const dateB = new Date(b.Date);
      return dateA - dateB;
    });

    return res.status(200).json(sortedTransactions);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
}

export async function CreateUserdata(req, res) {
  try {
    const userId = req.body.userId;

    const existingUserdata = await Userdata.findOne({ User: userId });
    if (existingUserdata) {
      return res.status(400).json({ error: "User data already exists" });
    }

    const newUserdata = await Userdata.create({
      User: userId,
      Properties: [],
      Transactions: [],
      TotalRoi: 0,
      Level: 1,
      Experience: 0,
      Acheivments: []
    });

    return res.status(200).json(newUserdata);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
}
export async function AddTransaction(req, res) {
  try {
    const { userId, transaction } = req.body;

    const savedTransaction = await Transaction.create(transaction);
    const transactionId = savedTransaction._id;

    const userdata = await Userdata.findOne({ User: userId }).populate({
      path: "Transactions",
      model: "transaction",
    });;
    userdata.Transactions.push(transactionId);

    // Calculate total ROI and update user data
    const totalRoi = calculateROI(userdata.Transactions);
    console.log(totalRoi)
    userdata.TotalRoi = totalRoi;
    // Update user experience and level
    const { Montant } = transaction;
    const { Level, Experience } = userdata;
    const expGain = Math.floor(Montant / 1000) + 1; 
    const newExperience = Experience + expGain;
    const newLevel = Math.floor(newExperience / 100) + 1; 

    // If the user has leveled up, add an achievement
    if (newLevel > Level) {
      userdata.Acheivments.push(`Reached level ${newLevel}!`);
    }

    userdata.Experience = newExperience;
    userdata.Level = newLevel;

    await userdata.save();

    return res.status(200).json(savedTransaction);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
}
  function calculateROI(transactions) {
    const boughtTransactions = transactions.filter(
      (transaction) => transaction.State === "BOUGHT"
    );
    
    let totalROI = 0;
    
    boughtTransactions.forEach((boughtTransaction) => {
      const soldTransaction = transactions.find(
        (transaction) =>
          transaction.State === "SOLD" &&
          transaction.Property.toString() === boughtTransaction.Property.toString()
      );
      
      if (soldTransaction) {
        const roi = ((soldTransaction.Montant - boughtTransaction.Montant) / boughtTransaction.Montant) * 100;
        totalROI += roi;
      }
    });
    
    return totalROI;
  }
  
  export async function getUserDatabyUserIdPremium(req, res) {
    try {
      const userId = req.body.User;
      console.log(userId)
      const userData = await Userdata.findOne({ User: userId }).populate({
      path: "Transactions",
      model: "transaction",
      populate: {
        path: "Property",
        model: Bien
      }
    });
      const boughtProperties = {};
      const soldProperties = {};
      let totalBoughtAmount = 0;
      let totalSoldAmount = 0;
        const lastlist = []
      for (const transaction of userData.Transactions) {
        if (transaction.State === 'BOUGHT') {
          const property = transaction.Property._id;
          const price = parseFloat(transaction.Montant);
          boughtProperties[property] = { price, date: transaction.Date };
          totalBoughtAmount += price;
        } else if (transaction.State === 'SOLD') {
          const property = transaction.Property._id;
          if (boughtProperties[property]) {
            const purchasePrice = boughtProperties[property].price;
            const purchaseDate = boughtProperties[property].date;
            const salePrice = parseFloat(transaction.Montant);
            const saleDate = transaction.Date;
            const roi = ((salePrice - purchasePrice) / purchasePrice) * 100;
            const holdingPeriod = new Date(saleDate) - new Date(purchaseDate);
            const roiPerYear = (roi / (holdingPeriod / (1000 * 60 * 60 * 24 * 365))) || 0;
           const propertyinfo = transaction.Property["Commune"]+" "+ transaction.Property["Section"]
            soldProperties[property] = { propertyinfo,roi, roiPerYear, purchasePrice, salePrice, purchaseDate, saleDate };
            lastlist.push(soldProperties[property])
            totalSoldAmount += salePrice;
            delete boughtProperties[property];
          }
        }
      }
      const data = { soldProperties:lastlist, boughtProperties, totalSoldAmount, totalBoughtAmount, userData };
      return res.status(STATUS_CODES.OK).json(data);

    } catch (err) {
      res.status(STATUS_CODES.INTERNAL_ERROR).json({ error: err });
    }
  }
  