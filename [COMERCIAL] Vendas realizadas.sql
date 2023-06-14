SELECT 
	(SELECT p.name FROM people AS p WHERE crm.person_id = p.id) AS nome,
	(SELECT p.name FROM people AS p WHERE crm.responsible_id = p.id) AS vendedor,
	crm.*
FROM crm_direct_selling_processes AS crm
WHERE crm.created BETWEEN '2021-11-01' AND '2021-11-31'