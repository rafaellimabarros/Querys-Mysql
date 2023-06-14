SELECT
	ca.contract_id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	date(c.created) AS data_cadastro,
	c.amount AS valor_contrato,
	COALESCE((SELECT serv.title FROM service_products AS serv WHERE serv.id = pl.service_product_id), (SELECT serv.title FROM service_products AS serv WHERE serv.id = ci.service_product_id)) AS plano,
	(SELECT serv.title FROM service_products AS serv WHERE serv.id = pl.service_product_id) AS plano,
	ost.protocol AS protocolo,
	(SELECT tos.title FROM incident_types AS tos WHERE tos.id = ost.incident_type_id) AS tipo_os,
	nf.total_amount_liquid AS valor_ativacao,
	(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa,
	c.v_status AS status_contrato
FROM
	contract_assignment_activations AS ca
INNER JOIN 
	contracts AS c ON ca.contract_id = c.id
INNER JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN
	assignment_incidents AS ost ON ca.assignment_id = ost.assignment_id
LEFT JOIN 
	invoice_notes AS nf ON ca.invoice_note_id = nf.id
LEFT JOIN
	authentication_contracts AS pl ON ca.contract_id = pl.contract_id
LEFT JOIN 
	contract_items AS ci ON c.id = ci.contract_id
WHERE
	ca.activation_date BETWEEN '2022-03-01' AND '2022-03-31' AND c.company_place_id != 3 /*  AND camp.campaign_id = 2 ----- AND pl.service_product_id = 2852*/
GROUP BY 
	c.id
ORDER BY
	ca.activation_date

