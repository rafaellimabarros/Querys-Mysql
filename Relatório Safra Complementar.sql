SELECT 
	p.name AS nome,
	fat.title AS fatura,
	fat.title_amount AS valor,
	fat.entry_date AS emissao,
	fat.expiration_date AS vencimento,
	if(fat.balance = 0, "Pago", "Em Aberto") AS status_pg,
	DATE_FORMAT(fat.competence, '%m-%Y') AS data_mes,
	(SELECT cv.title FROM contract_date_configurations AS cv WHERE c.contract_date_configuration_id = cv.id) AS ciclo_faturamento,
	if(fev.financial_title_occurrence_type_id = 67, "SIM", "NÃO") AS faturamento_complementar
FROM 
	financial_receivable_titles AS fat
INNER JOIN 
	people AS p ON fat.client_id = p.id
INNER JOIN 
	financial_receivable_title_occurrences AS fev ON fat.id = fev.financial_receivable_title_id
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE 
	fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.competence BETWEEN '2022-01-01' AND '2022-01-31'
	AND fev.financial_title_occurrence_type_id = 67
GROUP BY
	p.id,
	fat.title
	
	
/*LISTA DE CLIENTES COM MENSALIDADE ACIMA DE 99,90 QUE SEJA PESSOA FÍSICA.*/