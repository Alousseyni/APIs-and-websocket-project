<?php
    require ('../Connexion.inc.php');

    try{
        $delete = $conx->prepare("delete from clubs where id = ?")->execute(array($_GET['id']));
        http_response_code(202);
        echo "Suppression réussie";
    }
    catch(PDOException $e){
        http_response_code(500);
        echo "Une erreur s'est produite !".$e;
    }
    
?>