SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.phone AS telefone,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	(SELECT pl.selling_price FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
	(SELECT ap.title FROM authentication_access_points AS ap WHERE con.authentication_access_point_id = ap.id) AS ponto_de_acesso
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN
	authentication_contracts AS con ON c.id = con.contract_id
WHERE 
	con.authentication_access_point_id = 7