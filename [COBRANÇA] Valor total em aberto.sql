SELECT
	SUM(fat.balance) AS valor_total
FROM 
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
LEFT JOIN
	contract_items AS con ON (c.id = con.contract_id)
WHERE
	fat.p_is_receivable -- em aberto,
	AND fat.expiration_date BETWEEN '2021-12-01' AND '2021-12-25'
	AND fat.title LIKE "FAT%"
	AND (c.contract_type_id NOT IN (4, 6 ,7) OR c.id IS NULL)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id NOT IN (127, 140, 128, 199)
	AND fat.financial_collection_type_id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 28, 29)


