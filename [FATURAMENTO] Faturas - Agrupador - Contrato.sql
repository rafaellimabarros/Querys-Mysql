SELECT
	c.id AS id_contrato,
	p.name AS nome_cliente,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = ag.company_place_id) AS empresa_agrupador,
	(SELECT comp.description FROM companies_places AS comp WHERE comp.id = C.company_place_id) AS empresa_contrato,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = ag.financial_operation_id) AS operacao_agrupador,
	(SELECT op.title FROM financial_operations AS op WHERE op.id = c.operation_id) AS operacao_contrato,
	c.v_status AS status_contrato,
	(SELECT s.title FROM service_products AS s WHERE s.id = serv.service_product_id) AS plano,
	serv.total_amount AS valor_plano,
	fat.title_amount AS valor_fatura,
	fat.expiration_date AS vencimento,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	IF(fat.p_is_receivable, "Não", "Sim") AS liquidado
FROM
	contract_configuration_billings AS ag
INNER JOIN 
	people AS p ON ag.client_id = p.id
INNER JOIN
	contracts AS c ON ag.contract_id = c.id
INNER JOIN 
	contract_items AS serv ON ag.id = serv.contract_configuration_billing_id
INNER JOIN
	financial_receivable_titles AS fat ON ag.contract_id = fat.contract_id
WHERE 
	fat.expiration_date BETWEEN '2021-06-01' AND '2021-06-30'
	AND fat.financer_nature_id IN (59, 132)
	AND fat.title LIKE "FAT%"
	AND ag.id IN (SELECT MAX(ag.id) FROM contract_configuration_billings AS ag WHERE ag.contract_id = c.id)