SELECT 
	(SELECT s.id FROM service_products AS s WHERE s.id = c.service_product_id) AS plano,
	(SELECT s.title FROM service_products AS s WHERE s.id = c.service_product_id) AS plano
FROM
	company_place_parameters_monthly_services AS c
WHERE
	c.company_place_id IN (1,9)
GROUP BY
	plano