SELECT
c.id AS cod_contrato,
p.name AS Cliente,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS endereco,
p.address_complement,
p.cell_phone_1 AS celular,
p.phone AS telefone,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS Plano,
ac.user AS PPPOE,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso,
(SELECT aucon.title FROM authentication_concentrators AS aucon WHERE aucon.id = ac.authentication_concentrator_id) AS concentrador,
IF (ac.ip_type = 1, "IP Fixo", "Pelo CE") AS Tipo_IP,
(SELECT aip.ip FROM authentication_ips AS aip WHERE aip.id = ac.ip_authentication_id) AS IP

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE p.neighborhood LIKE '%cidade alpha%' OR p.street LIKE '%cidade alpha%' OR p.neighborhood LIKE '%cidade alfa%' OR p.street LIKE '%cidade alfa%'
OR p.address_complement LIKE '%cidade alpha%' OR p.address_complement LIKE '%cidade alfa%'