SELECT
c.id AS cod_contrato,
p.name AS nome_cliente,
c.approval_date AS data_aprovacao,
(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.approval_date is NOT NULL AND c.approval_date BETWEEN '2022-04-01' AND '2022-04-30' AND c.company_place_id != 3

ORDER BY c.company_place_id