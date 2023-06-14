SELECT 
	p.id AS id_cliente,
	p.name AS nome_cliente,
	p.phone AS fone1,
	p.cell_phone_1 AS fone2
FROM
	people AS p
INNER JOIN 
	contracts AS c ON p.id = c.client_id
WHERE 
	p.city = "Chorozinho"
	AND c.v_status != "Cancelado"