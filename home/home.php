<?php
require_once '../connectbdd.php';

// Votre code ici...


// Récupérer les informations des 5 filiales
$sql = "SELECT * FROM entite LIMIT 5";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$filiales = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil - Votre Intranet</title>
   

</head>
<body>
<header>
    <h1><a href="../modif_employe/modif.php">mon profil</a> </h1>
    <h1><a href="../modif_employe/cud.php">Modifier les projets</a> </h1>
    <h1><a href="../modif_employe/modif.php">Gestion des utilisateurs</a> </h1>
</header>
    <h1>Liste des filiales</h1>

    <?php foreach ($filiales as $filiale): ?>
        <h2><a href="../filiale/filiale.php?id=<?php echo $filiale['id']; ?>"><?php echo $filiale['nom']; ?></a></h2>
        <hr>
    <?php endforeach; ?>


</body>
</html>
