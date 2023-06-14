SELECT 
	lg.protocol, 
	p.name, 
	(select inct.title from incident_types as inct where inc.incident_type_id = inct.id) AS tipo_os,
	(SELECT st.title from incident_status as st WHERE st.id = inc.incident_status_id) AS status_os,
	/*rp.description AS descricao_relato, */
	prto.created AS abertura,
	rp.created AS horario_manutencao, 
	/*max(ag.start_date) AS data_reagedada,*/
	prto.final_date AS novo_prazo,
	DATEDIFF(DATE(prto.final_date), DATE(prto.created)) AS diff,
	(SELECT u.name FROM v_users AS u WHERE rp.created_by = u.id) AS operador
FROM 
	log_assignment_incidents AS lg
INNER JOIN 
	people AS p ON lg.client_id = p.id
INNER JOIN 
	reports AS rp ON lg.assignment_id = rp.assignment_id
INNER JOIN 
	assignments AS prto ON lg.assignment_id = prto.id
INNER JOIN 
	assignment_incidents AS inc ON lg.protocol = inc.protocol
/*LEFT JOIN 
	schedules AS ag ON lg.assignment_id = ag.assignment_id*/
WHERE 
	DATE(rp.created) BETWEEN '2022-03-14' AND '2022-03-21'
	AND rp.title LIKE "Manutençao%"
	/*lg.incident_status_id = 10 
	AND rp.description LIKE "%Remarca├º├úo</b>"*/
GROUP BY
	lg.protocol
