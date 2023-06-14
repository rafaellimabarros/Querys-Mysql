SELECT DISTINCT
max(ai.protocol) AS protocolo,
p.name AS cliente,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS tecnico_encerramento,
a.conclusion_date AS data_encerramento,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_os,
p.neighborhood AS bairro,
p.city AS cidade

FROM assignment_incidents AS ai
INNER JOIN assignments AS a ON ai.assignment_id = a.id
INNER JOIN people AS p ON ai.client_id = p.id
INNER JOIN contracts AS c ON ai.client_id = c.client_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE	a.conclusion_date BETWEEN '2021-08-01' AND '2021-10-31'
AND ai.incident_type_id IN (15,21,1005,1006,1007,1008,1009,1010,1011,1012,1013,1015,1016,1017,1018,1019,1080,1081,1204,1205,1257,1271,1284,1285,1303,1304,1305,1306,1307,1308,1317,1318,1321,1327,1330,1331,1349,1350,1362) AND incident_status_id = 4 

GROUP BY ai.protocol
ORDER BY p.id

