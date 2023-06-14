SELECT DISTINCT
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
	(SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS Plano, 
	c.v_status AS Contrato_status,
	c.cancellation_date AS data_cancelamento,
	(SELECT cevt.title FROM contract_event_types AS cevt WHERE cevt.id = cev.contract_event_type_id) AS classificacao,
	cev.description AS descricao_cancelamento
	/*c.cancellation_motive AS motivo*/
FROM 
	contracts AS c
INNER JOIN 
	contract_events AS cev ON c.id = cev.contract_id
INNER JOIN 
	contract_event_types AS cevt ON cev.contract_event_type_id = cevt.id
LEFT JOIN 
	contract_items AS con ON c.id = con.contract_id
LEFT JOIN 
	people AS p ON c.client_id = p.id
WHERE 
	c.v_status = "Cancelado" AND c.cancellation_date BETWEEN '2021-01-27' AND '2021-10-23' AND cevt.objective = 2
GROUP BY
	c.id
ORDER BY
	c.approval_date DESC
