SELECT 
	c.id AS id_contrato,
	p.name AS nome,
	p.cell_phone_1 AS telefone1,
	p.cell_phone_2 AS telfone2,
	p.phone AS telefone,
	c.v_status AS status_contrato,
	c.collection_day AS vencimento,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE pag.client_id = c.client_id) AS ult_liq,
	(SELECT ct.title FROM contract_types AS ct WHERE ct.id = c.contract_type_id) AS tipo_contrato,
	(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS local_contrato
FROM 
	contracts AS c
LEFT JOIN 
	people AS p ON c.client_id = p.id
WHERE 
	c.collection_day IN (1, 3, 8, 13, 25)
