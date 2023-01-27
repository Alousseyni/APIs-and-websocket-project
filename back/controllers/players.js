const express = require('express');
const mysql = require('mysql2');
const jwt = require("jsonwebtoken");
// database
const conx = mysql.createConnection({
    host:'localhost',
    user:'root',
    database:'arch_rep'
  });

exports.getListClub=(req,res,next)=>{
  conx.query("select id, nom, logo from clubs", function(err,data,fields){
      if(err){
          res.status(500).send(err)
      }
      else{
          res.status(200).send({clubs: data});
      }
  })
}

exports.getOneMatch=(req,res,next)=>{
  let id = req.params.id
  try{
      conx.query(
          `SELECT m.id, m.id_guest, m.id_visitor, 
          (select nom from clubs where clubs.id = m.id_guest) as 'name_guest',
          (select logo from clubs where clubs.id = m.id_guest) as 'logo_guest',
          (SELECT ville from clubs where clubs.id = m.id_guest) as 'city', 
          (select nom from clubs where clubs.id = m.id_visitor) as 'name_visitor',
          (select logo from clubs where clubs.id = m.id_visitor) as 'logo_visitor',
          m.score_guest, m.score_visitor, m.date 
          from matches AS m where m.id = ${id}`, function(err,data,fields){
          if(err){
              res.status(500).send({msg:"Une erreur s'est produite"+err})
          }
          else{
              res.status(200).send({matche: data[0]});
          }
      })
  }
  catch(error){
      res.send({msg:"error",error})
  }
}

exports.getAllMatches=(req,res,next)=>{
  try{
      conx.query(
          `SELECT m.id, m.id_guest, m.id_visitor, 
          (select nom from clubs where clubs.id = m.id_guest) as 'name_guest',
          (select logo from clubs where clubs.id = m.id_guest) as 'logo_guest',
          (SELECT ville from clubs where clubs.id = m.id_guest) as 'city', 
          (select nom from clubs where clubs.id = m.id_visitor) as 'name_visitor',
          (select logo from clubs where clubs.id = m.id_visitor) as 'logo_visitor',
          m.score_guest, m.score_visitor, m.date 
          from matches AS m`, function(err,data,fields){
          if(err){
              res.status(500).send({msg:"Une erreur s'est produite"+err})
          }
          else{
              res.status(200).send({matches: data});
          }
      })
  }
  catch(error){
      res.send({msg:"error",error})
  }
}
//app.use(express.urlencoded({extended:false}))
// app.use(express.json())
exports.createMatch=(req,res,next)=>{
  let matche = req.body;
  conx.execute("insert into matches (id_guest, id_visitor, date) values('"+Object.values(matche).join("','")+"')", function(err,result,fiels){
      if(err){
          res.status(501).send({error:err})
      }
      res.status(201).send({message:'Ok'})
  })
}

exports.modifyScore=(req,res,next)=>{
  let scores = req.body;
  conx.execute("update matches set score_guest = "+scores.guest+", score_visitor = "+scores.visitor+" where id = "+req.params.id, function(err,result,fiels){
      if(err){
          res.status(500).send({error:err})
      }
      res.status(200).send({message:'Score bien mis à jour'})
  })
}

exports.deletePlayer=(req,res,next)=>{
  let id = req.params.id;
  console.log("id = ","delete from matches where id = "+id)
  conx.execute("delete from matches where id = "+id, function(err,rslt,fields){
      console.log("err = ",err," rslt = ",rslt," fileds = ",fields)
      if(err){
          console.log(err)
          res.status(500).send({error:err})
      }
      res.status(200).send({message:'Suppression du matche '+id+' bien effectuée'})
  })
}
// se connecter
exports.login = (req, res, next)=>{
    const user = req.query.user;
    const password = req.query.password;
    conx.execute(
      "select id, nom, role, password from users where nom = ?",
      [user],
      function (err, data) {
        if (err) {
          res.status(500).send({ error: err });
        } else if (data.length < 1) {
          res.status(401).send({ msg: "Utilisateur inconnu" });
        } else {
          if (password === data[0].password) {
            const token = jwt.sign(
              { id: data[0].id, role: data[0].role },
              "arch_rep",
              { expiresIn: "24h" }
            );
            res.status(200).send({
              jwt: token,
              userName: data[0].nom,
              userId: data[0].id,
              role: data[0].role,
            });
          } else {
            res.status(401).send({ msg: "Mot de passe incorrect" });
          }
        }
      }
    );
  }