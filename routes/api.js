var express = require('express');
var router = express.Router();
var validator = require('xsd-schema-validator');

router.post('/check', function(req, res, next) {
    try{
        let xmlStr = req.rawBody;
        validator.validateXML(xmlStr, 'xml/XSDFile.xsd', function(err, result) {
            if(err && !result)
                res.json({
                    "result": "Error 500",
                    "valid": null,
                    "messages": [err.message]
                });
            else
                res.json({
                    ...result
                });
        });
    }catch (error) {
        res.statusCode = 500;
        res.json({
            "result": "Error 500",
            "valid": null,
            "messages": [error.message]
        });
    }

});

module.exports = router;
