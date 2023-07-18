<?php
require_once '../connectbdd.php';

$errorMessage = ''; // Initialiser la variable à une valeur vide

// Vérifier si le formulaire a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupérer les valeurs du formulaire
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Vérifier les informations de connexion dans la base de données
    $sql = "SELECT * FROM users WHERE nomusers = :username AND motdepasse = :password";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(":username", $username);
    $stmt->bindParam(":password", $password);
    $stmt->execute();

    // Vérifier si un enregistrement correspondant a été trouvé
    if ($stmt->rowCount() == 1) {
        // Informations de connexion correctes
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        session_start(); // Démarrer une nouvelle session ou reprendre une session existante
        $_SESSION['userID'] = $user['id']; // Stocker l'ID de l'utilisateur dans la session

        // Rediriger vers la page d'accueil
        header("Location: ../home/home.php");
        exit();
    } else {
        // Informations de connexion incorrectes, définir le message d'erreur
        $errorMessage = "Nom d'utilisateur ou mot de passe incorrect.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - Votre Intranet</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
    <h1>Connexion à l'Intranet</h1>

    <?php if (!empty($errorMessage)): ?>
        <p class="error"><?php echo $errorMessage; ?></p>
    <?php endif; ?>

    <form method="POST" action="index.php">
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" name="username" id="username" required><br>

        <label for="password">Mot de passe :</label>
        <input type="password" name="password" id="password" required><br>

        <input type="submit" value="Se connecter">
    </form>
</body>
</html>
