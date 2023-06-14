SELECT
c.id AS num_contrato,
p.name AS cliente,
c.amount AS valor_contrato,
(SELECT tx.name FROM tx_types AS tx WHERE tx.id = p.type_tx_id) AS Tipo,
(SELECT fo.title FROM financial_operations AS fo WHERE fo.id = c.operation_id) AS operacao,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS local_contrato,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano

FROM contracts AS c
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN people AS p ON p.id = c.client_id

WHERE c.operation_id IN (26,27)

GROUP BY c.id