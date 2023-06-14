SELECT 
p.name AS Cliente,
ac.user AS PPPOE,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS Plano,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso,
(SELECT aip.ip FROM authentication_ips AS aip WHERE aip.id = ac.ip_authentication_id) AS IP,
IF (ac.ip_type = 1, "IP Fixo", "Pelo CE") AS Tipo_IP

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE p.type_tx_id = 1