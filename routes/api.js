var express = require('express');
var router = express.Router();

var xmlparser = require('express-xml-bodyparser');

router.use(xmlparser());

router.post('/check', function(req, res, next) {
    let errors = [];
    try{
        let xml = req.body;
    }catch (error) {

    }
    res.json({
        "errors": errors,
        "xmlValid": errors.length === 0
    });
});

module.exports = router;
