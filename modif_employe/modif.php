<?php
session_start();
require_once '../connectbdd.php';



$userID = $_SESSION['userID'];

// Récupérer les informations de l'utilisateur
$sql = "SELECT * FROM users WHERE id = :userID";
$stmt = $pdo->prepare($sql);
$stmt->bindParam(':userID', $userID);
$stmt->execute();
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    die("Erreur : utilisateur non trouvé");
}

// Traitement du formulaire de modification
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $nomusers = $_POST['nomusers'];
    $password = $_POST['password'];
    $confirmPassword = $_POST['confirmPassword'];

    // Vérifier si les mots de passe correspondent
    if ($password !== $confirmPassword) {
        $errorMessage = "Les mots de passe ne correspondent pas.";
    } else {
        // Vérifier si le champ du mot de passe est vide pour conserver le mot de passe existant
        if (empty($password)) {
            $password = $user['motdepasse'];
        } else {
            $password = password_hash($password, PASSWORD_DEFAULT);
        }

        // Mettre à jour les informations de l'utilisateur dans la base de données
        $sql = "UPDATE users SET nomusers = :nomusers, email = :email, motdepasse = :motdepasse WHERE id = :userID";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':nomusers', $nomusers);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':motdepasse', $password);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();

        // Rediriger vers la page d'accueil après la mise à jour du profil
        header("Location: ../home/home.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier le profil</title>
</head>
<body>
    <h1>Modifier mon profil </h1>
    <h1></h1>

    <?php if (isset($errorMessage)): ?>
        <p><?php echo $errorMessage; ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="nomusers">Nom d'utilisateur :</label>
        <input type="text" id="nomusers" name="nomusers" value="<?php echo $user['nomusers']; ?>" required>

        <label for="email">Adresse e-mail :</label>
        <input type="email" id="email" name="email" value="<?php echo $user['email']; ?>" required>

        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password">

        <label for="confirmPassword">Confirmer le mot de passe :</label>
        <input type="password" id="confirmPassword" name="confirmPassword">

        <button type="submit">Mettre à jour</button>
    </form>
</body>
</html>
