SELECT
c.id AS cod_contrato,
p.name AS cliente,
(SELECT txt.name FROM tx_types AS txt WHERE txt.id = p.type_tx_id) AS tipo,
c.v_status AS status_contrato,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS empresa,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor,
(SELECT fo.title FROM financial_operations AS fo WHERE fo.id = ccb.financial_operation_id) AS operacao_agrupador

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN contract_configuration_billings AS ccb ON ccb.contract_id = c.id

WHERE c.company_place_id = 1 AND c.v_status = 'normal' AND p.type_tx_id = 2 
AND ccb.id IN  
	(SELECT MAX(ccb.id) FROM contract_configuration_billings AS ccb WHERE ccb.contract_id = c.id)
AND ccb.financial_operation_id = 25
AND ccb.contract_id NOT IN (SELECT ccb.contract_id FROM contract_configuration_billings AS ccb WHERE ccb.financial_operation_id = 1 OR ccb.financial_operation_id = 1)
AND c.contract_type_id = 1
AND c.amount >= '99,90'

GROUP BY c.id
ORDER BY p.tx_id
LIMIT 3000