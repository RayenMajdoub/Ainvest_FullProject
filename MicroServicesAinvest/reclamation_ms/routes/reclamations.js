const router = require("express").Router()
const controller = require("../controllers/reclamationControllers");
const upload = require('../middlewares/storage-images');

router.route("/")
    .get(controller.getAll)

router.route("/one")
    .post(upload.single('image'), controller.add)
    .put(upload.single('image'), controller.update)
    .delete(controller.delete);

module.exports = router