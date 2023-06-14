SELECT 
c.id AS cod_contrato,
p.name AS cliente,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS empresa,
c.v_status AS status_contrato,
pu.name AS nome_documento,
pu.title AS titulo_documento,
pu.`begin` AS vingencia_inicial,
pu.final AS vigencia_final,
date(pu.created) AS data_criacao,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = pu.created_by) AS usuario_criador

FROM people_uploads AS pu
INNER JOIN people AS p ON p.id = pu.people_id
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.company_place_id = 9 AND pu.deleted = 0 AND pu.documentation_type_id = 3

GROUP BY p.id