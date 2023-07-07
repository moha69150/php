<?php
    session_start();
    // on détruit la session afin de plus être connecté
    session_destroy();
    header("location:form_login.php");
?> 