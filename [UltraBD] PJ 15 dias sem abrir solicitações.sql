SELECT DISTINCT
c.id AS id_contrato,
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
(SELECT ct.title FROM contract_types AS ct WHERE ct.id = c.contract_type_id) AS tipo_contrato,
c.v_status AS status_contrato,
max(ai.protocol) AS protocolo_ultima_solicitaco,
(SELECT it.title FROM incident_types AS it WHERE it.id = (SELECT ai.incident_type_id from assignment_incidents AS ai WHERE ai.assignment_id = MAX(a.id))) AS tipo_ultima_solicitacao,
max(a.created) AS data_ultima_solicitacao,
max(a.conclusion_date) AS encerramento_ultima_solicitacao

FROM people AS p 
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN assignment_incidents AS ai ON ai.client_id = c.client_id
INNER JOIN assignments AS a ON a.id = ai.assignment_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE ai.incident_status_id != 8 and p.type_tx_id = 1 and a.assignment_type = "INCI" AND c.contract_type_id != 4 AND c.company_place_id != 3
GROUP BY p.id
HAVING max(a.created) < CURDATE() - INTERVAL 15 DAY
ORDER BY data_ultima_solicitacao desc