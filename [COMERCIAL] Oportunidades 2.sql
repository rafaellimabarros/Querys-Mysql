SELECT
	crm.person_id AS id_cliente,
	c.id AS id_contrato,
	(SELECT p.name AS nome FROM people AS p WHERE p.id = crm.person_id) AS nome_cliente,
	crm.entry_date AS data_venda,
	act.activation_date AS data_ativacao,
	c.v_status AS status_contrato,
	(SELECT p.name AS nome FROM people AS p WHERE p.id = crm.proprietary_id) AS vendedor,
	cev.date AS data_cancelamento,
	(SELECT cevt.title FROM contract_event_types AS cevt WHERE cevt.id = cev.contract_event_type_id) AS motivo_cancelamento,
	cev.description AS descricao
FROM crm_person_oportunities AS crm
LEFT JOIN contracts AS c ON crm.person_id = c.client_id
LEFT JOIN contract_assignment_activations AS act ON c.id = act.contract_id
INNER JOIN contract_events AS cev ON c.id = cev.contract_id
WHERE crm.entry_date BETWEEN '2021-06-01' AND '2021-06-30' 
AND crm.current_stage = 9
AND c.v_status = "Cancelado"
AND c.id IN (SELECT MAX(c.id) FROM contracts AS c WHERE crm.person_id = c.client_id)
AND cev.id IN (SELECT MAX(cev.id) FROM contract_events AS cev WHERE c.id = cev.contract_id)
GROUP BY c.id