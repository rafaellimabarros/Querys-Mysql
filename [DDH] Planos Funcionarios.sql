SELECT DISTINCT 
p.name AS Nome,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = conx.service_product_id) AS plano,
c.amount AS Valor,
(SELECT ct.title FROM contract_types AS ct WHERE ct.id = c.contract_type_id) AS Tipo_Contrato

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id
INNER JOIN authentication_contracts AS conx ON conx.contract_id = c.id

WHERE p.collaborator = 1