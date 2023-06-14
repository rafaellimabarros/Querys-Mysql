SELECT lg.protocol, p.name, (select inct.title from incident_types as inct where lg.incident_type_id = inct.id) AS tipo_os, rp.description, prto.created AS abertura,rp.created AS remarcacao, max(ag.start_date) AS data_reagedada, prto.conclusion_date AS encerramento
FROM log_assignment_incidents AS lg
INNER JOIN people AS p ON lg.client_id = p.id
INNER JOIN reports AS rp ON lg.assignment_id = rp.assignment_id
INNER JOIN assignments AS prto ON lg.assignment_id = prto.id
LEFT JOIN schedules AS ag ON lg.assignment_id = ag.assignment_id
WHERE lg.incident_status_id = 10 AND rp.description LIKE "%Remarcação</b>"
GROUP BY rp.created
