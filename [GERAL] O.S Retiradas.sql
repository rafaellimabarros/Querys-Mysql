SELECT 
	p.id,
	p.name AS nome,
	os.protocol as protocolo,    
	(SELECT inct.title FROM incident_types AS inct WHERE os.incident_type_id = inct.id) AS tipo_os,
	prto.created AS abertura,
	prto.conclusion_date AS encerramento
FROM
	assignment_incidents AS os
INNER JOIN 
	assignments AS prto ON os.assignment_id = prto.id
INNER JOIN 
	people AS p ON os.client_id = p.id
INNER JOIN
	contracts AS c ON os.client_id = c.client_id
WHERE
	os.incident_type_id IN (1015, 1179, 1231, 1271, 1291) AND prto.conclusion_date IS NULL AND c.v_status = "normal"
GROUP BY
	os.protocol

