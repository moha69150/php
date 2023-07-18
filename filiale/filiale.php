<?php
require_once '../connectbdd.php';

// Vérifier si l'identifiant de la filiale a été passé en paramètre d'URL
if (isset($_GET['id'])) {
    $filialeId = $_GET['id'];

    // Récupérer les informations de la filiale
    $sqlFiliale = "SELECT * FROM entite WHERE id = :id";
    $stmtFiliale = $pdo->prepare($sqlFiliale);
    $stmtFiliale->bindParam(":id", $filialeId);
    $stmtFiliale->execute();
    $filiale = $stmtFiliale->fetch(PDO::FETCH_ASSOC);

    // Vérifier si la filiale existe
    if ($filiale) {
        // Récupérer les services associés à la filiale (en évitant les doublons)
        $sqlServices = "SELECT DISTINCT s.* FROM service s
                        INNER JOIN entite e ON s.identite = e.id
                        WHERE e.id = :id";
        $stmtServices = $pdo->prepare($sqlServices);
        $stmtServices->bindParam(":id", $filialeId);
        $stmtServices->execute();
        $services = $stmtServices->fetchAll(PDO::FETCH_ASSOC);
    } else {
        // Filiale introuvable, rediriger vers la page d'accueil
        header("Location: ../home/home.php");
        exit();
    }
} else {
    // Identifiant de filiale manquant, rediriger vers la page d'accueil
    header("Location: ../home/home.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de la filiale - Votre Intranet</title>
</head>
<body>
    <h1>Détails de la filiale</h1>

    <h2><?php echo $filiale['nom']; ?></h2>
    <p>Adresse : <?php echo $filiale['adresse']; ?></p>
    <p>Ville : <?php echo $filiale['ville']; ?></p>
    <p>Code postal : <?php echo $filiale['codepostal']; ?></p>

    <h3>Services associés :</h3>
    <ul>
        <?php foreach ($services as $service): ?>
            <li><a href=../service/service.php?id=<?php echo $service['id']; ?>"><?php echo $service['nom']; ?></a></li>
        <?php endforeach; ?>
    </ul>
</body>
</html>

