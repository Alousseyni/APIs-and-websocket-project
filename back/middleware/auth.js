const jwt = require('jsonwebtoken');

module.exports = function(req,res,next){

    const token = req.headers.authorization.split(" ")[1];
    jwt.verify(token,"arch_rep",function(err,payload){
        if(err){
            res.status(401).send({error:err})
        }
        console.log("Token OK ",payload)
        req.payload = payload;
        next()
    })
}