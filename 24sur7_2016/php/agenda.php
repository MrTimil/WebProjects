<?php
/** @file
 * Page d'accueil de l'application 24sur7
 *
 * @author : Frederic Dadeau - frederic.dadeau@univ-fcomte.fr
 */

// Inclusion de la bibliothéque
include('bibli_24sur7.php');	
fd_bd_connexion();
session_start();

// on vérifie que la personne est identifier
bp_estConnecter();

print_r($_SESSION);
fd_html_head('24sur7 | Agenda');

fd_html_bandeau(APP_PAGE_AGENDA);

$GLOBALS['dayPrint']=array();
echo '<section id="bcContenu">',
		'<aside id="bcGauche">';

$jourAff=0;
$moisAff=15;
$anneeAff=0;
if(isset($_GET['jour'])){
    $jourAff=$_GET['jour'];
}
if(isset($_GET['mois'])){
    $moisAff=$_GET['mois'];
}
if(isset($_GET['annee'])){
    $anneeAff=$_GET['annee'];
}


$info=fd_html_calendrier($jourAff,$moisAff,$anneeAff);

//print_r($info);
$firstDay=$info[0];
echo		'<section id="categories">
            <h3>Vos agendas</h3>';
    if(isset($_GET['mois'])){
        echo ' <a href="?mois='.$_GET['mois'].'&jour='.$_GET['jour'].'&annee='.$_GET['annee'].'">';
    }else{
        echo '<a href="./agenda.php">';
    }
               
     echo   'Agenda de ',$_SESSION['utiNom'],'</a> ',
                bp_html_liste_agenda($_SESSION['utiID']),bp_html_liste_suivi($_SESSION['utiID']),
			'</section>',
		'</aside>';
if(isset($_GET['id'])){
    echo bpl_html_semainier($firstDay,$_GET['id']);
}else{
    echo bpl_html_semainier($firstDay,$_SESSION['utiID']);
}

   
echo '</section>';

fd_html_pied();

/** 
* Genere le code html permettant de placer les creneaux de rendez-vous
* 
* @param    int $id Id de l'utilisateur actuel
*
*
* @return la chaine html permettant de les creer
*/
function bpl_html_blocrdv($id){
    $res="";
    $id= mysqli_real_escape_string($GLOBALS['bd'], $id);

    $S = "SELECT	*
            FROM	rendezvous,categorie,utilisateur
            WHERE	rdvIDUtilisateur = '$id' AND rdvIDCategorie =  catID AND rdvIDUtilisateur=utiID";

    $R = mysqli_query($GLOBALS['bd'], $S) or fd_bd_erreur($S);
    foreach ($R as $D) {
        if($id == $_SESSION['utiID'] || $D['catPublic']==1){
            list($j, $m, $a) = explode(' ', fd_date_claire_v2($D['rdvDate']));
            $j= (int)$j;
            $a= (int)$a;
            $m= (int)$m;
            // 99
            echo "<div class=rendezvous style='left:",51+$GLOBALS['dayPrint'][date("l", mktime(0, 0, 0, $m, $j, $a))],"px;top:",bpl_top_rdv($D['rdvHeureDebut'],$D['utiHeureMin'])+63,"px;background-color:",$D['catCouleurFond'],"; height:",bpl_height_rdv($D['rdvHeureDebut'],$D['rdvHeureFin']),"; border:solid 2px;border-color:",$D['catCouleurBordure'],"'>".$D['rdvLibelle']."</div>";

        }
    }
    return $res;
}

function bpl_height_rdv($heureDebut,$heureFin){
    
    $heureDebut=bpl_convert_minute($heureDebut);
    $heureFin=bpl_convert_minute($heureFin);
    
    $hD = (int)$heureDebut;
    $hF = (int)$heureFin;
    
    $diff= ($hF - $hD)/100;
    $height = $diff * 40;
    if($height <= 0){
        return 15;
    }
    
    return $height-4;
}

function bpl_top_rdv($heure,$heureMin){
    $heure=bpl_convert_minute($heure);
    $heureMin .="00";
    $heureMin = (int)$heureMin;
    $h = (int)$heure;
    $diff = ($h-$heureMin)/100;
    $top = $diff * 41;
    if($top<0){
        return -10;
    }
    return $top;
}

