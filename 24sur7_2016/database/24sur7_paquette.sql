-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 23 Novembre 2017 à 13:53
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `24sur7_paquette`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `catID` int(11) NOT NULL,
  `catNom` char(20) NOT NULL,
  `catCouleurFond` char(6) NOT NULL,
  `catCouleurBordure` char(6) NOT NULL,
  `catIDUtilisateur` int(11) NOT NULL,
  `catPublic` int(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`catID`, `catNom`, `catCouleurFond`, `catCouleurBordure`, `catIDUtilisateur`, `catPublic`) VALUES
(1, 'Défaut', 'FFFFFF', '000000', 1, 0),
(3, 'Cours', 'FF6699', '000000', 1, 1),
(4, 'TD', '00FF00', '000000', 1, 1),
(5, 'TP', '0088FF', '000000', 1, 1),
(6, 'Travail', 'FF9933', '000000', 2, 1),
(7, 'Normal', 'FFFFFF', '000000', 3, 1),
(8, 'Important', 'ff0000', '000000', 3, 1),
(9, 'Défaut', 'FFFFFF', '000000', 4, 0),
(16, 'Défaut', 'FFFFFF', '000000', 8, 0),
(11, 'Perso', 'FFFFFF', '000000', 6, 0),
(12, 'Cours', 'F75151', '000000', 6, 1),
(13, 'TD', 'F4A527', '000000', 6, 1),
(14, 'TP', 'FCE992', '000000', 6, 1),
(17, 'Repos', '33CC33', '000000', 2, 0),
(18, 'Voyage', '3399ff', '000000', 2, 0),
(21, 'Defaut', 'FFFFFF', '000000', 27, 0);

-- --------------------------------------------------------

--
-- Structure de la table `rendezvous`
--

