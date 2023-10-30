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


-- Listage de la structure de la base pour ecole_uml_exo
CREATE DATABASE IF NOT EXISTS `ecole_uml_exo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecole_uml_exo`;

-- Listage de la structure de table ecole_uml_exo. epreuve
CREATE TABLE IF NOT EXISTS `epreuve` (
  `num_epreuve` int NOT NULL AUTO_INCREMENT,
  `date_epreuve` date NOT NULL,
  `lieu` varchar(255) NOT NULL,
  PRIMARY KEY (`num_epreuve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_uml_exo.epreuve : ~0 rows (environ)

-- Listage de la structure de table ecole_uml_exo. etudiant
CREATE TABLE IF NOT EXISTS `etudiant` (
  `num_etudiant` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `date_de_naissance` date NOT NULL,
  `rue` varchar(255) NOT NULL,
  `cp` varchar(255) NOT NULL,
  `ville` varchar(255) NOT NULL,
  PRIMARY KEY (`num_etudiant`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_uml_exo.etudiant : ~0 rows (environ)
INSERT INTO `etudiant` (`num_etudiant`, `nom`, `prenom`, `date_de_naissance`, `rue`, `cp`, `ville`) VALUES
	(1, 'nn', 'nn', '2023-10-04', 'nn', '14', 'nn');

-- Listage de la structure de table ecole_uml_exo. matiere
CREATE TABLE IF NOT EXISTS `matiere` (
  `code_matiere` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `coef` int NOT NULL,
  PRIMARY KEY (`code_matiere`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_uml_exo.matiere : ~4 rows (environ)
INSERT INTO `matiere` (`code_matiere`, `libelle`, `coef`) VALUES
	(1, 'math', 5),
	(2, 'français', 2),
	(3, 'techno', 3),
	(4, 'musique', 1),
	(5, 'science', 1);

-- Listage de la structure de table ecole_uml_exo. notation
CREATE TABLE IF NOT EXISTS `notation` (
  `etudiant_num` int NOT NULL,
  `epreuve_num` int NOT NULL,
  `note` float NOT NULL,
  KEY `FK__etudiant` (`etudiant_num`),
  KEY `FK__epreuve` (`epreuve_num`),
  CONSTRAINT `FK__epreuve` FOREIGN KEY (`epreuve_num`) REFERENCES `epreuve` (`num_epreuve`),
  CONSTRAINT `FK__etudiant` FOREIGN KEY (`etudiant_num`) REFERENCES `etudiant` (`num_etudiant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ecole_uml_exo.notation : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
