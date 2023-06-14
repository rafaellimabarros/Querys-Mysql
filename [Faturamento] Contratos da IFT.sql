SELECT
cm.contract_id AS cod_contrato,
p.name AS nome_cliente,
(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa,
(SELECT sp.title FROM service_products AS sp where sp.id = ac.service_product_id) AS plano

FROM v_contracts_maintenance AS cm
INNER JOIN contracts AS c ON c.id = cm.contract_id
INNER JOIN people AS p ON p.id = c.client_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.company_place_id = 9 AND p.type_tx_id = 1

