SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.street AS Logradouro,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular1,
	p.phone AS telefone,
	p.email AS email,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano,
	c.amount AS valor_plano,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
	c.v_status AS status_contrato,
	c.beginning_date AS data_cadastro,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor_1,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_2_id) AS vendedor_2,
	(SELECT cont.title FROM crm_contact_origins AS cont WHERE cont.id = org.crm_contact_origin_id) AS origem_contato
FROM
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN
	authentication_contracts AS con ON c.id = con.contract_id
LEFT JOIN
	people_crm_informations AS org ON p.id = org.person_id
WHERE 
	(c.v_status = "Normal" OR c.v_status = "Bloqueio financeiro")
	AND p.collaborator = 0
	AND type_tx_id = 1
	AND c.company_place_id != 3
ORDER BY
	c.observation DESC