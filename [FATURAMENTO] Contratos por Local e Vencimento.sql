SELECT
	c.id,
	p.name AS nome,
	COALESCE(p.cell_phone_1, p.phone) AS telefone,
/*
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	COALESCE((SELECT s.id FROM service_products AS s WHERE s.id = con.service_product_id), (SELECT s.id FROM service_products AS s WHERE s.id = serv.service_product_id)) AS id,
	COALESCE((SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id), (SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id)) AS plano,
	c.amount AS valor_contrato,*/
	(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS local_contrato
/*	c.id, 
	c.related_people, 
	c.responsible_financial_id,
	p.name,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone*/
FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN 
	authentication_contracts AS con ON c.client_id = con.contract_id
LEFT JOIN
	contract_items AS serv ON c.id = serv.contract_id
WHERE c.company_place_id = 9 
	AND c.contract_date_configuration_id IN (3, 5, 6)
	and c.v_stage = "Aprovado" 
	and c.v_status != "Cancelado" 
	AND c.v_status != "Encerrado"
GROUP BY 
	c.id