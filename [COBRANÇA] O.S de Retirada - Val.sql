SELECT DISTINCT
	os.protocol AS protocolo,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	(SELECT inct.title FROM incident_types AS inct WHERE os.incident_type_id = inct.id) AS tipo_os,
	prto.created AS abertura,
	prto.conclusion_date AS encerramento,
	(SELECT st.title FROM incident_status AS st WHERE os.incident_status_id = st.id) status_os,
	c.id AS id_contrato,
	c.cancellation_date,
	c.v_status AS status_contrato
FROM
	assignment_incidents AS os
INNER JOIN 
	assignments AS prto ON os.assignment_id = prto.id
INNER JOIN 
	people AS p ON os.client_id = p.id
LEFT JOIN
	contracts AS c ON os.client_id = c.client_id
WHERE
	prto.created BETWEEN '2021-09-01' AND '2021-11-31' AND os.incident_type_id IN (1271, 1291, 1015)
GROUP BY
	os.protocol