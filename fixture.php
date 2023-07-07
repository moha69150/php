<?php 
// Fixture => créé un utilisateur admin prédéfinis
require_once "connect.php";
$pdo = connect();
$mdp = password_hash('admin', PASSWORD_BCRYPT);
$sql = "INSERT INTO utilisateur(nom, prenom, nomusers, pass, rôle) VALUES ('admin', 'user', 'admin.user', :pass ,'admin')";
$stmt = $pdo->prepare($sql);
$stmt->execute([
    "pass" => $mdp
]);