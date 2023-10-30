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


-- Listage de la structure de la base pour ecole_exo
CREATE DATABASE IF NOT EXISTS `ecole_exo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecole_exo`;

-- Listage de la structure de table ecole_exo. etudiant
CREATE TABLE IF NOT EXISTS `etudiant` (
  `num_etudiant` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prenom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`num_etudiant`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_exo.etudiant : ~2 rows (environ)
INSERT INTO `etudiant` (`num_etudiant`, `nom`, `prenom`) VALUES
	(1, 'dupont', 'benoit'),
	(2, 'dupond', 'jean');

-- Listage de la structure de table ecole_exo. evaluer
CREATE TABLE IF NOT EXISTS `evaluer` (
  `etudiant_num` int NOT NULL,
  `matiere_code` int NOT NULL,
  `note` float NOT NULL,
  `date` date NOT NULL,
  KEY `FK_evaluer_matiere` (`matiere_code`) USING BTREE,
  KEY `FK__etudiant` (`etudiant_num`) USING BTREE,
  CONSTRAINT `FK_evaluer_etudiant` FOREIGN KEY (`etudiant_num`) REFERENCES `etudiant` (`num_etudiant`),
  CONSTRAINT `FK_evaluer_matiere` FOREIGN KEY (`matiere_code`) REFERENCES `matiere` (`code_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_exo.evaluer : ~3 rows (environ)
INSERT INTO `evaluer` (`etudiant_num`, `matiere_code`, `note`, `date`) VALUES
	(1, 1, 10, '2023-10-02'),
	(2, 3, 17, '2023-10-02'),
	(1, 2, 12, '2023-10-02'),
	(2, 2, 14, '2023-10-04');

-- Listage de la structure de table ecole_exo. matiere
CREATE TABLE IF NOT EXISTS `matiere` (
  `code_matiere` int NOT NULL AUTO_INCREMENT,
  `libelle_mat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `coef_mat` int NOT NULL,
  PRIMARY KEY (`code_matiere`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_exo.matiere : ~2 rows (environ)
INSERT INTO `matiere` (`code_matiere`, `libelle_mat`, `coef_mat`) VALUES
	(1, 'Math', 1),
	(2, 'Français', 2),
	(3, 'Techno', 1);

-- Listage de la structure de vue ecole_exo. moyenneetubymatiere
-- Création d'une table temporaire pour palier aux erreurs de dépendances de VIEW
CREATE TABLE `moyenneetubymatiere` (
	`full_name` VARCHAR(511) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`libelle_mat` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`moyenne_note` DOUBLE NULL
) ENGINE=MyISAM;

-- Listage de la structure de vue ecole_exo. moyennegeneetu
-- Création d'une table temporaire pour palier aux erreurs de dépendances de VIEW
CREATE TABLE `moyennegeneetu` (
	`full_name` VARCHAR(511) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`moyenne_general` DOUBLE NULL
) ENGINE=MyISAM;

-- Listage de la structure de vue ecole_exo. moyenneetubymatiere
-- Suppression de la table temporaire et création finale de la structure d'une vue
DROP TABLE IF EXISTS `moyenneetubymatiere`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `moyenneetubymatiere` AS select concat(`et`.`prenom`,' ',`et`.`nom`) AS `full_name`,`m`.`libelle_mat` AS `libelle_mat`,avg(`ev`.`note`) AS `moyenne_note` from ((`evaluer` `ev` join `etudiant` `et` on((`ev`.`etudiant_num` = `et`.`num_etudiant`))) join `matiere` `m` on((`ev`.`matiere_code` = `m`.`code_matiere`))) group by `et`.`prenom`,`et`.`nom`,`m`.`libelle_mat`;

-- Listage de la structure de vue ecole_exo. moyennegeneetu
-- Suppression de la table temporaire et création finale de la structure d'une vue
DROP TABLE IF EXISTS `moyennegeneetu`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `moyennegeneetu` AS select `moyenneetubymatiere`.`full_name` AS `full_name`,avg(`moyenneetubymatiere`.`moyenne_note`) AS `moyenne_general` from `moyenneetubymatiere` group by `moyenneetubymatiere`.`full_name`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
