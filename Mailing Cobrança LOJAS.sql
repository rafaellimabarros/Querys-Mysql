SELECT 
	p.id AS id_contrato,
	c.v_status AS status_contrato,
	p.name AS nome,
	p.tx_id AS CPF,
	p.neighborhood AS bairro,
	p.city AS cidade,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone,
	p.cell_phone_1 AS celular1,
	fat.balance AS valor,
	fat.expiration_date AS vencimento

FROM 
	financial_receivable_titles AS fat
INNER JOIN 
	people AS p ON fat.client_id = p.id
LEFT JOIN 
	financial_receivable_title_occurrences AS fev ON fat.id = fev.financial_receivable_title_id AND (fev.financial_title_occurrence_type_id IN (1, 2, 3, 5) OR fev.financial_title_occurrence_type_id IS NULL) 
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
LEFT JOIN 
	authentication_contracts AS con ON fat.contract_id = con.contract_id
WHERE
	fat.p_is_receivable = 1
	AND p.city ='eusebio'
	AND fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.financer_nature_id NOT IN (158, 186, 199, 94)
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.renegotiated = 0
	AND NOT EXISTS (
	    SELECT '?' FROM people WHERE DATE((fev.date)) >= CURDATE() - INTERVAL 3 DAY
	)
	AND NOT EXISTS (
	    SELECT '?' FROM people WHERE DATE((fat.expiration_date)) >= CURDATE() - INTERVAL 19 DAY
	)
GROUP BY
	p.id,
	fat.id
HAVING 
	fat.expiration_date >= CURDATE() - INTERVAL 60 DAY
ORDER BY
	fat.expiration_date asc
