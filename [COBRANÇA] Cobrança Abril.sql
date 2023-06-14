SELECT
	fat.client_id AS id_client,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.cell_phone_2 AS celular2,
	p.phone AS telefone,
	fat.title_amount AS valor_original,
	fat.balance AS saldo,
	fat.title AS fatura,
	fat.typeful_line AS codigo_barras,
	fat.complement AS complemento,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	fat.expiration_date AS vencimento,
	fat.competence AS competencia,
	fat.type,
	(SELECT tc.title FROM financial_collection_types AS tc WHERE fat.financial_collection_type_id = tc.id) AS tipo_cobranca,
	(SELECT emp.description FROM companies_places as emp WHERE p.company_place_id = emp.id) AS empresa_contrato
FROM 
	financial_receivable_titles AS fat
INNER JOIN
	people AS p ON fat.client_id = p.id
WHERE 
	fat.expiration_date BETWEEN '2021-04-01' AND '2021-04-10' AND fat.p_is_receivable = 1 AND fat.type != 2 
ORDER BY
	fat.expiration_date DESC