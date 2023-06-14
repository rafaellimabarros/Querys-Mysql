SELECT
p.name AS nome,
p.tx_id AS CPF_CNPJ,
c.beginning_date AS data_instalacao,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = au.service_product_id) AS plano,
c.amount AS valor_contrato,
c.v_status AS status_contrato

FROM people AS p 
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS au ON au.contract_id = c.id

WHERE c.v_status NOT IN ("cancelado") AND c.company_place_id = 2
ORDER BY c.v_status DESC