var express = require('express');
var path = require('path');
var multer = require('multer');
var router = express.Router();

const convertBreedNameToFileName = (name) => {
  return name.toLowerCase().replace(" ", "_");
}

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/images/')
  },
  filename: function (req, file, cb) {
    cb(null, convertBreedNameToFileName(req.params.breed) + path.extname(file.originalname));
  }
})

const upload = multer({ storage: storage })

router.post('/:breed', upload.single('dog_image'), function(req, res) {
  if (!req.file) {
    return res.send({success: false});
  } else {
    return res.send({success: true});
  }
});

module.exports = router;
