SELECT DISTINCT 
c.id AS id_contrato,
p.name AS nome,
p.tx_id AS CNPJ,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS endereço,
p.cell_phone_1 AS celular1,
p.phone AS telefone,
p.email AS email,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_plano,
(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
c.v_status AS status_contrato,
c.observation AS fidelidade,
c.v_status AS status_contrato

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id 
INNER JOIN authentication_contracts AS ac ON c.id = ac.contract_id

WHERE p.type_tx_id = 1
GROUP BY p.id