function bpl_convert_minute($minute){
    $tmp="";

    $tmp .= $minute[strlen($minute)-2];
    $tmp .=$minute[strlen($minute)-1];
    $tmp = (int)$tmp;
    $tmp = ($tmp*100)/60;
    if($tmp==0){
        $tmp = strval($tmp);
        $tmp .= "0";
    }else{
        $tmp = strval($tmp);
    }
    
    $minute[strlen($minute)-2] = $tmp[0];
    $minute[strlen($minute)-1] = $tmp[1];
    
    return $minute;
}

/** 
* Recherche et affiche les agendas de l'utilisateur
* 
* @param    int $id Id de l'utilisateur actuelle
*
*
* @return la chaine html permettant d'afficher la liste d'agenda
*/
function bp_html_liste_agenda($id){
    $res='<ul id="mine">';
    
    $id= mysqli_real_escape_string($GLOBALS['bd'], $id);

    $S = "SELECT	*
            FROM	categorie
            WHERE	catIDUtilisateur = '$id'";

    $R = mysqli_query($GLOBALS['bd'], $S) or fd_bd_erreur($S);
    foreach ($R as $D) {
        $res .="<li>";
        $res .= $D['catNom'];
        $res .="<div style='width:10; height:10;border:solid 2px;border-color:";
        $res .=$D["catCouleurBordure"];
        $res .=";background-color:";
        $res .=$D["catCouleurFond"];
        $res .=";float:left;margin-right:5px;'> </div>";
        $res .="</li>";
    }
    $res .= "</ul>";
    return $res;
}

/** 
* Recherche et affiche les agendas de l'utilisateur en verifiant la confidentialite de l'agenda
* 
* @param    int $id Id de l'utilisateur actuelle
*
*
* @return la chaine html permettant d'afficher la liste d'agenda
*/
function bp_html_liste_agenda_check($id){
    $res="";
    
    $id= mysqli_real_escape_string($GLOBALS['bd'], $id);

    $S = "SELECT	*
            FROM	categorie,utilisateur
            WHERE	catIDUtilisateur = '$id'AND utiID=catIDUtilisateur";

    $R = mysqli_query($GLOBALS['bd'], $S) or fd_bd_erreur($S);
    $tmp =  mysqli_fetch_assoc($R);
    if(isset($_GET['jour'])){
        $res .= '<a href="?mois='.$_GET['mois'].'&jour='.$_GET['jour'].'&annee='.$_GET['annee'].'&id='.$tmp['utiID'].'">';    
    }else{
        $res .= '<a href="?id='.$tmp['utiID'].'" >';
    }
    
    $res .=$tmp['utiNom'];
    $res .="</a>";
    $res .='<ul>';
    
    foreach ($R as $D) {
        if($D['catPublic']==1){
            $res .="<li>";
            $res .= $D['catNom'];
            $res .="<div style='width:10; height:10;border:solid 2px;border-color:";
            $res .=$D["catCouleurBordure"];
            $res .=";background-color:";
            $res .=$D["catCouleurFond"];
            $res .=";float:left;margin-right:5px;'> </div>";
            $res .="</li>";
        }
    }
    $res .= "</ul>";
    return $res;
}

/** 
* Recherche et affiche les agendas suivis par la personne connectes
* 
* @param    int $id Id de l'utilisateur actuelle
*
*
* @return la chaine html permettant d'afficher les listes d'agendas suivie
*/
function bp_html_liste_suivi($id){

    $res='Agendas suivis : <ul id="other">';
    
    $id= mysqli_real_escape_string($GLOBALS['bd'], $id);

    $S = "SELECT	*
            FROM	utilisateur,suivi
            WHERE	 utiID = '$id' AND utiID=suiIDSuiveur";

    $R = mysqli_query($GLOBALS['bd'], $S) or fd_bd_erreur($S);
    
    
    foreach ($R as $D) {
        $res .= bp_html_liste_agenda_check($D['suiIDSuivi']);
    }
    $res .= "</ul>";
    return $res;
}

   
/**
 * Genere le code html pour créer un semainier
 *
 * @param   int $debut  Permets de faire l'affichage du bon numero dans le semainier
 *
 * @return la chaine html permettant de le creer
 */

