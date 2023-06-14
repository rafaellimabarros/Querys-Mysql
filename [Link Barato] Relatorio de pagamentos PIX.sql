SELECT 
	c.id AS contrato,
	p.name AS nome,
	fat.title AS fatura,
	fat.expiration_date AS vencimento,
	fatr.receipt_date AS data_recebimento,
	fatr.total_amount AS total_recebido,
	(SELECT pf.title from payment_forms AS pf WHERE pf.id = fatr.payment_form_id) AS forma_pagamento
FROM
	financial_receivable_titles AS fat
INNER JOIN  
	financial_receipt_titles AS fatr ON fat.id = fatr.financial_receivable_title_id
INNER JOIN 
	people AS p ON fatr.client_id = p.id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN  (7, 2, 3, 5)
	AND fat.company_place_id = 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.renegotiated = 0
	AND fatr.receipt_date BETWEEN '2021-11-01' AND '2022-05-30'
	AND c.id IN (52878, 53259)
	AND fatr.payment_form_id = 13
