SELECT 
	p.name AS nome,
	fat.title AS fatura,
	fat.expiration_date AS vencimento,
	fatr.receipt_date AS data_recebimento,
	DATE_FORMAT(fat.expiration_date, '%m-%Y') AS data_mes,
	fatr.amount AS valor_original,
	fatr.fine_amount AS multa,
	fatr.increase_amount AS juros,
	fatr.bank_tax_amount AS desconto_banco,
	fatr.total_amount AS total_recebido
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
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.deleted = 0
	AND fat.origin NOT IN  (2, 3, 5)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fatr.receipt_date BETWEEN '2021-12-01' AND '2021-12-31'
	AND fat.expiration_date BETWEEN '2021-12-01' AND '2021-12-31'