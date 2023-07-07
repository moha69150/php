<?php 

if( (isset($_POST["nomusers"]) && !empty($_POST["nomusers"])) 
    && (isset($_POST["email"]) && !empty($_POST["email"]))  
    && (isset($_POST["nom"]) && !empty($_POST["nom"])) 
    && (isset($_POST["prenom"]) && !empty($_POST["prenom"])) 
    && (isset($_POST["numeroagrement"]) && !empty($_POST["numeroagrement"])) 
    //&& (isset($_POST["service"]) && !empty($_POST["service"])) 
    && (isset($_POST["pass"]) && !empty($_POST["pass"])) 
    && (isset($_POST["remotdepasse"]) && !empty($_POST["remotdepasse"]))) 
{   
    // Pass et repass sont identique 
    if($_POST["pass"] === $_POST["remotdepasse"])
    {

        
        $nomusers = $_POST["nomusers"];
        $email = $_POST["email"];
        $nom = $_POST["nom"];
        $prenom = $_POST["prenom"];
        $numeroagrement = $_POST["numeroagrement"];
        //$service = $_POST["service"];
        $motdepasse = $_POST["pass"];
        $remotdepasse = $_POST["remotdepasse"];

        require_once "connect.php";

        /*
        // Récupère l'id du service basé sur le nom du service
        $sqlService = "SELECT id FROM service WHERE nom = :Administratif";
        $stmtService = $pdo->prepare($sqlService);
        $stmtService->execute([
        ]);
        $serviceId = $stmtService->fetchColumn();
        */
        // Vérifie si l'utilisateur existe déjà
        $sql = "SELECT id FROM users WHERE nomusers = :nomusers";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([ "nomusers" => $nomusers ]);

        // S'il n'y a pas d'utilisateur avec ce nom d'utilisateur, créez-en un nouveau
        if($stmt->rowCount() == 0) {
            // Insérer dans la table employé
            
            $sqlemp = "INSERT INTO employe(nom, prenom, numeroagrement) VALUES (:nom, :prenom, :numeroagrement)" ;
            $stmtemp = $pdo->prepare($sqlemp);
            $stmtemp->execute([
                "nom" => $nom,
                "prenom" => $prenom,
                "numeroagrement" => $numeroagrement
            ]);
            
            $employeId = $pdo->lastInsertId();  // Récupérer l'ID du dernier enregistrement inséré
            echo $employeId;
            // Insérer dans la table users
            
            $sql = "INSERT INTO users(nomusers, email, motdepasse, idemploye, idservice) VALUES (:nomusers, :email, :motdepasse, :idemploye, :tarte)" ;
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                "nomusers" => $nomusers,
                "email" => $email,
                "motdepasse" => password_hash($motdepasse, PASSWORD_BCRYPT, ["cost" => 10]),
                "idemploye" => $employeId,
                "tarte" => 23
            ]);
            
            echo "Utilisateur enregistré";
            //header("location:form_login.php");
        }
    } else {
        // Mot de passe et confirmation ne sont pas identiques
        session_start();
        $_SESSION["info"] = "Mot de passe et confirmation ne sont pas identiques";
        header("location:form_inscription.php");
        
    }
} else {
    // Formulaire non valide
    session_start();
    $_SESSION["info"] = "Formulaire non valide";
    header("location:form_inscription.php");
}

?>
