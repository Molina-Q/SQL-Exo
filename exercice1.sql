#exo 1
/*a) Donner la liste des titres des représentations*/
SELECT titre
FROM representation

/*b) Donner la liste des titres des représentations ayant lieu à l'opéra Bastille*/
SELECT titre
FROM representation
WHERE lieu = "l'opéra Bastille"

/*c) Donner la liste des noms des musiciens et des titres des représentations auxquelles ils participent*/
SELECT nom_musicien, titre
FROM representation
INNER JOIN musicien ON representation.id_representation = musicien.representation_id 

/*d)  Donner la liste des titres des représentations, les lieux et les tarifs pour la journée du 14/09/2014.*/
SELECT titre, lieu, tarif, date
FROM representation 
INNER JOIN programmer ON representation.id_representation = programmer.representation_id
WHERE DATE="2014-09-14"

#exo 2
/*a) Quel est le nombre total d'étudiants ?*/
select count(num_etudiant)
FROM etudiant

/*b) Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?*/
SELECT min(note) ,max(note)
FROM evaluer

/*c) Quelles sont les moyennes de chaque étudiant dans chacune des matières ?*/
CREATE OR REPLACE VIEW moyenneEtuByMatiere AS
SELECT CONCAT(prenom, " " , nom) AS full_name, libelle_mat, Avg(note) AS moyenne_note
FROM evaluer AS ev
INNER JOIN etudiant AS et ON ev.etudiant_num = et.num_etudiant 
INNER JOIN matiere AS m ON ev.matiere_code = m.code_matiere
GROUP BY prenom, nom, libelle_mat

/*d) Quelles sont les moyennes par matière ?*/
SELECT libelle_mat, avg(moyenne_note)
FROM moyenneEtuByMatiere
GROUP BY libelle_mat

/*e) Quelle est la moyenne générale de la promotion ?*/
CREATE OR REPLACE VIEW moyenneGeneEtu AS
SELECT full_name, avg(moyenne_note) AS moyenne_general
FROM moyenneEtuByMatiere
GROUP BY full_name
--
SELECT *
FROM moyenneGeneEtu

/*f) Quelle est la moyenne générale de la promotion ?*/
SELECT AVG(moyenne_general)
FROM moyenneGeneEtu

/*g) Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ?*/
SELECT moyenne_general
FROM moyenneGeneEtu
WHERE moyenne_general >= (SELECT AVG(moyenne_general) FROM moyenneGeneEtu)

#exo 3
/*a) Numéros et libellés des articles dont le stock est inférieur à 10 ?*/
SELECT num_art, libelle
FROM articles
WHERE stock < 10

/*b) Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?*/
SELECT *
FROM articles
WHERE prix_invent BETWEEN 100 AND 300

/*c) Liste des fournisseurs dont on ne connaît pas l'adresse ?*/
SELECT *
FROM fournisseurs
WHERE adr_four IS NULL

/*d) Liste des fournisseurs dont le nom commence par "STE" ?*/
SELECT *
FROM fournisseurs
WHERE nom_four LIKE 'STE%'

/*e) Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours ?*/
SELECT nom_four, adr_four
FROM fournisseurs
INNER JOIN acheter ON fournisseurs.num_four = acheter.four_num
WHERE delai > 20

/*f) Nombre d'articles référencés ?*/
SELECT COUNT(num_art)
FROM articles

/*g) Valeur du stock ?*/
SELECT *, (prix_invent * stock) AS valeur_stock
FROM articles

/*h) Numéros et libellés des articles triés dans l'ordre décroissant des stocks ?*/
SELECT *
FROM articles
ORDER BY stock DESC

/*i) Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen ?*/
SELECT num_art, libelle, COUNT(num_art) AS nb_achat, min(prix_achat) AS prix_min, max(prix_achat) AS prix_max, AVG(prix_achat) AS prix_avg
FROM acheter
INNER JOIN articles ON acheter.art_num = articles.num_art
GROUP BY num_art, libelle

/*j) Délai moyen pour chaque fournisseur proposant au moins 2 articles ?*/
SELECT nom_four, count(num_art) AS nb_achat, AVG(delai)
FROM acheter
INNER JOIN articles ON acheter.art_num = articles.num_art
INNER JOIN fournisseurs ON acheter.four_num = fournisseurs.num_four
GROUP BY nom_four
HAVING nb_achat >= 2
ORDER BY nb_achat desc

#exo4
/*a)  Liste de tous les étudiants*/
SELECT *
FROM etudiant

