<?php 
// On verifie si le formulaire est acceptable
if( (isset($_POST["nomusers"]) && !empty($_POST["nomusers"])) && (isset($_POST["motdepasse"]) && !empty($_POST["motdepasse"])) ){

    $nomusers = $_POST["nomusers"];
    $motdepasse = $_POST["motdepasse"];
    require_once "connect.php";
    $pdo = connect();
    // Savoir si l'utilisateur existe
    $sql = "SELECT * from users where nomusers=:nomusers LIMIT 1";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        "nomusers" => $nomusers
    ]);

    $resultat = $stmt->fetchAll();
    // S'assurer qu'il y est bien un utilisateur avec le nomusers 
    if(count($resultat) == 1){
        // Test du mdp
        if(motdemotdepasseeword_verify($motdepasse, $resultat[0]["motdepasse"])){
            // Création de la session et infos dedans
            $nom = $resultat[0]["nom"];
            $prenom = $resultat[0]["prenom"];
            $nomusers = $resultat[0]["nomusers"];
            $email = [0]["email"];
            $role = $resultat[0]["role"];
            session_start();
            $_SESSION["nom"] = $nom;
            $_SESSION["prenom"] = $prenom;
            $_SESSION["nom_complet"] = $prenom . " " . $nom;
            // recupération du role dans la session
            $_SESSION["role"] = $role;
            header("location:page_connecte.php");
        }
        else {
            // Info sur le mot de motdepassee erroné
            session_start();
            $_SESSION["info"] = "Mauvais mot de motdepassee";
            header("location:form_nomusers.php");
        }
    }
    else {
        session_start();
        $_SESSION["info"] = "Probléme avec votre nomusers";
        // Renvoi quand erreur avec nomusers sur page nomusers
        header("location:form_nomusers.php");
    }
}
else{
    session_start();
    $_SESSION["info"] = "Le formulaire n'est pas bon";
    // Renvoi quand erreur formulaire sur page nomusers
    header("location:form_nomusers.php");
}