SELECT cev.contract_id AS id_contrato, p.name AS nome, p.neighborhood AS bairro, p.city AS cidade, c.amount AS valor, (SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS plano, c.beginning_date AS data_cadastro, (SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor_1, (SELECT p.name FROM people AS p WHERE p.id = c.seller_2_id) AS vendedor_2, c.v_status, c.cancellation_date AS data_cancelamento, (SELECT cevt.title FROM contract_event_types AS cevt WHERE cevt.id = cev.contract_event_type_id) AS motivo_cancelamento, cev.description
FROM contract_events AS cev
INNER JOIN contracts AS c ON cev.contract_id = c.id
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN contract_event_types AS cevt ON cev.contract_event_type_id = cevt.id
LEFT JOIN contract_items AS con ON c.id = con.contract_id
WHERE c.seller_1_id IS NOT NULL AND (c.cancellation_date LIKE '2021-10-20%' OR c.cancellation_date LIKE '2021-10-21%' OR c.cancellation_date LIKE '2021-10-22%') AND c.`status` != 1 AND cevt.id IN (185, 157, 187, 186, 189, 191)
GROUP BY id_contrato
