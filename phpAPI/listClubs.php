<?php
    /*header('Access-Control-Allow-Origin: *'); //header('Access-Control-Allow-Origin: '.$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Headers: X-Requested-With, Access-Control-Allow-Headers,Access-Control-Allow-Methods, Content-Type, Origin');
    header('Content-Type: Application/json');
    header('Access-Control-Allow-Methods: GET');*/
    
    require ('../Connexion.inc.php');
    try{
        $clubs = $conx->query("select * from clubs")->fetchall(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($clubs);
    }
    catch(PDOException $e){
        http_response_code(500);
        echo "Erreur au niveau du serveur ! ".$e;
    }
    
?>