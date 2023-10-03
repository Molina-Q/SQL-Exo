#exo 1
/*a)*/
SELECT titre
FROM representation

/*b)*/
SELECT titre
FROM representation
WHERE lieu = "l'opéra Bastille"

/*c)*/
SELECT nom_musicien, titre
FROM representation
INNER JOIN musicien ON representation.id_representation = musicien.representation_id 

/*d)*/
SELECT titre, lieu, tarif, date
FROM representation 
INNER JOIN programmer ON representation.id_representation = programmer.representation_id
WHERE DATE="2014-09-14"

#exo 2
/*a)*/
select count(num_etudiant)
FROM etudiant

/*b)*/
SELECT min(note) ,max(note)
FROM evaluer

/*c)*/
-- sans create view
SELECT nom, prenom, AVG(note)
FROM etudiant
INNER JOIN evaluer ON etudiant.num_etudiant = evaluer.etudiant_num
GROUP BY nom, prenom

-- avec create view
CREATE OR REPLACE VIEW moyenneEtuByMatiere AS
SELECT CONCAT(prenom, " " , nom) AS full_name, libelle, Avg(note) 
FROM evaluer
INNER JOIN etudiant ON evaluer.etudiant_num = etudiant.num_etudiant 
INNER JOIN matiere ON evaluer.matiere_code = matiere.code_matiere
GROUP BY prenom, nom, libelle

/*d)*/
SELECT libelle, Avg(note)
FROM evaluer
INNER JOIN matiere ON evaluer.matiere_code = matiere.code_matiere
GROUP BY libelle

/*e)*/
CREATE OR REPLACE VIEW moyenneGeneEtu AS
SELECT CONCAT(prenom, " " , nom) AS full_name, Avg(note) AS moyenne_general
FROM evaluer
INNER JOIN etudiant ON evaluer.etudiant_num = etudiant.num_etudiant 
GROUP BY prenom, nom

/*f)*/
CREATE OR REPLACE VIEW moyenneGenePromo AS
SELECT avg(moyenne_general) AS moyenne_promo
FROM moyennegeneetu

/*g)*/
SELECT moyenne_general 
FROM moyennegeneetu
WHERE moyenne_general > (SELECT AVG(moyenne_general) FROM moyennegeneetu)

#exo 3
/*a)*/
SELECT num_art, libelle
FROM articles
WHERE stock < 10

/*b)*/
SELECT *
FROM articles
WHERE prix_invent BETWEEN 100 AND 300

/*c)*/
SELECT *
FROM fournisseurs
WHERE adr_four IS NULL

/*d)*/
SELECT *
FROM fournisseurs
WHERE nom_four LIKE 'STE%'

/*e)*/
SELECT nom_four, adr_four
FROM fournisseurs
INNER JOIN acheter ON fournisseurs.num_four = acheter.four_num
WHERE delai > 20

/*f)*/
SELECT COUNT(num_art)
FROM articles

/*g)*/
SELECT *, prix_invent * stock AS valeur_stock
FROM articles

/*h)*/
SELECT *
FROM articles
ORDER BY stock DESC

/*i)*/
SELECT num_art, libelle, COUNT(num_art) AS nb_achat, min(prix_achat) AS prix_min, max(prix_achat) AS prix_max, AVG(prix_achat) AS prix_avg
FROM acheter
INNER JOIN articles ON acheter.art_num = articles.num_art
GROUP BY num_art, libelle

/*j)*/
SELECT nom_four, count(num_art) AS nb_achat, AVG(delai)
FROM acheter
INNER JOIN articles ON acheter.art_num = articles.num_art
INNER JOIN fournisseurs ON acheter.four_num = fournisseurs.num_four
GROUP BY nom_four
HAVING nb_achat >= 2
ORDER BY nb_achat desc

#exo4

/*a)*/
SELECT *
FROM etudiant

/*b)*/
SELECT *
FROM etudiant
ORDER BY nom desc

/*c)*/
SELECT *
FROM matiere

/*d)*/
SELECT CONCAT(prenom, " " , nom) AS full_name
FROM etudiant

/*e)*/
SELECT CONCAT(prenom, " " , nom) AS full_name
FROM etudiant
WHERE ville = "Lyon"

/*f)*/
SELECT *
FROM notation
WHERE note >= 10

/*g)*/
SELECT *
FROM epreuve
WHERE date_epreuve BETWEEN "2014-01-01" AND "2014-06-30"

/*h)*/
SELECT *
FROM etudiant
WHERE ville LIKE '%ll%'

/*i)*/
SELECT *
FROM etudiant
WHERE nom IN('Dupont', 'Durand', 'Martin')
ORDER BY nom

/*j)*/
SELECT count(code_mat) AS nb_matiere, SUM(coeff) AS somme_coeff
FROM matiere

/*k)*/
SELECT count(num_epreuve) AS nb_epreuves
FROM epreuve

/*l)*/
SELECT note
FROM notation
WHERE note IS NULL 
-- petit prob ici, les NULL ne sont pas comptés par count
/*m)*/
SELECT num_epreuve, mat_code, date_epreuve, lieu, libelle
FROM epreuve
INNER JOIN matiere ON epreuve.mat_code = matiere.code_mat

/*n)*/
SELECT note, CONCAT(nom, " ", prenom) AS full_name
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
WHERE note IS NOT null
ORDER BY full_name

/*o)*/
SELECT note, CONCAT(nom, " ", prenom) AS full_name, libelle 
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
INNER JOIN matiere ON epreuve.mat_code = matiere.code_mat
WHERE note IS NOT null
ORDER BY full_name

/*p)*/
SELECT CONCAT(nom, " ", prenom) AS full_name
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
WHERE note >=20
ORDER BY full_name

/*q)*/
SELECT CONCAT(nom, " ", prenom) AS full_name, avg(note)
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
GROUP BY full_name

/*r)*/
SELECT CONCAT(nom, " ", prenom) AS full_name, avg(note)
FROM notation
INNER JOIN etudiant ON notation.etu_num = etudiant.num_etu
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve
GROUP BY full_name
ORDER BY avg(note) desc

/*s)*/
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

/*t)*/
CREATE OR REPLACE VIEW moyenneEpreuve AS
SELECT num_epreuve ,avg(note), COUNT(etu_num) AS nb_etudiants
FROM notation
INNER JOIN epreuve ON notation.epreuve_num = epreuve.num_epreuve 
GROUP BY num_epreuve
--
SELECT * 
FROM moyenneEpreuve 
WHERE nb_etudiants >= 5

