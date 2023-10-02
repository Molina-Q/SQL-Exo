#exo 1
SELECT titre
FROM representation

SELECT titre
FROM representation
WHERE lieu = "l'opéra Bastille"

SELECT nom_musicien, titre
FROM representation
INNER JOIN musicien ON representation.id_representation = musicien.representation_id 

SELECT titre, lieu, tarif, date
FROM representation 
INNER JOIN programmer ON representation.id_representation = programmer.representation_id
WHERE DATE="2014-09-14"

#exo 2
select count(num_etudiant)
FROM etudiant

SELECT min(note) ,max(note)
FROM evaluer

FROM etudiant
INNER JOIN evaluer ON etudiant.num_etudiant = evaluer.etudiant_num
GROUP BY nom, prenom

CREATE OR REPLACE VIEW moyenneEtuByMatiere AS
SELECT nom, prenom, libelle_mat, Avg(note)
FROM evaluer
INNER JOIN etudiant ON evaluer.etudiant_num = etudiant.num_etudiant 
INNER JOIN matiere ON evaluer.matiere_code = matiere.code_matiere
GROUP BY nom, prenom

