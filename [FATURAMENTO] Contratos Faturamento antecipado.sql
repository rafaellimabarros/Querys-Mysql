SELECT 
	p.id AS id_cliente,
	p.name AS nome_cliente,
	p.tx_id AS cpf_cnpj,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.street AS endereco,
	p.number AS numer_endereco,
	p.neighborhood AS bairro,
	p.city AS cidade,
	c.collection_day AS vencimento,
	c.v_status AS status_contrato,
	c.v_invoice_type AS tipo_faturamento,
	c.beginning_date AS vigencia_inicio,
	c.final_date AS vigencia_final,
	c.amount AS valor_contrato,
	pl.description AS plano
FROM 
	contracts AS c
INNER JOIN 
	people AS p ON c.client_id = p.id
LEFT JOIN 
	contract_items AS pl ON c.id = pl.contract_id
WHERE 
	c.invoice_type = 4;
LIMIT 100