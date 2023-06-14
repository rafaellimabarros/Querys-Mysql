SELECT
	fatr.client_id AS id_cliente,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS empresa_contrato,
	(SELECT nf.title FROM financers_natures AS nf WHERE fatr.financer_nature_id = nf.id) AS natureza_financeira,
	fat.bank_title_number,
	fat.title AS fatura,
	fat.entry_date AS emissao,
	fat.expiration_date AS vencimento,
	fatr.receipt_date AS data_liquidacao,
	(SELECT bank.description FROM bank_accounts AS bank WHERE bank.id = fatr.bank_account_id) AS usuário_liq,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	fatr.amount AS valor_original,
	fatr.fine_amount AS multa,
	fatr.increase_amount AS juros,
	fatr.bank_tax_amount AS desconto_banco,
	fatr.total_amount AS total_recebido
FROM 
	financial_receipt_titles AS fatr
LEFT JOIN
	financial_receivable_titles AS fat ON fatr.financial_receivable_title_id = fat.id
INNER JOIN
	people AS p ON fatr.client_id = p.id
LEFT JOIN 
	contracts AS c ON fatr.client_id = c.client_id
WHERE 
	fat.expiration_date BETWEEN '2021-12-11' AND '2021-12-20'
	AND fatr.receipt_date BETWEEN '2021-12-23' AND '2021-12-31'
	AND c.company_place_id != 3
	AND fat.title LIKE 'FAT%'
	AND fat.financer_nature_id NOT IN (127, 140, 128, 199)
	AND fat.financial_collection_type_id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 28, 29)
GROUP BY
	fat.title
ORDER BY
	fatr.receipt_date DESC