SELECT
	c.id AS id_contrato,
	ag.id,
	p.name AS nome_cliente,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = ag.company_place_id) AS empresa_agrupador,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = C.company_place_id) AS empresa_contrato,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = ag.financial_operation_id) AS operacao_agrupador,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = c.operation_id) AS operacao_contrato,
	c.v_status AS status_contrato,
	(SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id) AS plano,
	serv.total_amount AS valor_plano
FROM
	contract_configuration_billings AS ag
INNER JOIN 
	people AS p ON ag.client_id = p.id
INNER JOIN
	contracts AS c ON ag.contract_id = c.id
INNER JOIN 
	contract_items AS serv ON ag.id = serv.contract_configuration_billing_id AND serv.deleted = 0
WHERE 
	c.company_place_id = 9
	AND ag.company_place_id = 9
	AND ag.deleted = 0
	AND ag.financial_operation_id IN (25, 46)
	AND c.v_status != 'Cancelado' AND c.v_status != 'Encerrado'
	# AND serv.deleted = 0