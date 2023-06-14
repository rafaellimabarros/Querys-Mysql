SELECT 
	t.id,
	t.title AS titulo_tarefa,
	t.description AS descricao_tarefa,
	rp.description AS relato,
	(SELECT p.name FROM people AS p WHERE t.responsible_id = p.id) AS atedente,
	t.created AS dt_abertura,
	t.conclusion_date AS dt_conclusão
FROM assignments AS t
LEFT JOIN reports AS rp ON t.id = rp.assignment_id
WHERE t.assignment_type = "TASK"
AND t.responsible_id IN (35, 48, 49, 60, 113, 120, 137, 177, 178, 193)
AND t.conclusion_date > "2021-04-01" 