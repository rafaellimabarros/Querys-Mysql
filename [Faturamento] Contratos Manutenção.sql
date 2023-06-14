SELECT
cm.contract_id AS cod_contrato,
p.name AS nome_cliente,
(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa,
c.beginning_date AS data_inicio

FROM v_contracts_maintenance AS cm
INNER JOIN contracts AS c ON c.id = cm.contract_id
INNER JOIN people AS p ON p.id = c.client_id

WHERE c.beginning_date <= '2022-05-31' AND c.company_place_id != 3

ORDER BY c.company_place_id ASC, c.beginning_date desc