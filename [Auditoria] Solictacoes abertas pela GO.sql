SELECT
ai.protocol AS Protocolo,
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
(SELECT it.code FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS cod_solicitacao,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.description AS Descricao,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_Abertura,
a.created AS Data_Abertura,
a.modified AS Data_Encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN contracts AS c ON c.client_id = a.requestor_id
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN  authentication_contracts AS ac ON c.id = ac.contract_id
INNER JOIN v_users AS vu ON vu.id = a.created_by

WHERE date(a.created) BETWEEN '2022-04-01' AND '2022-05-06' AND vu.team_id = 1003

GROUP BY ai.protocol