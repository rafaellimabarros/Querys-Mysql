SELECT 
	p.id AS id_cliente,
	c.id AS id_contrato,
	p.name AS nome_cliente,
	p.email AS email1,
	p.email_NFE AS email2,
	p.phone AS telefone,
	p.cell_phone_1 AS celular1
FROM 
	people AS p
INNER JOIN 
	contracts AS c ON p.id = c.client_id
WHERE 
	p.company_place_id = 3 OR c.company_place_id = 3
GROUP BY
	p.id 