SELECT 
	p.id AS id_pessoa, 
	n.contract_id AS id_contrato,
	n.client_name AS nome_cliente, 
	p.tx_id AS cpf_cnpj,  
	p.code_city_id AS codigo_IBGE, 
	n.billing_competence AS competencia,
	n.movement_date AS emissao, 
	n.total_amount_liquid AS valor, 
	(SELECT title FROM financers_natures AS f WHERE n.financer_nature_id = f.id) AS natureza_financeira, 
	COALESCE((SELECT s.title FROM service_products AS s WHERE s.id = c.service_product_id),(SELECT s.title FROM service_products AS s WHERE s.id = ci.service_product_id)) AS plano,
	(SELECT con.amount FROM contracts AS con WHERE n.contract_id = con.id) AS valor_plano,
	n.company_place_name AS local
	
FROM 
	invoice_notes AS n
LEFT JOIN 
	authentication_contracts AS c ON n.contract_id = c.contract_id
LEFT JOIN 
	service_products AS s ON c.service_product_id = s.id
INNER JOIN 
	people AS p ON n.client_id = p.id
LEFT JOIN
	contract_items AS ci ON n.contract_id = ci.contract_id
	
WHERE 
	n.movement_date BETWEEN '2021-08-01' AND '2021-08-31' 
	AND n.status = 1 
	AND n.invoice_serie_id IN (104, 108, 113)
	
GROUP BY
	n.id