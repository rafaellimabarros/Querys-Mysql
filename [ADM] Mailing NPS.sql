SELECT
c.id AS id_contrato,
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
c.v_status AS status_contrato,
max(ai.protocol) AS protocolo,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_solicitacao,
a.created AS abertura,
a.conclusion_date AS encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_abertura,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento

FROM assignment_incidents AS ai
INNER JOIN assignments AS a ON a.id = ai.assignment_id
INNER JOIN people AS p ON p.id = ai.client_id
INNER JOIN contracts AS c ON c.client_id = ai.client_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
LEFT JOIN v_users AS vu ON a.modified_by = vu.id

WHERE a.conclusion_date >= CURDATE() - INTERVAL 1 DAY AND ai.incident_status_id = 4 AND vu.profile_id IN (30,37,47,48,81)
AND p.city IN ('eusebio','maracanau','pacatuba')
GROUP BY ai.client_id
