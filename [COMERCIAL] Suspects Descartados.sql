SELECT
	p.id,
	p.name AS nome,
	p.email AS email,
	p.phone AS telefone,
	p.city AS cidade,
	(SELECT p.name FROM people AS p WHERE p.id = des.responsible_id) AS vendedor_1,
	(SELECT mot.title FROM crm_discart_motives AS mot WHERE des.crm_discart_motive_id = mot.id) AS motivo_descarte,
	(SELECT cont.title FROM crm_contact_origins AS cont WHERE cont.id = org.crm_contact_origin_id) AS origem_contato
FROM
	people_crm_information_interactions AS des
INNER JOIN
	people AS p ON des.client_id = p.id
INNER JOIN 
	people_crm_informations AS org ON des.client_id = org.person_id
WHERE
	des.crm_discart_motive_id IS NOT NULL AND org.crm_contact_origin_id IS NOT NULL
GROUP BY
	p.id
ORDER BY
	p.created
