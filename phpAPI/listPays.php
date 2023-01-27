<?php

    header('Access-Control-Allow-Origin: *'); //header('Access-Control-Allow-Origin: '.$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Headers: X-Requested-With, Access-Control-Allow-Headers,Access-Control-Allow-Methods, Content-Type, Origin');
    header('Content-Type: Application/json');
    header('Access-Control-Allow-Methods: GET');
    require ('../Connexion.inc.php');

    $pays = $conx->query("select id, nom AS 'Nom' from pays")->fetchall(PDO::FETCH_ASSOC);
    $json = json_encode($pays);
    echo $json;
    //print_r($pays);
?>