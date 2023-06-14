SELECT 
	cev.contract_id AS id_contrato, 
	p.name AS nome, 
	p.neighborhood AS bairro, 
	p.city AS cidade, 
	c.amount AS valor, 
	(SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS plano, 
	c.v_status AS status_contrato, 
	c.date AS data_evento, 
	(SELECT cevt.title FROM contract_event_types AS cevt WHERE cevt.id = cev.contract_event_type_id) AS evento, 
	cev.description AS descricao
FROM contract_events AS cev
INNER JOIN contracts AS c ON cev.contract_id = c.id
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN contract_event_types AS cevt ON cev.contract_event_type_id = cevt.id
LEFT JOIN contract_items AS con ON c.id = con.contract_id
WHERE cev.date BETWEEN '2021-04-01' AND '2021-04-30' AND cevt.id = 13 AND cev.description LIKE "%Mensal%"
GROUP BY id_contrato
