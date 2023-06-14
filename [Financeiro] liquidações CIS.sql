SELECT
	c.id AS numero_contrato,
	p.name AS nome,
	(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS local_contrato,
	(SELECT emp.description FROM companies_places as emp WHERE fat.company_place_id = emp.id) AS local_fatura,
	(SELECT fo.title FROM financial_operations AS fo WHERE fo.id = fat.financial_operation_id) AS operacao,
	fat.competence AS competencia,
	fat.entry_date AS emissao,
	fat.expiration_date AS vencimento,
	fatr.receipt_date AS data_liquidacao,
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
	fat.entry_date BETWEEN '2021-09-01' AND '2021-09-30'
	AND fatr.receipt_date BETWEEN '2021-09-01' AND '2021-09-30'
	AND c.company_place_id != 3
	AND fat.title LIKE "FAT%"
	AND fat.financial_operation_id = 25
GROUP BY 
	fat.title
ORDER BY
	fatr.receipt_date DESC