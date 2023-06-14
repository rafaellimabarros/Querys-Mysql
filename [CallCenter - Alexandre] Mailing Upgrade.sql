SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	p.tx_id AS CPF,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.phone AS telefone,
	p.email AS email,
	con.service_product_id,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	c.amount AS valor_plano,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
	c.v_status AS status_contrato,
	c.observation
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
INNER JOIN
	authentication_contracts AS con ON c.id = con.contract_id
WHERE 
	c.v_status = "Normal"
	AND p.collaborator = 0
	AND p.type_tx_id = 2
	AND (con.service_product_id IN (67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 126, 128, 131, 132, 134, 140, 141, 142, 143, 144, 145, 146, 147, 148, 150, 153, 154, 156, 164, 169, 177, 178, 179, 180, 181, 182, 183, 184, 186, 188, 189, 192, 193, 194, 197, 198, 201, 202, 203, 204, 205, 210, 213, 214, 2134, 2135, 2137, 2138, 2208, 2210, 2212, 2214, 2215, 2216, 2217, 2218)
	OR c.observation LIKE "2019%"
	OR c.observation LIKE "2020-01%"
	OR c.observation LIKE "2020-02%"
	OR c.observation LIKE "2020-03%"
	OR c.observation LIKE "2020-04%"
	OR c.observation LIKE "2020-05%"
	OR c.observation LIKE "2020-06%"
	OR c.observation LIKE "2020-07%"
	OR c.observation LIKE "2020-08%"
	OR c.observation LIKE "2020-09%"
	OR c.observation LIKE "2020-10%"
	OR c.observation LIKE "2020-11%"
	OR c.observation LIKE "2020-12%"
	OR c.observation LIKE "2021-01%"
	OR c.observation LIKE "2021-02%"
	OR c.observation LIKE "2021-03%"
	OR c.observation LIKE "2021-04%"
	OR c.observation LIKE "2021-05%"
	OR c.observation LIKE "2021-06%"
	OR c.observation LIKE "2021-07%"
	OR c.observation LIKE "2021-08%")
ORDER BY
	c.observation DESC
