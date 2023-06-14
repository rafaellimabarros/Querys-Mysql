SELECT
c.id AS cod_contrato,
p.name AS cliente,
ac.user AS PPPOE,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso,
(SELECT aucon.title FROM authentication_concentrators AS aucon WHERE aucon.id = ac.authentication_concentrator_id) AS concentrador,
IF (ac.ip_type = 1, "IP Fixo", "Pelo CE") AS Tipo_IP,
(SELECT aip.ip FROM authentication_ips AS aip WHERE aip.id = ac.ip_authentication_id) AS IP

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE ac.authentication_access_point_id IN (137,11,126,10,125,13,123,124,4,119) AND ac.ip_type = 1

ORDER BY ac.authentication_access_point_id

