SELECT 
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS tipo_cliente,
	p.city AS cidade,
	p.neighborhood AS bairro,
	fat.title AS fatura,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	fat.expiration_date AS vencimento,
        DATE_FORMAT(fat.competence, '%m-%Y') AS competencia,
	fatr.receipt_date AS data_recebimento,
	fatr.amount AS valor_original,
	fatr.fine_amount AS multa,
	fatr.increase_amount AS juros,
	fatr.bank_tax_amount AS desconto_banco,
	fatr.total_amount AS total_recebido,
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
	# fat.`type` = 2
	fat.financial_collection_type_id IS NOT NULL
	AND fat.deleted = 0
	# AND fat.origin NOT IN  (2, 3, 5)
	# AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	# AND fat.company_place_id != 3
	# AND fat.financer_nature_id != 158
	AND DATE(fatr.receipt_date) BETWEEN '2022-04-14' AND '2022-04-14'
GROUP BY
	fat.id