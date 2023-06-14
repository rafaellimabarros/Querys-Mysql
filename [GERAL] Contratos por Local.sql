SELECT 
	c.id,
	p.name,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	COALESCE((SELECT s.id FROM service_products AS s WHERE s.id = con.service_product_id), (SELECT s.id FROM service_products AS s WHERE s.id = serv.service_product_id)) AS id,
	COALESCE((SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id), (SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id)) AS plano,
	(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS local_contrato,
	(SELECT oper.title FROM financial_operations AS oper WHERE c.operation_id = oper.id) operacao_contrato,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = ag.financial_operation_id) AS operacao_agrupador
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
INNER JOIN 
	contract_configuration_billings AS ag ON c.id = ag.contract_id
LEFT JOIN 
	authentication_contracts AS con ON c.client_id = con.contract_id
LEFT JOIN
	contract_items AS serv ON c.id = serv.contract_id
WHERE 
	c.v_status != "Cancelado"
	AND c.v_status != "Encerrado"
	AND c.company_place_id = 5
	AND ag.id IN (SELECT MAX(ag.id) FROM contract_configuration_billings AS ag WHERE ag.contract_id = c.id)
GROUP BY
	c.id
