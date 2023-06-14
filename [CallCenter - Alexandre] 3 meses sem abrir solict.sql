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
c.v_status AS status_contrato,
max(ai.protocol) AS protocolo_ultima_solicitaco,
max(a.created) AS data_ultima_solicitacao,
max(a.conclusion_date) AS encerramento_ultima_solicitacao

FROM people AS p 
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN assignment_incidents AS ai ON ai.client_id = c.client_id
INNER JOIN assignments AS a ON a.id = ai.assignment_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE a.assignment_type = "INCI"
GROUP BY p.id
HAVING max(a.created) < '2022-01-31'
