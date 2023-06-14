SELECT
	c.id AS id_contrato, 
	p.name AS nome,
	c.v_status AS contrato_status,
	DATE(max(cev.date)) AS data_bloqueio,
	os.protocol AS protocolo,
	(SELECT inct.title FROM incident_types AS inct WHERE os.incident_type_id = inct.id) AS tipo_os,
	datediff(CURDATE(),DATE(max(cev.date))) AS dias_bloqueado,
	DATE(prto.created) AS abertura,
	DATE(prto.conclusion_date) AS encerramento
FROM
	contracts AS c 
INNER JOIN 
	people AS p ON c.client_id = p.id
INNER JOIN
	contract_events AS cev ON c.id = cev.contract_id
INNER JOIN 
	assignment_incidents AS os ON c.client_id = os.client_id
INNER JOIN
	assignments AS prto ON os.assignment_id = prto.id
WHERE 
 	cev.contract_event_type_id = 40 
	AND c.v_status = "Bloqueio Financeiro"
	AND os.incident_type_id IN (1015, 1179, 1231, 1271, 1291) 
GROUP BY
	c.id
HAVING datediff(CURDATE(),DATE(max(cev.date))) >= 30
LIMIT 2000
