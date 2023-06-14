SELECT
	ca.contract_id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	date(c.created) AS data_cadastro,
	COALESCE((SELECT s.title FROM service_products AS s WHERE s.id = pl.service_product_id), (SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id)) AS plano,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor,
	ca.activation_date AS data_ativacao,
	nf.total_amount_liquid AS valor_ativacao,
	/*(SELECT campt.title FROM crm_campaigns AS campt WHERE campt.id = camp.campaign_id) AS campanha,*/
	c.v_status AS status_contrato
FROM
	contract_assignment_activations AS ca
INNER JOIN 
	contracts AS c ON ca.contract_id = c.id
INNER JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN 
	invoice_notes AS nf ON ca.invoice_note_id = nf.id
LEFT JOIN
	authentication_contracts AS pl ON ca.contract_id = pl.contract_id
LEFT JOIN 
	contract_items AS serv ON c.id = serv.contract_id
	/* LEFT JOIN 
	crm_person_oportunities AS camp ON p.id = camp.person_id */ 
WHERE
	c.company_place_id != 3
	AND c.seller_1_id IN (71653, 73393, 31230, 82630, 75253, 67079, 73392, 1160, 79035, 1120, 7754, 82804, 81019, 79620, 81640, 28791, 81643, 82713, 93, 27178, 84345, 74904, 71416) /*  AND camp.campaign_id = 2 ----- AND pl.service_product_id = 2852*/
GROUP BY
	c.id
ORDER BY
	ca.activation_date
