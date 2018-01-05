<?php
/**
* Projet WEB 
*
* @author : Emile PAQUETTE & Romain BOISSON
*/

// Bufferisation des sorties
ob_start();

// Inclusion de la bibliothéque
include('bibli_24sur7.php');

session_start();

// on récupère la valeur de l'id de l'utilisateur courant grâce à la session
$id = $_SESSION['utiID'];

// on vérifie que la personne est identifier
bp_estConnecter();

if (isset($GLOBALS['bd'])){
    // Déconnexion de la base de données
    mysqli_close($GLOBALS['bd']);
}

// connexion a la base 
fd_bd_connexion();

//-----------------------------------------------------
// Affichage de la page
//-----------------------------------------------------
fd_html_head('24sur7 | Abonnements');
fd_html_bandeau('APP_PAGE_ABONNEMENTS');

echo '<div id="bcContenu">',
     '<form method="POST" action="abonnements.php">',
     '<table border="1" cellpadding="4" cellspacing="0">';
    
// on affiche un tableau qui contient les informations sur les gens qu'on suit et un bouton désabonner
afficheAbo();


if(!isset($_POST['btnDesabo'])){
    // affichage normal de la page  
}else{
    // on execute la requete de désabonnement : c'est une requete delete
    $utiID = $_POST['IDUtilisateurDesabo'];
    $Sdelete="DELETE FROM suivi 
              WHERE suiIDSuiveur = '$id'
              AND suiIDSuivi = '$utiID'";
    $Rdelete = mysqli_query($GLOBALS['bd'], $Sdelete) or fd_bd_erreur($Sdelete);
    
     mysqli_free_result($Rdelete);
    
    fd_redirige("abonnements.php");
}
echo '</div>';


//-----------------------------------------------------
// Fin de la page
//-----------------------------------------------------

fd_html_pied();

ob_end_flush();

?>