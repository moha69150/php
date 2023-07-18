<?php
require_once '../connectbdd.php';

// Vérifier si l'identifiant du service a été passé en paramètre d'URL
if (isset($_GET['id'])) {
    $serviceId = $_GET['id'];

    // Récupérer les informations du service
    $sqlService = "SELECT * FROM service WHERE id = :id";
    $stmtService = $pdo->prepare($sqlService);
    $stmtService->bindParam(":id", $serviceId);
    $stmtService->execute();
    $service = $stmtService->fetch(PDO::FETCH_ASSOC);

    // Vérifier si le service existe
    if ($service) {
        // Récupérer les informations des projets associés au service
        $sqlProjets = "SELECT p.*, c.nomcategorie, e.etat
                       FROM projet p
                       INNER JOIN categorieprojet c ON p.idcategorieprojet = c.id
                       INNER JOIN etatprojet e ON p.idetats = e.id
                       WHERE p.idservice = :id";
        $stmtProjets = $pdo->prepare($sqlProjets);
        $stmtProjets->bindParam(":id", $serviceId);
        $stmtProjets->execute();
        $projets = $stmtProjets->fetchAll(PDO::FETCH_ASSOC);

        // Récupérer les informations des employés rattachés au service
        $sqlEmployes = "SELECT e.nom, e.prenom, u.email
                        FROM employe e
                        INNER JOIN users u ON e.id = u.idemploye
                        WHERE u.idservice = :id";
        $stmtEmployes = $pdo->prepare($sqlEmployes);
        $stmtEmployes->bindParam(":id", $serviceId);
        $stmtEmployes->execute();
        $employes = $stmtEmployes->fetchAll(PDO::FETCH_ASSOC);
    } else {
        // Service introuvable, rediriger vers la page d'accueil
        header("Location: index.php");
        exit();
    }
} else {
    // Identifiant de service manquant, rediriger vers la page d'accueil
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails du service - Votre Intranet</title>
</head>
<body>
    <h1>Détails du service</h1>

    <h2><?php echo $service['nom']; ?></h2>

    <h3>Projets associés :</h3>
    <?php foreach ($projets as $projet): ?>
        <h4><?php echo $projet['titre']; ?></h4>
        <p>Description : <?php echo $projet['description']; ?></p>
        <p>Client : <?php echo $projet['clientprojet']; ?></p>
        <p>Date de début : <?php echo $projet['datedebut']; ?></p>
        <p>Date de fin prévue : <?php echo $projet['datefinprevue']; ?></p>
        <p>Catégorie : <?php echo $projet['nomcategorie']; ?></p>
        <p>État : <?php echo $projet['etat']; ?></p>
        <hr>
    <?php endforeach; ?>

    <h3>Employés rattachés :</h3>
    <ul>
        <?php foreach ($employes as $employe): ?>
            <li><?php echo $employe['nom']; ?> <?php echo $employe['prenom']; ?> - <?php echo $employe['email']; ?></li>
        <?php endforeach; ?>
    </ul>
</body>
</html>
