SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	p.birth_date AS data_nascimento,
	YEAR(CURDATE()) - YEAR(p.birth_date) AS idade,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS tipo_cliente,
	p.email AS email,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone,
	p.cell_phone_1 AS celular,
	p.street AS endereco,
	p.`number` AS numero_endereco,
	p.neighborhood AS bairro,
	p.city AS cidade,
	c.date AS data_ativacao,
	(SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS plano,
	(SELECT s.selling_price FROM service_products AS s WHERE s.id = con.service_product_id) AS valor_plano,		
	c.v_status AS status_contrato,
	c.cancellation_date AS data_cancelamento,
	fat.title AS fatura,
	fat.expiration_date AS vencimento,
	fat.balance AS valor_fatura,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS data_ultimo_pagamento
FROM 
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
LEFT JOIN
	contract_items AS con ON (c.id = con.contract_id)
WHERE
	fat.p_is_receivable -- em aberto,
	AND fat.expiration_date < '2021-09-20'
	AND fat.title LIKE "FAT%"
	AND (c.contract_type_id NOT IN (4, 6 ,7) OR c.id IS NULL)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id NOT IN (127, 140, 128, 199)
	AND fat.financial_collection_type_id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 28, 29)
GROUP BY
	fat.id
ORDER BY
	p.name ASC