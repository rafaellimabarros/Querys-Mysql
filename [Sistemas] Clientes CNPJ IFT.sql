SELECT
cm.contract_id AS cod_contrato,
p.name AS nome_cliente,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato

FROM v_contracts_maintenance AS cm
INNER JOIN contracts AS c ON c.id = cm.contract_id
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN authentication_contracts AS ac ON ac.contract_id = cm.contract_id

WHERE c.company_place_id = 9 AND p.type_tx_id = 1

GROUP BY cm.contract_id