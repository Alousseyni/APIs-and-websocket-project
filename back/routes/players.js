//---------------
const expess =require('express');
const playerCtrl  =require('../controllers/players');
const auth = require('../middleware/auth');
const router= expess.Router();

//--------------------------------
router.post('/createMatche',auth,playerCtrl.createMatch);
router.put('/updateScore/:id',auth,playerCtrl.modifyScore);
router.delete('/deleteMatche/:id',auth,playerCtrl.deletePlayer);
router.get('/Matche/:id',auth,playerCtrl.getOneMatch);
router.get('/listMatches/',auth,playerCtrl.getAllMatches);
router.get('/listClubs',auth,playerCtrl.getListClub);
router.get('/login',playerCtrl.login);

module.exports = router;