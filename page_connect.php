<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href=<?php "'". __DIR__."asset/style.css" . "'"?> rel="stylesheet">
    </head>
    <body >
    
    <h2>
        <?php
        session_start();
        var_dump($_SESSION);
        $nom = $_SESSION["nom_complet"];
        echo "bienvenue $nom";
        //echo $_SESSION["role"];
        ?>
        <?php 
        // Gestion du role 
        // Accés Admin => session admin
        if($_SESSION["role"] == "ROLE_ADMIN"){
            echo "<a href=admin_page.php>ADMIN</a>";
        } 
        ?>

    </h2>
        [ <a href="deconnexion.php">Se déconnecter</a> ]
    </body>
</html> 
