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
	fatr.receipt_date BETWEEN '2021-02-01' AND '2021-06-15' AND fat.financial_collection_type_id IS NOT NULL AND fatr.bank_account_id = 75 AND c.company_place_id != 3
GROUP BY 
	fat.title
ORDER BY
	fatr.receipt_date DESC