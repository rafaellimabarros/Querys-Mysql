SELECT 
	p.id AS id_contrato,
	p.name AS nome,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id) AS local_empresa,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.cell_phone_1 AS celular,
	p.cell_phone_2 AS celular2,
	p.phone AS telefone,
	p.email AS email,
	p.neighborhood AS bairro,
	p.city AS cidade,
	fat.title AS fatura,
	fat.bank_title_number AS NN,
	fat.typeful_line AS codigo_barras,
	fat.document_amount AS valor,
	fat.balance AS saldo,
	fat.expiration_date AS vencimento,
	fat.competence AS competencia,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	fat.complement AS complemento,
	(SELECT tc.title FROM financial_collection_types AS tc WHERE fat.financial_collection_type_id = tc.id) AS tipo_cobranca,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira
FROM
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN
	contracts AS c ON (fat.contract_id = c.id)
WHERE 
	fat.p_is_receivable = 1
	AND fat.expiration_date BETWEEN '2021-04-01' AND '2021-04-30'
	AND c.company_place_id = 2
ORDER BY
	fat.expiration_date DESC;