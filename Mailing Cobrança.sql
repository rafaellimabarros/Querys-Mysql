SELECT 
	fat.id AS id_fatura,
	p.id AS id_contrato,
	c.v_status AS status_contrato,
	p.name AS nome,
	p.tx_id AS CPF,
	p.neighborhood AS bairro,
	p.city AS cidade,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone,
	p.cell_phone_1 AS celular1,
	p.email AS email,
	fat.title AS fatura,
	fat.balance AS valor,
	fat.expiration_date AS vencimento,
	DATE(fev.date) AS ult_contato,
	fev.description,
	(SELECT p1.name FROM people AS p1 WHERE fev.person_id = p1.id) AS nome_op,
	DATE_FORMAT(fat.expiration_date, '%m-%Y') AS data_mes,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	c.amount AS valor_plano,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato
FROM 
	financial_receivable_titles AS fat
INNER JOIN 
	people AS p ON fat.client_id = p.id AND (SUBSTRING(p.tx_id, 11, 1) = 9 OR SUBSTRING(p.tx_id, 11, 1) = 8)
LEFT JOIN 
	financial_receivable_title_occurrences AS fev ON fat.id = fev.financial_receivable_title_id AND (fev.financial_title_occurrence_type_id IN (1, 2, 3, 5) OR fev.financial_title_occurrence_type_id IS NULL) 
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
LEFT JOIN 
	authentication_contracts AS con ON fat.contract_id = con.contract_id
WHERE
	fat.p_is_receivable = 1
	AND fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.renegotiated = 0
	AND NOT EXISTS (
		SELECT '?' FROM people WHERE DATE((fev.date)) >= DATE(CURDATE()-3)
	)
	AND NOT EXISTS (
		SELECT '?' FROM people WHERE DATE((fat.expiration_date)) <= DATE(CURDATE()-20) 
	)
GROUP BY
	p.id,
	fat.id
HAVING 
	fat.expiration_date <= DATE(CURDATE()-3)
ORDER BY
	fat.expiration_date asc