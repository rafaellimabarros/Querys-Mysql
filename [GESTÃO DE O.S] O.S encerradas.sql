SELECT DISTINCT
	os.protocol AS protocolo,
	c.id AS id_contrato,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	(SELECT inct.title FROM incident_types AS inct WHERE os.incident_type_id = inct.id) AS tipo_os,
	(SELECT p.name FROM people AS p WHERE prto.responsible_id = p.id) AS tecnico,
	prto.conclusion_date AS encerramento
FROM
	assignment_incidents AS os
LEFT JOIN 
	assignments AS prto ON os.assignment_id = prto.id
LEFT JOIN 
	people AS p ON os.client_id = p.id
LEFT JOIN
	contracts AS c ON os.client_id = c.client_id
WHERE
	os.sector_area_id IN (6,7) AND prto.conclusion_date BETWEEN '2021-05-01' AND '2021-06-01' AND incident_status_id = 4 
GROUP BY
	os.protocol