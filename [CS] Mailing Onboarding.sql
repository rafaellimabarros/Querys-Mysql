SELECT DISTINCT
c.id AS cod_contrato,
p.name AS cliente,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
caa.activation_date AS data_ativacao,
a.modified,
a.final_date,
c.v_status AS status_contrato

FROM people AS p 
LEFT JOIN contracts AS c ON c.client_id = p.id
LEFT JOIN contract_assignment_activations AS caa ON caa.contract_id = c.id
INNER JOIN assignment_incidents AS ai ON ai.client_id = p.id
INNER JOIN assignments AS a ON a.id = ai.assignment_id

WHERE caa.activation_date BETWEEN '2021-09-01' AND NOW() AND c.company_place_id != 3 AND c.v_status != 'cancelado'
GROUP BY c.id
ORDER BY caa.activation_date DESC