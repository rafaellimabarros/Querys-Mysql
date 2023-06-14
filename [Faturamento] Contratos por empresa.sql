SELECT 
c.id AS cod_contrato,
p.name AS nome_cliente,
(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa

FROM contracts AS c
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN people AS p ON p.id = c.client_id

WHERE c.company_place_id != 3

GROUP BY c.id
ORDER BY c.company_place_id