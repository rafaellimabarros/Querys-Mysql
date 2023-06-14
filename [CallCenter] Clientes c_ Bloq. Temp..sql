SELECT
c.id AS id_contrato,
p.name AS nome,
p.tx_id AS CNPJ,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular1,
p.phone AS telefone,
p.email AS email,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS Plano,
c.amount AS valor_plano,
(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
c.v_status AS status_contrato,
ac.user AS conexao,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS ponto_de_Acesso

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
left JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.v_status = 'Suspenso'