SELECT
(SELECT p.name FROM people AS p WHERE p.id = c.client_id) AS Nome,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS Empresa

FROM
contracts AS c
INNER JOIN authentication_contract_connection_occurrences AS acco ON c.id = acco.contract_id

WHERE acco.erp_code IS NULL AND acco.created >= '2021-08-31' AND c.created <= '2021-08-31' AND c.contract_type_id NOT IN (4)
ORDER BY c.created DESC

/*WHERE acco.erp_code IS NULL AND acco.created > '2021-06-30' AND c.created < '2021-07-01' AND c.contract_type_id NOT IN (4)*/