SELECT 
	p.name AS nome,
	c.user,
	p.tx_id,
	cont.v_status,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = c.service_product_id) AS plano,
	c.street AS rua,
	c.street_number AS numero,
	c.neighborhood AS bairro,
	c.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.phone AS telefone
FROM authentication_contracts AS c
INNER JOIN contracts AS cont ON c.contract_id = cont.id
INNER JOIN people AS p ON cont.client_id = p.id
WHERE c.neighborhood = "camará"