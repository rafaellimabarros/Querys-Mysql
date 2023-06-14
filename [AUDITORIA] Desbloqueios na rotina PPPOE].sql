SELECT cev.contract_id AS id_contrato, p.name AS nome, p.neighborhood AS bairro, p.city AS cidade, c.amount AS valor, (SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS plano, c.beginning_date AS data_cadastro, us.name, c.status, c.cancellation_date AS data_cancelamento, (SELECT cevt.title FROM contract_event_types AS cevt WHERE cevt.id = cev.contract_event_type_id) AS motivo_cancelamento, cev.description
FROM contract_events AS cev
INNER JOIN contracts AS c ON cev.contract_id = c.id
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN contract_event_types AS cevt ON cev.contract_event_type_id = cevt.id
LEFT JOIN contract_items AS con ON c.id = con.contract_id
LEFT JOIN v_users AS us ON cev.created_by = us.id
WHERE cevt.id = 41 AND cev.description LIKE "%PPPOE%" AND cev.date > '2021-11-20' 
GROUP BY id_contrato