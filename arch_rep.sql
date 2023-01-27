-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 15 déc. 2021 à 07:48
-- Version du serveur :  5.7.24
-- Version de PHP :  7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `ige41`
--

-- --------------------------------------------------------

--
-- Structure de la table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
CREATE TABLE IF NOT EXISTS `clubs` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_pays` int(4) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_team_name` (`nom`),
  KEY `ind_pays` (`id_pays`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `clubs`
--

INSERT INTO `clubs` (`id`, `id_pays`, `nom`, `ville`, `logo`) VALUES
(5, 6, 'FC Liverpool', 'Liverpool', 'https://upload.wikimedia.org/wikipedia/fr/thumb/5/54/Logo_FC_Liverpool.svg/1200px-Logo_FC_Liverpool.svg.png'),
(6, 7, 'FC Barcelona', 'Barcelona', 'https://upload.wikimedia.org/wikipedia/fr/thumb/a/a1/Logo_FC_Barcelona.svg/1200px-Logo_FC_Barcelona.svg.png'),
(7, 7, 'Real Madrid', 'Madrid', 'https://upload.wikimedia.org/wikipedia/fr/thumb/c/c7/Logo_Real_Madrid.svg/1200px-Logo_Real_Madrid.svg.png'),
(9, 8, 'Juventus Torino', 'Turin', 'https://upload.wikimedia.org/wikipedia/fr/thumb/9/9f/Logo_Juventus.svg/1200px-Logo_Juventus.svg.png'),
(10, 8, 'AC Milano', 'Milan', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Logo_of_AC_Milan.svg/1200px-Logo_of_AC_Milan.svg.png'),
(35, 6, 'Manchester City', 'Manchester', '/logos/Manchester City.jpg'),
(36, 9, 'PSG', 'Paris', '/logos/PSG.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `matches`
--

DROP TABLE IF EXISTS `matches`;
CREATE TABLE IF NOT EXISTS `matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_guest` int(5) NOT NULL,
  `id_visitor` int(5) NOT NULL,
  `score_guest` int(2) NOT NULL DEFAULT '0',
  `score_visitor` int(2) NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_guest` (`id_guest`),
  KEY `ind_visitor` (`id_visitor`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `matches`
--

INSERT INTO `matches` (`id`, `id_guest`, `id_visitor`, `score_guest`, `score_visitor`, `date`) VALUES
(25, 6, 9, 0, 0, '2021-12-29');

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `flag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_pays` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `nom`, `flag`) VALUES
(5, 'Allemagne', 'https://www.orientation-pour-tous.fr/local/cache-gd2/03/1526e1ad6a1bbd95be35a0e249c358.jpg?1598280717'),
(6, 'Angleterre', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Flag_of_England.svg'),
(7, 'Espagne', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTMT3-1bsoQZI-nd9OeLi6Pm2qADF5XmrBiZw&usqp=CAU'),
(8, 'Italie', 'https://upload.wikimedia.org/wikipedia/commons/0/03/Flag_of_Italy.svg'),
(9, 'France', 'ae5ry54');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `id_pays` int(4) NOT NULL,
  `id_club` int(5) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_user_name` (`nom`),
  KEY `id_pays` (`id_pays`),
  KEY `ind_user_club` (`id_club`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `id_pays`, `id_club`, `password`) VALUES
(1, 'ilyes', 7, 6, 'ige41');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD CONSTRAINT `FK_team_pays` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`);

--
-- Contraintes pour la table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `FK_matche_guest` FOREIGN KEY (`id_guest`) REFERENCES `clubs` (`id`),
  ADD CONSTRAINT `FK_matche_visitor` FOREIGN KEY (`id_visitor`) REFERENCES `clubs` (`id`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_user_club` FOREIGN KEY (`id_club`) REFERENCES `clubs` (`id`),
  ADD CONSTRAINT `FK_user_nation` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
