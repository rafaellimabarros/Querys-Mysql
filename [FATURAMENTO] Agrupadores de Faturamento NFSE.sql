SELECT DISTINCT
	ag.id,
	c.id AS id_contrato,
	p.name,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = ag.company_place_id) AS empresa_agrupador,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = C.company_place_id) AS empresa_contrato,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = ag.financial_operation_id) AS operacao_agrupador,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = c.operation_id) AS operacao_contrato,
	(SELECT tipocobranca.title FROM financial_collection_types AS tipocobranca WHERE c.financial_collection_type_id = tipocobranca.id) AS tipo_cobranca_contrato,
	(SELECT tipocobranca.title FROM financial_collection_types AS tipocobranca WHERE ag.financial_collection_type_id = tipocobranca.id) AS tipo_cobranca_agrupador,
	(SELECT nf.title FROM financers_natures AS nf WHERE ag.financer_nature_id = nf.id) AS natureza_financeira_agrupador,
	(SELECT nf.title FROM financers_natures AS nf WHERE c.financer_nature_id = nf.id) AS natureza_financeira_contrato,
	ag.cnae,
	(SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id) AS plano,
	c.v_invoice_type AS tipo_faturamento,
	c.v_status AS status_contrato,
	serv.total_amount AS valor
FROM
	contract_configuration_billings AS ag
INNER JOIN 
	people AS p ON ag.client_id = p.id
INNER JOIN
	contracts AS c ON ag.contract_id = c.id
INNER JOIN 
	contract_items AS serv ON ag.id = serv.contract_configuration_billing_id
WHERE 
	c.v_status != "Cancelado" AND c.v_status != "Encerrado" AND ag.id IN (SELECT MAX(ag.id) FROM contract_configuration_billings AS ag WHERE ag.contract_id = c.id)
