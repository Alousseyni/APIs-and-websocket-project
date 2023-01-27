<?php
  
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Headers: X-Requested-With, Access-Control-Allow-Headers,Access-Control-Allow-Methods, Content-Type, Origin');
    header('Content-Type: Application/json');
    header('Access-Control-Allow-Methods: POST');
    require ('../Connexion.inc.php');

    try{
        $values = [];
        $values[] = $_POST['pays'];
        $values[] = "'".$_POST['nom']."'";
        $values[] = "'".$_POST['city']."'";
        $values[] = "'/logos/".$_POST['nom'].".jpg'";
        $sql = "insert into clubs (id_pays, nom, ville, logo) values (".implode(',',$values).")";
        $insert = $conx->prepare($sql)->execute();
        move_uploaded_file($_FILES['logo']['tmp_name'],"logos/".$_POST['nom'].".jpg");
        http_response_code(201);
        echo "Insertion réussie";
    }
    catch(PDOException $e){
        http_response_code(500);
        echo "Une erreur serveur s'est produite ! ".$e;
    }

    
?>