SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.phone AS telefone,
	p.email AS email,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	c.amount AS valor_plano,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
	c.v_status AS status_contrato,
	cev.description,
	c.observation
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
INNER JOIN 
	contract_events AS cev ON c.id = cev.contract_id
INNER JOIN 
	contract_event_types AS cevt ON cev.contract_event_type_id = cevt.id
LEFT JOIN
	authentication_contracts AS con ON c.id = con.contract_id
WHERE 
	c.v_status = "Suspenso" AND c.company_place_id != 3 AND p.collaborator = 0 AND cevt.objective = 5
GROUP BY
	c.id
