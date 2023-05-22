const Reclamation = require ("../models/reclamation");
const path = require("path");

exports.getAll = async (req, res) => {
    res.send({reclamations: await Reclamation.find()});
};

exports.add = async (req, res) => {
    const {
        user,
        status,
        description,
        response,
    } = req.body;

    console.log(req.body)
    let imageId;

    console.log(req.file)

    if (req.file) {
        imageId = req.file.filename
    }

    try {
        let reclamation = await new Reclamation({
            user,
            status,
            description,
            response,
            image: imageId
        })

        await reclamation.save();
        return res.send({message: "Reclamation added successfully", reclamation});
    } catch (error) {
        console.log(error)
        return res.status(500).send({message: error});
    }
};

exports.update = async (req, res) => {
    const {
        _id,
        user,
        status,
        description,
        response,
    } = req.body;

    let imageId;

    if (req.file) {
        imageId = req.file.filename
    }

    try {
        let reclamation = await Reclamation.findById(_id);

        if (reclamation) {
            reclamation.user = user ? user : reclamation.user
            reclamation.status = status ? status : reclamation.status
            reclamation.description = description ? description : reclamation.description
            reclamation.response = response ? response : reclamation.response
            reclamation.date = Date.now()
            reclamation.image = imageId ? imageId : reclamation.image
        }

        await reclamation.save()
        return res.send(reclamation);
    } catch (error) {
        console.log(error)
        return res.status(500).send({message: error});
    }
};

exports.delete = async (req, res) => {
    console.log(req.body)
    await Reclamation.findById(req.body._id)
        .then(function (reclamation) {
            reclamation.remove();

            return res.status(200).send({message: "Reclamation deleted"});
        }).catch(function (error) {
            console.log(error)
            res.status(500).send();
        });
};