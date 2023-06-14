SELECT DISTINCT
c.id AS contrato,
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
c.v_status AS Status_Contrato,
ai.protocol AS Protocolo,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.created AS Data_Abertura,
a.final_date AS Data_Prazo,
a.modified AS Data_Encerramento,
IF( a.modified > a.final_date, "Sim", "Nao" ) AS Em_Atraso,
(SELECT t.title FROM teams AS t WHERE ai.origin_team_id = t.id) AS Equipe_Origem,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_Origem,
(SELECT t.title FROM teams AS t WHERE ai.team_id = t.id) AS Equipe_Encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento,
a.description AS descricao

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN contracts AS c ON c.client_id = a.requestor_id
INNER JOIN reports AS r ON r.assignment_id = a.id

WHERE c.id = 61818 AND a.assignment_type = "INCI" AND c.v_status = 'cancelado' AND c.cancellation_date > CURDATE() - INTERVAL 30 DAY AND ai.incident_status_id != 8 AND ai.beginning_service_date > CURDATE() - INTERVAL 30 DAY
ORDER BY a.created desc
