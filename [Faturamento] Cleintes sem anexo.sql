SELECT 
c.id AS cod_contrato,
p.name AS cliente,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS empresa,
c.v_status AS status_contrato

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.company_place_id = 9 AND p.id NOT IN (SELECT pu.people_id FROM people_uploads AS pu WHERE pu.deleted = 0 AND pu.documentation_type_id = 3)

GROUP BY p.id