/*b) Liste de tous les étudiants, classée par ordre alphabétique inverse*/
SELECT *
FROM etudiant
ORDER BY nom desc

/*c) Libellé et coefficient (exprimé en pourcentage) de chaque matière*/

-- ma réponse
SELECT libelle, (coeff * 100 / (SELECT sum(coeff) FROM matiere)) AS coef_percent
FROM matiere
GROUP BY libelle, coef_percent

-- réponsé attendu pour l'exo
SELECT libelle, (coef * 100)  AS coef_percent
FROM matiere 
GROUP BY libelle, coef_percent

/*d) Nom et prénom de chaque étudiant*/
SELECT CONCAT(prenom, " " , nom) AS full_name
FROM etudiant

/*e) Nom et prénom des étudiants domiciliés à Lyon*/
SELECT CONCAT(prenom, " " , nom) AS full_name
FROM etudiant
WHERE ville = "Lyon"

/*f) Liste des notes supérieures ou égales à 10*/
SELECT *
FROM notation
WHERE note >= 10

/*g) Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014*/
SELECT *
FROM epreuve
WHERE date_epreuve BETWEEN "2014-01-01" AND "2014-06-30"

/*h) Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll" (LL)*/
SELECT *
FROM etudiant
WHERE ville LIKE '%ll%'

/*i) Prénoms des étudiants de nom Dupont, Durand ou Martin*/
SELECT *
FROM etudiant
WHERE nom IN('Dupont', 'Durand', 'Martin')
ORDER BY nom

/*j) Somme des coefficients de toutes les matières*/
SELECT count(code_mat) AS nb_matiere, SUM(coeff) AS somme_coeff
FROM matiere

/*k) Nombre total d'épreuves*/
SELECT count(num_epreuve) AS nb_epreuves
FROM epreuve

/*l) Nombre de notes indéterminées (NULL)*/
SELECT note
FROM notation
WHERE note IS NULL 

/*m) Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière*/
SELECT num_epreuve, mat_code, date_epreuve, lieu, libelle
FROM epreuve
INNER JOIN matiere ON epreuve.mat_code = matiere.code_mat

/*n) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue*/
SELECT note, CONCAT(nom, " ", prenom) AS full_name
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
WHERE note IS NOT null
ORDER BY full_name

/*o) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue et le libellé de la matière concernée*/
SELECT note, CONCAT(nom, " ", prenom) AS full_name, libelle 
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
INNER JOIN matiere ON epreuve.mat_code = matiere.code_mat
WHERE note IS NOT null
ORDER BY full_name

/*p) Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20*/
SELECT CONCAT(nom, " ", prenom) AS full_name
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
WHERE note >=20
ORDER BY full_name

/*q) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)*/
SELECT CONCAT(nom, " ", prenom) AS full_name, avg(note)
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
GROUP BY full_name

/*r) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom), classées de la meilleure à la moins bonne*/
SELECT CONCAT(nom, " ", prenom) AS full_name, avg(note)
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
GROUP BY full_name
ORDER BY avg(note) desc

/*s) Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve*/
CREATE OR REPLACE VIEW nbEpreuveByMat AS
SELECT libelle , avg(note) ,COUNT(epreuve_num) AS nb_epreuve
FROM notation
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
INNER JOIN matiere ON epreuve.mat_code = matiere.code_mat
WHERE (SELECT COUNT(epreuve_num) FROM notation) > 3
GROUP BY libelle
--
SELECT * 
FROM nbEpreuveByMat 
WHERE nb_epreuve > 2

/*t) Moyennes des notes obtenues aux épreuves (indiquer le numéro d'épreuve) où moins de 6 étudiants ont été notés*/
CREATE OR REPLACE VIEW moyenneEpreuve AS
SELECT num_epreuve ,avg(note), COUNT(etu_num) AS nb_etudiants
FROM notation
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve 
GROUP BY num_epreuve
--
SELECT * 
FROM moyenneEpreuve 
WHERE nb_etudiants < 6

#exo 5
/*a) Ajouter un nouveau fournisseur avec les attributs de votre choix*/
INSERT INTO fournisseur (nom_fourn, statut, ville_f)
VALUES ('fournisseur1', 'Ouverte', 'Strasbourg')

/*b)  Supprimer tous les produits de couleur noire et de numéros compris entre 100 et 1999*/
DELETE FROM produit
WHERE couleur = 'noir' 
AND num_produit BETWEEN 100 AND 1999

/*c) Changer la ville du fournisseur 3 par Mulhouse*/
UPDATE fournisseur 
SET ville_f ='Mulhouse'
WHERE num_fourn  = '3'