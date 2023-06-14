SELECT DISTINCT ON (fat.id)
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS tipo_cliente,
	p.city AS cidade,
	p.neighborhood AS bairro,
	fat.title AS fatura,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	fat.expiration_date AS vencimento,
   DATE_FORMAT(fat.competence, '%m-%Y') AS competencia,
   /*if(fatr.finished = true, 'SIM', 'NAO') AS baixado,*/
   CASE WHEN fatr.finished = TRUE THEN 'SIM' WHEN fatr.finished = FALSE THEN 'NAO' END AS baixado,
	fatr.receipt_date AS data_recebimento,
	fatr.amount AS valor_original,
	fatr.fine_amount AS multa,
	fatr.increase_amount AS juros,
	fatr.bank_tax_amount AS desconto_banco,
	(fatr.total_amount) - (fatr.bank_tax_amount) AS total_recebido,
	(SELECT comp.description FROM companies_places AS comp WHERE fat.company_place_id = comp.id) AS local_fatura,
	(SELECT pf.title FROM payment_forms AS pf WHERE pf.id = fatr.payment_form_id) AS forma_pagamento
FROM
	financial_receivable_titles AS fat
INNER JOIN  
	financial_receipt_titles AS fatr ON fat.id = fatr.financial_receivable_title_id
INNER JOIN 
	people AS p ON fatr.client_id = p.id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.deleted = false
	AND (fat.financial_collection_type_id IS NULL OR fat.origin IN (7,4))
	AND DATE(fatr.receipt_date) BETWEEN '2022-04-01' AND '2022-04-10'
