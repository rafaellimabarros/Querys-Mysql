SELECT
c.id AS cod_contrato,
p.name AS nome_cliente,
c.approval_date AS data_aprovacao,
(SELECT emp.description FROM companies_places AS emp WHERE emp.id = c.company_place_id) AS empresa,
sum(if(ai.incident_type_id = 1006,1,0)) as soma_1006,
sum(if(ai.incident_type_id = 1005,1,0)) as soma_1005,
sum(if(ai.incident_type_id = 21,1,0)) as soma_21

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id
INNER JOIN assignments AS a ON a.requestor_id = p.id
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id

WHERE c.approval_date is NOT NULL AND c.approval_date BETWEEN '2022-04-01' AND '2022-04-30' 
AND c.company_place_id != 3

GROUP BY c.id
HAVING soma_1006 < 1 AND soma_1005 < 1 AND soma_21 < 1
ORDER BY c.company_place_id