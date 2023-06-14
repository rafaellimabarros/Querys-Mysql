SELECT
	p.name AS fornecedor,
	COUNT(p.name) AS numero_contas_pagas
FROM 
	people AS p
INNER JOIN 
	financial_paid_titles AS cont ON p.id = cont.supplier_id
WHERE
	cont.payment_date BETWEEN '2021-09-01' AND '2021-09-30'
GROUP BY
	p.id
ORDER BY
	numero_contas_pagas DESC 
	