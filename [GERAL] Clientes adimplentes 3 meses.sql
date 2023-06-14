SELECT
	c.id,
	p.name,
	COUNT(c.id) AS pagamentos_realizados,
	p.city,
	fat.title AS fatura,
	fat.balance,
	fat.p_is_receivable
	#fatr.receipt_date AS data_recebimento,
	#fatr.total_amount AS total_recebido
FROM
	financial_receivable_titles AS fat
INNER JOIN
	financial_receipt_titles AS fatr ON fat.id = fatr.financial_receivable_title_id
INNER JOIN
	people AS p ON fat.client_id = p.id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.`type` = 2
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id IN (59, 132, 222)
	AND c.v_status != "Cancelado"
	AND fat.expiration_date BETWEEN '2022-02-01' AND '2022-04-30'
	AND (fatr.receipt_date <= fat.expiration_date)
GROUP BY
	c.id
HAVING
	COUNT(c.id) >= 3 AND fat.p_is_receivable = 0 AND fat.balance = 0
	