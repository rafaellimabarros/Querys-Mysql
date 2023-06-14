SELECT c.contract_number AS id_contrato, p.name AS nome, p.neighborhood AS bairro, p.city AS cidade, c.approval_date AS data_ativacao, c.amount AS valor_mensalidade, c.final_date AS data_finalizacao_contrato, c.observation AS obs_contrato, c.cancellation_date AS Cancelamento, c.v_status AS status_contrato, (SELECT cvt.title FROM contract_event_types AS cvt WHERE cvt.id = cev.contract_event_type_id) AS motivo_cancelamento, cev.description
FROM contract_events AS cev
left JOIN contracts AS c ON cev.contract_id = c.id
left JOIN people AS p ON c.client_id = p.id
WHERE c.v_status != "Normal" AND c.cancellation_date BETWEEN '2021-03-01' AND '2021-03-31' AND cev.contract_event_type_id = 110
GROUP BY c.contract_number
ORDER BY c.approval_date DESC