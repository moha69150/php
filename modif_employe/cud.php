<?php
session_start();
require_once '../connectbdd.php';



// Récupérer les projets uniques par service avec leurs informations
$sql = "SELECT p.id, p.titre, p.description, p.clientprojet, p.datedebut, p.datefinprevue, c.nomcategorie, e.etat, s.nom AS service
        FROM projet p
        INNER JOIN categorieprojet c ON p.idcategorieprojet = c.id
        INNER JOIN etatprojet e ON p.idetats = e.id
        INNER JOIN service s ON p.idservice = s.id
        WHERE p.id IN (
            SELECT MIN(id) 
            FROM projet 
            GROUP BY idservice
        )";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$projets = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Projets - CRUD</title>
    <link rel="stylesheet" href="cud.css">
</head>
<body>
    <h1>Projets - CUD</h1>

    <table>
        <thead>
            <tr>
                <th>Titre</th>
                <th>Description</th>
                <th>Client</th>
                <th>Date de début</th>
                <th>Date de fin prévue</th>
                <th>Catégorie</th>
                <th>État</th>
                <th>Service</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($projets as $projet): ?>
                <tr>
                    <td><?php echo $projet['titre']; ?></td>
                    <td><?php echo $projet['description']; ?></td>
                    <td><?php echo $projet['clientprojet']; ?></td>
                    <td><?php echo $projet['datedebut']; ?></td>
                    <td><?php echo $projet['datefinprevue']; ?></td>
                    <td><?php echo $projet['nomcategorie']; ?></td>
                    <td><?php echo $projet['etat']; ?></td>
                    <td><?php echo $projet['service']; ?></td>
                    <td>
                        <a href="modifier_projet.php?id=<?php echo $projet['id']; ?>">Modifier</a>
                        <a href="supprimer_projet.php?id=<?php echo $projet['id']; ?>">Supprimer</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