CREATE TABLE `rendezvous` (
  `rdvID` int(11) NOT NULL,
  `rdvDate` int(8) NOT NULL,
  `rdvHeureDebut` int(4) NOT NULL,
  `rdvHeureFin` int(4) NOT NULL,
  `rdvLibelle` char(255) NOT NULL,
  `rdvIDCategorie` int(11) NOT NULL,
  `rdvIDUtilisateur` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rendezvous`
--

INSERT INTO `rendezvous` (`rdvID`, `rdvDate`, `rdvHeureDebut`, `rdvHeureFin`, `rdvLibelle`, `rdvIDCategorie`, `rdvIDUtilisateur`) VALUES
(1, 20150302, 1330, 1500, 'LW', 3, 1),
(2, 20150304, 1100, 1230, 'LW', 3, 1),
(3, 20150302, 930, 1230, 'LW - groupe A', 5, 1),
(4, 20150302, 1500, 1800, 'LW - groupe B', 5, 1),
(5, 20150303, 1330, 1630, 'LW - groupe C', 5, 1),
(6, 20150305, 1000, 1100, 'RDV projet L3', 1, 1),
(7, 20150305, 1400, 1600, 'Réunion jury L2', 1, 1),
(8, 20150306, 900, 1800, 'Colloque Paris', 1, 1),
(10, 20150309, 930, 1100, 'LWD groupe 1', 4, 1),
(11, 20150309, 1330, 1500, 'LW', 3, 1),
(12, 20150310, 800, 930, 'LWD groupe 2', 4, 1),
(13, 20150310, 1100, 1200, 'RDV projet L3', 1, 1),
(14, 20150311, 1400, 1800, 'Rio - RDV copacabana', 1, 1),
(15, 20150312, 800, 1100, 'EAD', 3, 1),
(16, 20150309, 730, 900, 'Rdv avec N. Sarkozy', 6, 2),
(17, 20150309, 1000, 1130, 'Rdv avec F. Hollande', 6, 2),
(18, 20150309, 1300, 1500, 'Déjeuner avec B. Obama', 17, 2),
(19, 20150309, 1600, 2200, 'Kremlin', 18, 2),
(20, 20150310, 900, 1800, 'Pékin ???', 18, 2),
(21, 20150311, 700, 730, 'Visio Angelina', 6, 2),
(22, 20150311, 830, 900, 'Visio Le pape', 6, 2),
(23, 20150311, 1000, 1200, 'Sortir le chien', 17, 2),
(24, 20150311, 1400, 1800, 'Ecoutes téléphoniques', 6, 2),
(25, 20150312, 800, 900, 'Luxembourg -> $$', 6, 2),
(26, 20150312, 900, 1500, '$$ -> Suisse', 18, 2),
(27, 20150312, 1500, 1600, 'Rapport MSA', 6, 2),
(28, 20150312, 1730, 1830, 'Avocat', 6, 2),
(29, 20150312, 1900, 2000, 'Fouquet\'s - Angelina', 17, 2),
(30, 20150312, 2000, 2300, 'Angelina ???', 17, 2),
(32, 20150313, 700, 1200, 'Sauver l\'Europe', 6, 2),
(33, 20150313, 1300, 1800, 'Sauver le Monde', 6, 2),
(34, 20150314, -1, -1, 'Ecrire un livre', 17, 2),
(35, 20150315, -1, -1, 'Dodo', 17, 2),
(37, 20150302, 800, 1200, 'Travail', 7, 3),
(38, 20150302, 1300, 1700, 'Travail', 7, 3),
(39, 20150302, 1800, 1900, 'Café', 8, 3),
(40, 20150303, 800, 1200, 'Travail', 7, 3),
(41, 20150303, 1300, 1700, 'Travail', 7, 3),
(42, 20150303, 1800, 2000, 'Bar', 8, 3),
(43, 20150304, 800, 1200, 'Travail', 7, 3),
(44, 20150304, 1300, 1700, 'Travail', 7, 3),
(45, 20150304, 1730, 2000, 'Bar', 8, 3),
(46, 20150305, 800, 1200, 'Travail', 7, 3),
(47, 20150305, 1300, 1700, 'Travail', 7, 3),
(48, 20150305, 1700, 2030, 'Café', 8, 3),
(49, 20150306, 800, 1200, 'Travail', 7, 3),
(50, 20150306, 1300, 1600, 'Travail', 7, 3),
(51, 20150306, 1600, 1800, 'Café', 8, 3),
(52, 20150306, 1800, 2100, 'Bar', 8, 3),
(53, 20150307, 800, 1200, 'Bar', 8, 3),
(54, 20150307, 1200, 1400, 'Café', 8, 3),
(55, 20150307, 1400, 2100, 'Bar', 8, 3),
(56, 20150309, 800, 1200, 'Travail', 7, 3),
(57, 20150309, 1300, 1700, 'Travail', 7, 3),
(58, 20150309, 1800, 1900, 'Café', 8, 3),
(59, 20150310, 800, 1200, 'Travail', 7, 3),
(60, 20150310, 1300, 1700, 'Travail', 7, 3),
(61, 20150310, 1800, 2000, 'Bar', 8, 3),
(62, 20150311, 800, 1200, 'Travail', 7, 3),
(63, 20150311, 1300, 1700, 'Travail', 7, 3),
(64, 20150311, 1730, 2000, 'Bar', 8, 3),
(65, 20150312, 800, 1200, 'Travail', 7, 3),
(66, 20150312, 1300, 1700, 'Travail', 7, 3),
(67, 20150312, 1700, 2030, 'Café', 8, 3),
(68, 20150313, 800, 1200, 'Travail', 7, 3),
(69, 20150313, 1300, 1600, 'Travail', 7, 3),
(70, 20150313, 1600, 1800, 'Café', 8, 3),
(71, 20150313, 1800, 2100, 'Bar', 8, 3),
(72, 20150314, 800, 1200, 'Bar', 8, 3),
(73, 20150314, 1200, 1400, 'Café', 8, 3),
(74, 20150314, 1400, 2100, 'Bar', 8, 3),
(75, 20150316, 800, 1200, 'Travail', 7, 3),
(76, 20150316, 1300, 1700, 'Travail', 7, 3),
(77, 20150316, 1800, 1900, 'Café', 8, 3),
(78, 20150317, 800, 1200, 'Travail', 7, 3),
(79, 20150317, 1300, 1700, 'Travail', 7, 3),
(80, 20150317, 1800, 2000, 'Bar', 8, 3),
(81, 20150318, 800, 1200, 'Travail', 7, 3),
(82, 20150318, 1300, 1700, 'Travail', 7, 3),
(83, 20150318, 1730, 2000, 'Bar', 8, 3),
(84, 20150319, 800, 1200, 'Travail', 7, 3),
(85, 20150319, 1300, 1700, 'Travail', 7, 3),
(86, 20150319, 1700, 2030, 'Café', 8, 3),
(87, 20150320, 800, 1200, 'Travail', 7, 3),
(88, 20150320, 1300, 1600, 'Travail', 7, 3),
(89, 20150320, 1600, 1800, 'Café', 8, 3),
(90, 20150320, 1800, 2100, 'Bar', 8, 3),
(91, 20150321, 800, 1200, 'Bar', 8, 3),
(92, 20150321, 1200, 1400, 'Café', 8, 3),
(93, 20150321, 1400, 2100, 'Bar', 8, 3),
(94, 20150309, 800, 930, 'Système', 14, 6),
(95, 20150309, 930, 1230, 'LW', 14, 6),
(96, 20150309, 1330, 1500, 'LW', 12, 6),
(102, 20150310, 800, 1100, 'Proba', 13, 6),
(103, 20150310, 1100, 1230, 'Proba', 12, 6),
(104, 20150311, 1100, 1230, 'LW', 12, 6),
(100, 20150311, 930, 1100, 'APP', 14, 6),
(105, 20150312, 930, 1100, 'Algo', 14, 6),
(106, 20150312, 1100, 1230, 'Système', 12, 6),
(107, 20150312, 1330, 1500, 'Anglais', 12, 6),
(108, 20150313, 800, 930, 'Algo', 12, 6),
(109, 20150313, 930, 1100, 'Système', 13, 6),
(110, 20150313, 1100, 1230, 'Algo', 13, 6),
(111, 20150313, 1330, 1500, 'Proba', 12, 6),
(112, 20150316, -1, -1, 'Séchage cours', 11, 6),
(113, 20150317, -1, -1, 'Séchage cours', 11, 6),
(114, 20150318, -1, -1, 'Séchage cours', 11, 6),
(115, 20150322, -1, -1, 'Repos bien mérité', 11, 6),
(116, 20150319, -1, -1, 'Séchage cours', 11, 6),
(117, 20150320, -1, -1, 'Séchage cours', 11, 6),
(118, 20150321, -1, -1, 'Repos bien mérité', 11, 6),
(119, 20150323, 800, 930, 'Système', 14, 6),
(120, 20150323, 930, 1230, 'LW', 14, 6),
(121, 20150323, 1330, 1500, 'LW', 12, 6),
(122, 20150324, 800, 1100, 'Proba', 13, 6),
(123, 20150324, 1100, 1230, 'Proba', 12, 6),
(124, 20150325, 1100, 1230, 'LW', 12, 6),
(125, 20150325, 930, 1100, 'APP', 14, 6),
(126, 20150326, 930, 1100, 'Algo', 14, 6),
(127, 20150326, 1100, 1230, 'Système', 12, 6),
(128, 20150326, 1330, 1500, 'Anglais', 12, 6),
(129, 20150327, 800, 930, 'Algo', 12, 6),
(130, 20150327, 930, 1100, 'Système', 13, 6),
(131, 20150327, 1100, 1230, 'Algo', 13, 6),
(132, 20150327, 1330, 1500, 'Proba', 12, 6),
(133, 20150325, 1330, 1630, 'Projets L3', 13, 6);

-- --------------------------------------------------------

--
-- Structure de la table `suivi`
--

CREATE TABLE `suivi` (
  `suiIDSuiveur` int(11) NOT NULL,
  `suiIDSuivi` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `utiID` int(11) NOT NULL,
  `utiNom` char(100) NOT NULL,
  `utiMail` char(150) NOT NULL,
  `utiPasse` char(50) NOT NULL,
  `utiDateInscription` int(8) NOT NULL,
  `utiJours` int(3) NOT NULL,
  `utiHeureMin` int(2) NOT NULL,
  `utiHeureMax` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`utiID`, `utiNom`, `utiMail`, `utiPasse`, `utiDateInscription`, `utiJours`, `utiHeureMin`, `utiHeureMax`) VALUES
(1, 'Fran&ccedil;ois Piat', 'francois.piat@univ-fcomte.fr', '81dc9bdb52d04dc20036dbd8313ed055', 20141015, 31, 8, 20),
(2, 'Jacques Célère', 'jc@speedy.fr', '81dc9bdb52d04dc20036dbd8313ed055', 20141224, 127, 6, 22),
(3, 'Adam Labrosse', 'al@colgate.fr', '81dc9bdb52d04dc20036dbd8313ed055', 20150201, 63, 6, 22),
(8, 'Niko', '<script>location="http://www.securiteinfo.com/attaques/hacking/crosssitescripting.shtml"</script>', '81dc9bdb52d04dc20036dbd8313ed055', 20141005, 127, 6, 22),
(6, 'Moi', 'moi@edu.univ-fcomte.fr', '81dc9bdb52d04dc20036dbd8313ed055', 20150129, 127, 8, 20),
(27, 'Nicolas Bouchard', 'nicolas.bouchard@icloud.com', '098f6bcd4621d373cade4e832627b4f6', 20170405, 127, 8, 18);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`catID`,`catIDUtilisateur`);

--
-- Index pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  ADD PRIMARY KEY (`rdvID`);

--
-- Index pour la table `suivi`
--
ALTER TABLE `suivi`
  ADD PRIMARY KEY (`suiIDSuiveur`,`suiIDSuivi`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`utiID`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `catID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  MODIFY `rdvID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;
--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `utiID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
