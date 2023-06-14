SELECT 
*

FROM people_uploads AS pu
INNER JOIN people AS p ON p.id = pu.people_id
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS con ON con.contract_id = c.id

WHERE pu.`begin` <= '2021-07-31' AND pu.documentation_type_id = 3 AND pu.people_id NOT IN (SELECT pu.people_id FROM people_uploads AS pu WHERE pu.`begin` >= '2021-08-01')