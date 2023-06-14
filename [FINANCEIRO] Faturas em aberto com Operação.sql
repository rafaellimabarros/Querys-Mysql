SELECT
	c.id AS id_contrato,
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS tipo_cadastro,
	c.v_status AS status_contrato,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id) AS empresa,
	fat.title AS fatura,
	fat.bank_title_number AS NN,
	fat.document_amount AS valor,
	fat.balance AS Saldo,
	fat.expiration_date AS vencimento,
	fat.competence AS competencia,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	(SELECT op.title FROM financial_operations AS op WHERE fat.financial_operation_id = op.id) AS operacao
FROM 
	financial_receivable_titles AS fat
JOIN 
	people AS p ON (fat.client_id = p.id) 
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
WHERE 
	fat.p_is_receivable = 1 -- em aberto, 
	AND fat.expiration_date BETWEEN '2021-04-01' AND '2021-04-30'
	AND c.company_place_id = 2
GROUP BY
	fat.title