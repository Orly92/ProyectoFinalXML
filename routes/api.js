var express = require('express');
var router = express.Router();
var validator = require('xsd-schema-validator');
var fs = require('fs');
const xmlProc = require('xslt-processor');

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

router.post('/process', function(req, res, next) {
    try{
        let xmlStr = req.rawBody;
        let directoryPath = 'sitioWeb/resultados';
        let xmlCopied = false;
        fs.writeFile(`${directoryPath}/result.xml`,xmlStr,(err,result)=>{
            if(err && !result)
                res.json({
                    "result": "Error 500",
                    "valid": null,
                    "messages": [err.message],
                    xmlCopied:xmlCopied
                });
            else{
                xmlCopied = true;
                fs.readFile('xml/transformToHTML.xsl','utf8',(err,data)=>{
                    const outXmlString = xmlProc.xsltProcess(
                        xmlProc.xmlParse(xmlStr),
                        xmlProc.xmlParse(data)
                    );

                    fs.writeFile(`${directoryPath}/result.html`,outXmlString,(err,result)=>{
                        if(err && !result)
                            res.json({
                                "result": "Error 500",
                                "valid": null,
                                "messages": [err.message],
                                 xmlCopied:xmlCopied,
                                htmlCopied:false
                            });
                        else{
                            res.json({
                                "result": "ok",
                                "success": true,
                                "messages": [],
                                xmlCopied:xmlCopied,
                                htmlCopied:true,
                                ...result
                            });

                        }
                    });
                });

            }
        });
    }catch (error) {
        res.statusCode = 500;
        res.json({
            "result": "Error 500",
            "success": false,
            "messages": [error.message]
        });
    }

});

module.exports = router;
