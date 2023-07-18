<?php
session_start();
require_once '../connectbdd.php';

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['userID'])) {
    header('Location: ../login/login.php');
    exit;
}

$userID = $_SESSION['userID'];

// Vérifier si l'ID du projet est spécifié dans l'URL
if (!isset($_GET['id'])) {
    header('Location: cud.php');
    exit;
}

$projetID = $_GET['id'];

// Vérifier si le projet appartient à l'utilisateur connecté
$sql = "SELECT *
        FROM projet
        WHERE id = :projetID AND idservice IN (
            SELECT idservice
            FROM users
            WHERE id = :userID
        )";
$stmt = $pdo->prepare($sql);
$stmt->bindParam(':projetID', $projetID);
$stmt->bindParam(':userID', $userID);
$stmt->execute();
$projet = $stmt->fetch(PDO::FETCH_ASSOC);

// Vérifier si le projet existe et appartient à l'utilisateur
if (!$projet) {
    header('Location: cud.php');
    exit;
}

// Traitement du formulaire de modification
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupérer les nouvelles valeurs du formulaire
    $titre = $_POST['titre'];
    $description = $_POST['description'];
    $client = $_POST['client'];
    // ... Récupérer les autres valeurs du formulaire ...

    // Mettre à jour les informations du projet dans la base de données
    $sql = "UPDATE projet
            SET titre = :titre, description = :description, clientprojet = :client
            WHERE id = :projetID";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':description', $description);
    $stmt->bindParam(':client', $client);
    $stmt->bindParam(':projetID', $projetID);
    $stmt->execute();

    // Rediriger vers la page de liste des projets après la modification
    header('Location: cud.php');
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier le projet</title>
    <link rel="stylesheet" href="modifier_projet.css">
</head>
<body>
    <h1>Modifier le projet</h1>

    <form method="POST">
        <label for="titre">Titre :</label>
        <input type="text" name="titre" id="titre" value="<?php echo $projet['titre']; ?>" required>

        <label for="description">Description :</label>
        <textarea name="description" id="description" required><?php echo $projet['description']; ?></textarea>

        <label for="client">Client :</label>
        <input type="text" name="client" id="client" value="<?php echo $projet['clientprojet']; ?>" required>

        <!-- Ajoutez ici les autres champs du formulaire pour les autres informations du projet -->

        <button type="submit">Enregistrer les modifications</button>
    </form>
</body>
</html>
