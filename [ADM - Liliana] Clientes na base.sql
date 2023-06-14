SELECT DISTINCT ON (c.id)
c.id AS cod_contrato,
p.name AS cliente,
p.email,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.city AS cidade,
p.neighborhood AS bairro,
caa.activation_date AS data_ativacao,
c.v_status AS status_contrato

FROM people AS p 
INNER JOIN contracts AS c ON c.client_id = p.id
LEFT JOIN contract_assignment_activations AS caa ON caa.contract_id = c.id

WHERE c.company_place_id != 3

