SELECT 
	p.name AS nome,
	fat.title AS fatura,
	fat.title_amount AS valor,
	fat.expiration_date AS vencimento,
	if(fat.balance = 0, "Pago", "Em Aberto") AS status_pg,
	DATE_FORMAT(fat.expiration_date, '%m-%Y') AS data_mes,
	(SELECT cv.title FROM contract_date_configurations AS cv WHERE c.contract_date_configuration_id = cv.id) AS ciclo_faturamento /*Ciclo de faturamento*/
FROM 
	financial_receivable_titles AS fat
INNER JOIN 
	people AS p ON fat.client_id = p.id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE 
	fat.p_is_receivable = 1 
	AND fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.expiration_date BETWEEN '2021-12-05' AND DATE(CURDATE()-5)

	

/* Vencimento dia 05 - Puxar o Relatorio no dia 10*/
/* -1 até -5 Lembrete*/