SELECT
	c.id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.name AS nome,
	p.email AS email,
	p.cell_phone_1 AS telefone1,
	p.phone AS telefone2,
	p.neighborhood AS bairro,
	p.city AS cidade,
	c.created AS data_cadastro,
	c.amount AS valor_contrato,
	pl.description AS plano,
	pl.deleted,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor_1,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_2_id) AS vendedor_2,
	(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa,
	(SELECT cont.title FROM crm_contact_origins AS cont WHERE cont.id = org.crm_contact_origin_id) AS origem_contato,
	c.v_status AS status_contrato,
	c.v_stage AS estagio_contrato
FROM
	contracts AS c
LEFT JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN
	contract_items AS pl ON c.id = pl.contract_id
LEFT JOIN 
	people_crm_informations AS org ON c.client_id = org.person_id
WHERE
	c.company_place_id != 3 AND org.crm_contact_origin_id IN (3, 10, 11, 12, 13) AND c.created BETWEEN '2021-05-01' AND '2021-08-16'
ORDER BY
	c.created
