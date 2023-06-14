SELECT 
	serv.title AS servico,
	serv.service_type,
	cnae.activity_code AS cnae, 
	cnae.company_place_id AS locall
FROM 
	service_products AS serv
LEFT JOIN
	service_products_company_places AS cnae ON serv.id = cnae.service_product_id
WHERE
	serv.service_type = 1
	AND serv.active = 1
	