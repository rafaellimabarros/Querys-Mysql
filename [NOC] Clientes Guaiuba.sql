SELECT
c.id AS cod_contrato,
p.name AS cliente,
p.city AS cidade,
p.neighborhood AS bairro,
(SELECT cst.service_tag FROM contract_service_tags AS cst WHERE cst.id = ac.service_tag_id) AS etiqueta,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
ac.user AS PPPOE,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso,
ac.slot_olt AS slot_olt,
(SELECT aucon.title FROM authentication_concentrators AS aucon WHERE aucon.id = ac.authentication_concentrator_id) AS concentrador,
IF (ac.ip_type = 1, "IP Fixo", "Pelo CE") AS Tipo_IP,
(SELECT aip.ip FROM authentication_ips AS aip WHERE aip.id = ac.ip_authentication_id) AS IP

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE p.city = 'Guaiuba'