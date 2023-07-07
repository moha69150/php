<?php 

session_start();
// S'assurer que la personne qui arrive sur cette page 
// soit bien un admin et non une personne non-admin
 if($_SESSION["rôle"] == "admin"){
    echo "je suis un admin";
} 
else 
{
    header("location:deconnexion.php");
}