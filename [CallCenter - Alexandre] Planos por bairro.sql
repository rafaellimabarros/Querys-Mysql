SELECT 
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS plano,
c.amount AS valor_plano,
caa.activation_date AS data_ativacao,
c.beginning_date AS data_cadastro,
nf.total_amount_liquid AS valor_ativacao

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
LEFT JOIN contract_assignment_activations AS caa ON caa.contract_id = c.id
LEFT join invoice_notes AS nf ON nf.id = caa.invoice_note_id