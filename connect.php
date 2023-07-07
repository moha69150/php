<?php

require_once "config.php";

try{
   
   $pdo = new PDO("mysql:host=". DB_SERVER. ":3308;dbname=". DB_NAME, DB_USERNAME, DB_PASSWORD); 
   
   }
   catch(Exception $e)

   {
       echo $e->getMessage();
       die("ERREUR : Impossible de se connecter. ");

   }
   

?>