SELECT
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
ai.protocol AS Protocolo,
(SELECT it.code FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS cod_solicitacao,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
a.description AS Descricao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.created AS Data_Abertura,
a.modified AS Data_Encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_Abertura,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento,
IF(apr.`type` = 5, "Sim", "nao") AS Reabertura,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = apr.created_by) AS Atendente_Reabertura,
apr.created AS data_reabertura,
(SELECT r.description FROM reports AS r WHERE r.id = apr.report_id) AS Descricao_reabertura

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN assignment_person_routings AS apr ON apr.assignment_id = a.id
INNER JOIN v_users AS vu ON vu.id = a.created_by

WHERE date(a.created) BETWEEN '2022-04-01' AND '2022-05-06'AND vu.team_id = 1003 AND apr.`type` = 5