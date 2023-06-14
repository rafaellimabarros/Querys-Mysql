SELECT
	c.id AS id_contrato,
	con.user AS conexao, 
	p.name AS nome, 
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.street AS logradouro,
	p.address_complement AS complemento,
	p.neighborhood AS Bairro, 
	p.city AS Cidade,
	p.cell_phone_1 AS celular,
	p.phone AS telefone,
	p.email AS email,
	(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS empresa_contrato,
	date(p.created) AS data_cadastro, 
	c.amount AS Valor_contrato, 
	(SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS Plano,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor,
	(SELECT tc.title AS tipo_contrato from contract_types AS tc WHERE tc.id = c.contract_type_id) AS tipo_contrato,
	c.v_status AS Contrato_status,
	c.observation AS observacao_contrato
FROM
	authentication_contracts AS con
INNER JOIN
	contracts AS c ON con.contract_id = c.id
INNER JOIN
	people AS p ON c.client_id = p.id
WHERE 
	c.contract_type_id = 4
GROUP BY 
	con.id
