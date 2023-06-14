SELECT c.id AS id_contrato, p.name AS nome, p.neighborhood AS Bairro, p.city AS Cidade, c.beginning_date AS data_ativacao, c.observation, c.amount AS Valor_contrato, (SELECT s.description FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, c.v_status AS Contrato_status, c.cancellation_date AS data_cancelamento, c.cancellation_motive
FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN contract_items AS con ON c.id = con.contract_id
WHERE c.status = 4 AND c.cancellation_date BETWEEN '2021-03-01' AND '2021-03-31'  