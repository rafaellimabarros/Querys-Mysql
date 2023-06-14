SELECT DISTINCT
p.name AS Cliente,
caa.activation_date AS data_ativacao,
p.cell_phone_1 AS celular,
p.phone AS telefone,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = conx.service_product_id) AS plano,
c.amount AS valor_plano,
COUNT(p.name) AS qtd_solicitacoes,
p.city AS Cidade,
p.neighborhood AS Bairro,
p.street AS Logradouro

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id
INNER JOIN authentication_contracts AS conx ON conx.contract_id = c.id
INNER JOIN contract_assignment_activations AS caa ON caa.contract_id = c.id
INNER JOIN assignment_incidents AS ai ON ai.client_id = p.id

WHERE p.city = 'guaiuba'
GROUP BY c.id