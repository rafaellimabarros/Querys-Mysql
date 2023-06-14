SELECT
p.name AS Cliente,
p.city AS Cidade,
p.neighborhood AS Bairro,
p.street AS Logradouro,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = conx.service_product_id) AS plano,
c.amount AS valor_contrato,
c.v_status AS status_contrato

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id
INNER JOIN authentication_contracts AS conx ON conx.contract_id = c.id

WHERE p.city = 'guaiuba' AND c.v_status != 'cortesia' AND c.company_place_id != 3