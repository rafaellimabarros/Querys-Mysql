SELECT 
	(SELECT emp.description FROM companies_places as emp WHERE p.company_place_id = emp.id) AS empresa_contrato,
	p.name AS nome,
	tit.bank_title_number AS NN,
	tit.title AS fatura,
	tit.entry_date AS emissao,
	titr.client_paid_date AS data_liquidacao,
	titr.total_amount AS total_recebido,
	(SELECT bank.description FROM bank_accounts AS bank WHERE bank.id = titr.bank_account_id) AS conta_liq,
	(SELECT nf.title FROM financers_natures AS nf WHERE titr.financer_nature_id = nf.id) AS natureza_financeira
FROM 
	financial_receipt_titles AS titr
LEFT JOIN
	financial_receivable_titles AS tit ON titr.financial_receivable_title_id = tit.id
INNER JOIN
	people AS p ON titr.client_id = p.id
WHERE 
	tit.entry_date BETWEEN '2021-04-01' AND '2021-04-30' AND titr.receipt_date BETWEEN '2021-04-01' AND '2021-04-30' AND titr.financer_nature_id = 140 AND tit.financial_collection_type_id IS NOT NULL
ORDER BY
	titr.client_paid_date DESC
	
	