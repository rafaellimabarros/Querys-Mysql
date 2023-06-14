SELECT 
	(SELECT p.name FROM people AS p WHERE p.id = logp.person_id) AS cliente,
	(SELECT p.name FROM people AS p WHERE p.id = logp.responsible_id) AS responsavel,
	logp.description AS descricao,
	logp.before_update AS antes, 
	logp.after_update AS depois,
	logp.created AS data_efetivacao
FROM people_occurrences AS logp
WHERE created > '2021-06-01' AND after_update LIKE '%E-mail%' AND logp.description = "Cadastro Editado" AND logp.responsible_id IN 
	(31646, 132, 57, 9464, 31, 322, 66615, 28746, 161, 157, 146, 105, 103, 314, 165, 85, 74, 37, 115) 