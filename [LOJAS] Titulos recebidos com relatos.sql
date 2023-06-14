SELECT 
	p.name AS nome,
	p.city AS cidade,
	(SELECT comp.description FROM companies_places AS comp WHERE fat.company_place_id = comp.id AND fat.company_place_id != 3) AS empresa_fatura,
	fat.title AS fatura,
	fat.expiration_date AS vencimento,
	fatr.receipt_date AS data_recebimento,
	DATE_FORMAT(fat.expiration_date, '%m-%Y') AS data_mes,
	fatr.amount AS valor_original,
	fatr.fine_amount AS multa,
	fatr.increase_amount AS juros,
	fatr.bank_tax_amount AS desconto_banco,
	fatr.total_amount AS total_recebido,
	date(fev.date) AS ult_contato,
	fev.description,
	(SELECT p1.name FROM people AS p1 WHERE fev.person_id = p1.id) AS nome_op
FROM
	financial_receivable_titles AS fat
INNER JOIN  
	financial_receipt_titles AS fatr ON fat.id = fatr.financial_receivable_title_id
LEFT JOIN 
	financial_receivable_title_occurrences AS fev ON (fat.id = fev.financial_receivable_title_id) AND fev.date > '2022-02-01' AND fev.financial_title_occurrence_type_id IN (1, 2, 3, 5)
INNER JOIN 
	people AS p ON fatr.client_id = p.id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN  (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fatr.receipt_date BETWEEN '2022-03-01' AND '2022-03-28'
	AND fatr.receipt_date > fev.date
HAVING
	fat.expiration_date <= CURDATE() - INTERVAL 21 DAY 