SELECT DISTINCT
c.id AS id_contrato,
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
c.v_status AS status_contrato,
max(ai.protocol) AS protocolo,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_os,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.created AS abertura,
a.conclusion_date AS encerramento

FROM assignment_incidents AS ai
INNER JOIN assignments AS a ON ai.assignment_id = a.id
INNER JOIN people AS p ON ai.client_id = p.id
LEFT JOIN contracts AS c ON ai.client_id = c.client_id
LEFT JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE	a.conclusion_date BETWEEN '2022-01-10' AND '2022-01-17'
AND ai.sector_area_id = 6 AND ai.incident_type_id NOT IN (1010, 1011, 1012, 1331, 1349, 1350, 21, 1005, 1006) AND incident_status_id = 4 

GROUP BY ai.protocol
ORDER BY tipo_os