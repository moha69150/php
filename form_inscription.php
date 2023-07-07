<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
    </head>
    <body>
        <h1>Authentification [ <a href="form_login.php">Connexion</a> ]</h1>
        <div class="erreur"><?php 
        // Affichage des infos à l'utilisateur

        // cette ouverte donne accés au information de la session
        session_start();
        // verifie si on a bien une valeur dans session->infos
        if(isset($_SESSION["info"]))
        {
            // Si on a une info alors on l affiche
            echo $_SESSION["info"];
            // destruction de la session
            session_destroy();
        }
        else{
            // Sinon destruction de la session ouverte en haut
            session_destroy();
        }
        // affichage du nouvelle info
        if(isset($_GET["info2"]))
        {
            echo $_GET["info2"];
        }

        ?>
        </div>
        <form name="fo" method="post" action="inscitionbackup.php">
            <input type="text" name="nom" placeholder="Nom" value="tt" /><br />
            <input type="text" name="prenom" placeholder="Prénom" value="tt" /><br />
            <input type="text" name="numeroagrement" placeholder="Numero Agrement" value="tt" /><br />
            <input type="text" name="nomusers" placeholder="Nomusers" value="tt" /><br />
            <input type="email" name="email" placeholder="Email" value="tt@t.fr" ><br />
            <input type="password" name="pass" placeholder="Mot de passe" value="tt" /><br />
            <input type="password" name="remotdepasse" placeholder="Confirmer Mot de passe" value="tt" /><br />
            <input type="submit" name="" value="Inscription" />
        </form>
    </body>
</html> 