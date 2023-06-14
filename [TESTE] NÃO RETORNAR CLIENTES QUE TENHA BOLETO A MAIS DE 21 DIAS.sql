SELECT  
	fat.id,
	p.name AS nome,
	fat.title AS fatura,
	fat.title_amount AS valor,
	fat.expiration_date AS vencimento,
	datediff(CURDATE(),DATE(fat.expiration_date)) AS dias_atraso,
	DATE_FORMAT(fat.expiration_date, '%m-%Y') AS data_mes
FROM
	people AS p
INNER JOIN
	financial_receivable_titles AS fat ON (p.id = fat.client_id) AND p.id IN (SELECT p1.id FROM people AS p1 WHERE p1.id = fat.client_id AND p1.id IN (20220, 76560)
		GROUP BY
			p.id
		HAVING
			datediff(CURDATE(),DATE(fat.expiration_date)) < 21
	)
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.p_is_receivable = 1
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN  (2, 3, 5)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158 





	/* AND fat.expiration_date BETWEEN '2022-01-01' AND '2022-01-03' */
