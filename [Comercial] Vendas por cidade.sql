SELECT
c.id AS numero_contrato,
p.name AS cliente,
c.v_status AS situacao,
p.city AS cidade,
p.neighborhood AS bairro,
p.code_city_id AS cod_IBG,
p.postal_code AS CEP,
c.created AS data_cadastro

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id

WHERE date(c.created) BETWEEN '2022-04-01' AND '2022-04-30'