function bpl_html_semainier($debut,$id){
    $id= mysqli_real_escape_string($GLOBALS['bd'], $id);

    $S = "SELECT	*
            FROM	utilisateur
            WHERE	utiID = '$id'";

    $R = mysqli_query($GLOBALS['bd'], $S) or fd_bd_erreur($S);
    $D = mysqli_fetch_assoc($R);
    
    $convert = decbin($D['utiJours']);
    echo '<section id="bcCentre" style="height:',(($D['utiHeureMax']-$D['utiHeureMin'])*40)+130,'">  
                <p id="titreAgenda">
                    <a href="#" class="flechegauche"><img src="../images/fleche_gauche.png" alt="picto fleche gauche"></a>
                <strong>Semaine du ',$debut,' au ',$debut+6,' F&eacute;vrier</strong> pour <strong>',$_SESSION['utiNom'],'</strong>
                    <a href="#" class="flechedroite"><img src="../images/fleche_droite.png" alt="picto fleche droite"></a>
                </p>
                <section id="agenda">
                    <div id="intersection"></div>
                    ',bpl_html_caseJour($debut,$convert),'
                    <div id=posGrille><div id="col-heures">
                        ',bpl_html_colHeure($D['utiHeureMin'],$D['utiHeureMax']),'
                    </div>
                    ',bpl_html_colSemainier(strlen($convert),$D['utiHeureMax']-$D['utiHeureMin']),'
                    </div>
                </section>
                ',bpl_html_blocrdv($id),'
            </section>';
}

/**
 * Genere le code html pour créer la colonne des heures
 *
 * @return la chaine html permettant de le creer
 */

function bpl_html_colHeure($min,$max){
    $res = '';
    for($i=$min;$i<=$max;++$i){
        if($i==$min){
            $res .= '<div id="firstTime">'.$i.'h </div>';
        }else{
            $res .= '<div>'.$i.'h </div>';    
        }
        
    }
    return $res;
}
/**
 * Genere le code html pour créer le bandeau contenant les jours ( au dessus de semainier )
 *
 * @param   int $numFirstDay    Permets de renseigner le numero associer au lundi 
 *
 * @return la chaine html permettant de le creer
 */

function bpl_html_caseJour($numFirstDay,$jourAffiche){
    $res = '';
    $count= 0;
    $dayprint = array();
    while(strlen($jourAffiche) < 7){
        $jourAffiche .="0";
    }
    if(ctype_digit("".$numFirstDay."")){
        if($jourAffiche[0]==1){
            $res.= '<div class="case-jour border-TRB border-L">Lundi '.$numFirstDay++.'</div>';
            $dayPrint['Monday'] = $count*99;
            $count++;
        }
        if($jourAffiche[1]==1){
            $res.= '<div class="case-jour border-TRB"> Mardi '.$numFirstDay++.'</div>';
            $dayPrint['Tuesday'] = $count*99;
            $count++;
        }
        if($jourAffiche[2]==1){
            $res.= '<div class="case-jour border-TRB">Mercredi '.$numFirstDay++.'</div>';
            $dayPrint['Wednesday'] = $count*99;
            $count++;
        }
        if($jourAffiche[3]==1){
            $res.= '<div class="case-jour border-TRB">Jeudi '.$numFirstDay++.'</div>';
            $dayPrint['Thursday'] = $count*99;
            $count++;
        }
        if($jourAffiche[4]==1){
            $res.= '<div class="case-jour border-TRB">Vendredi '.$numFirstDay++.'</div>';
            $dayPrint['Friday'] = $count*99;
            $count++;
        }
        if($jourAffiche[5]==1){
            $res.= '<div class="case-jour border-TRB">Samedi '.$numFirstDay++.'</div>';
            $dayPrint['Saturday'] = $count*99;
            $count++;
        }
        if($jourAffiche[6]==1){
            $res.= '<div class="case-jour border-TRB">Dimanche '.$numFirstDay++.'</div>'; 
            $dayPrint['Sunday'] = $count*99;
            $count++;
        }                    
    }
    $GLOBALS['dayPrint']=$dayPrint;
    return $res;
}

/**
 * Genere le code html permettant de créer un nombre de colonnes,
 * 
 * @param   int $nbLigne    Permets de créer le nombre de ligne demande
 * @param   int $nbColJour  Sert a renseigner le nombre de colonnes demande, par defaut $nbColJour=6
 *
 * @return la chaine html permettant de les creer
 */

function bpl_html_colSemainier($nbColJour,$nbLigne){
    $res = "";
    $nbLigne = (int)$nbLigne;
    for($i =0;$i<$nbColJour;++$i){
        if($i==0){
            $res .= '<div class="col-jour border-TRB border-L">';
        }else{
            $res .= '<div class="col-jour border-TRB">';
        }
        for($j=0;$j<=$nbLigne;++$j){
            if($j==$nbLigne){
                $res .= '<a href="#" class="case-heure-bas"></a>';
            }else{
                $res .= '<a href="#"></a>';
            }
        }            
        $res .= '</div>';
    }
    return $res;
}
?>
