SELECT
	c.id AS id_contrato,
	c.v_status AS status_contrato,
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	fat.title AS fatura,
	fat.balance AS valor,
	fat.entry_date AS emissao,
	fat.expiration_date AS vencimento,
	fat.competence AS competencia,
	(SELECT u.name FROM v_users AS u WHERE u.id = fat.created_by) AS usuario_criador,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	(SELECT oper.title FROM financial_operations AS oper WHERE fat.financial_operation_id = oper.id) operacao,
	(SELECT tipocobranca.title FROM financial_collection_types AS tipocobranca WHERE fat.financial_collection_type_id = tipocobranca.id) AS natureza_financeira,
	(SELECT comp.description FROM companies_places AS comp WHERE fat.company_place_id = comp.id) AS empresa
FROM 
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
WHERE
	fat.entry_date = '2021-07-13'
	AND fat.title LIKE "FAT%"
	AND fat.created_by = 57
GROUP BY
	fat.title