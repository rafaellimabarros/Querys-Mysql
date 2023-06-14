SELECT 
	p.id AS id_cliente, 
	p.name AS nome, 
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.tx_id AS cpf_cnpj,
	p.street AS logradouro,
	p.address_complement AS complemento,
	p.neighborhood AS Bairro, 
	p.city AS Cidade,
	p.cell_phone_1 AS celular,
	p.phone AS telefone,
	p.email AS email,
	(SELECT emp.description FROM companies_places as emp WHERE p.company_place_id = emp.id) AS empresa_cadastro,
	(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS empresa_contrato,
	c.approval_date AS data_ativacao, 
	c.amount AS Valor_contrato, 
	c.collection_day AS vencimento,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = con.service_product_id) AS plano, 
	c.v_status AS Contrato_status
FROM 
	authentication_contracts AS con
LEFT JOIN 
	contracts AS c ON c.id = con.contract_id
LEFT JOIN 
	people AS p ON c.client_id = p.id
WHERE 
	c.v_status != "Cancelado" AND c.cancellation_date <= '2021-12-31'
ORDER BY
	c.approval_date DESC 
