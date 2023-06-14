SELECT DISTINCT
c.id AS Cod_contrato,
p.name AS Cliente,
p.city AS Cidade,
p.neighborhood AS Bairro,
p.cell_phone_1 AS Celular,
p.phone AS Telefone,
p.email AS Email,
c.v_status AS Status_Contrato,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = conx.service_product_id) AS Plano,
c.amount AS Valor_Plano

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS conx ON conx.contract_id = c.id
LEFT JOIN assignments AS a ON a.requestor_id = p.id

WHERE a.requestor_id IS NULL AND c.v_status != "cancelado"
