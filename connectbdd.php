<?php

define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'tartetempsion');

try {
    $pdo = new PDO("mysql:host=". DB_SERVER . ";dbname=" . DB_NAME, DB_USERNAME, DB_PASSWORD); 

    // // check connection status
    // echo $pdo->getAttribute(PDO::ATTR_CONNECTION_STATUS);
} catch(Exception $e) {
    echo $e->getMessage();
    die("ERREUR : Impossible de se connecter. ");
}
