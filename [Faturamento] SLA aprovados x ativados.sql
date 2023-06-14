SELECT
caa.contract_id AS id_contrato,
p.name AS cliente,
max(ai.protocol) OVER (PARTITION BY c.id) AS protocolo,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_solicitacao,
caa.activation_date AS data_instalacao,
c.approval_date AS data_aprovacao,
DATEDIFF (c.approval_date, caa.activation_date) AS dias,
IF( DATEDIFF (c.approval_date, date(caa.activation_date )) >= 3 , "Atrasado", "No prazo" ) AS status_SLA

FROM contracts AS c
INNER JOIN contract_assignment_activations AS caa ON caa.contract_id = c.id
INNER JOIN people AS p ON p.id = c.client_id
INNER JOIN assignment_incidents AS ai ON ai.client_id = p.id
INNER JOIN assignments AS a ON a.id = ai.assignment_id

WHERE c.approval_date BETWEEN '2022-04-01' AND '2022-04-30' 
AND ai.incident_status_id = 4 AND ai.incident_type_id IN (1005,1006)

GROUP BY c.id
ORDER BY c.approval_date ASC