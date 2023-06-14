SELECT 
ai.protocol AS Protocolo,
(SELECT p.name FROM people AS p WHERE p.id = ai.client_id) AS Cliente,
apr.created AS Data_agendamento,
(SELECT p.name FROM people AS p WHERE p.id = apr.origin_person_id) AS Pessoa_Origem,
(SELECT p.name FROM people AS p WHERE p.id = apr.destination_person_id) AS Pessoa_Destino,
(SELECT it.title FROM incident_types AS it WHERE it.id = apr.origin_incident_type_id) AS Incidente_Origem,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
(SELECT tea.title FROM teams AS tea WHERE tea.id = apr.origin_team_id) AS Equipe_Origem,
(SELECT tea.title FROM teams AS tea WHERE tea.id = apr.destination_team_id) AS Equipe_Destino

FROM assignment_person_routings AS apr
INNER JOIN assignments AS a ON a.id = apr.assignment_id
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id

WHERE apr.created BETWEEN  "2021-10-01" AND "2021-10-26" AND a.assignment_type = 'INCI' AND apr.destination_team_id IN (1003,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1043)
ORDER BY ai.protocol, apr.created ASC

