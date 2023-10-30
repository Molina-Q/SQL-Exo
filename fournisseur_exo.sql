-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour fournisseurs_exo
CREATE DATABASE IF NOT EXISTS `fournisseurs_exo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fournisseurs_exo`;

-- Listage de la structure de table fournisseurs_exo. acheter
CREATE TABLE IF NOT EXISTS `acheter` (
  `nom_fourn_id` int NOT NULL,
  `nom_art_id` int NOT NULL,
  `prix_achat` float NOT NULL,
  `delai` datetime NOT NULL,
  KEY `FK_acheter_articles` (`nom_art_id`),
  KEY `nom_fourn_id` (`nom_fourn_id`),
  CONSTRAINT `FK_acheter_articles` FOREIGN KEY (`nom_art_id`) REFERENCES `articles` (`num_art`),
  CONSTRAINT `FK_acheter_fournisseurs` FOREIGN KEY (`nom_fourn_id`) REFERENCES `fournisseurs` (`num_fourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table fournisseurs_exo.acheter : ~0 rows (environ)

-- Listage de la structure de table fournisseurs_exo. articles
CREATE TABLE IF NOT EXISTS `articles` (
  `num_art` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stock` int NOT NULL,
  `prix_invent` float NOT NULL,
  PRIMARY KEY (`num_art`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table fournisseurs_exo.articles : ~0 rows (environ)

-- Listage de la structure de table fournisseurs_exo. fournisseurs
CREATE TABLE IF NOT EXISTS `fournisseurs` (
  `num_fourn` int NOT NULL AUTO_INCREMENT,
  `nom_fourn` varchar(255) NOT NULL,
  `adresse_fourn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ville_fourn` varchar(255) NOT NULL,
  PRIMARY KEY (`num_fourn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table fournisseurs_exo.fournisseurs : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
