SELECT
p.name AS Cliente,
ac.user AS PPPOE,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS Plano,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso,
(SELECT aip.ip FROM authentication_ips AS aip WHERE aip.id = ac.ip_authentication_id) AS IP,
IF (ac.ip_type = 1, "IP Fixo", "Pelo CE") AS Tipo_IP

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE p.neighborhood = 'pires façanha' AND p.street IN ('APHAVILLE EUSEBIO','CE 040','CE 040 ','CE 040 Km 08','CE 040 Km 22','Ce 040 km 22 2131','Rodovia 040 Km 22/Quadra L1 Lot 6','RODOVIA CE 040 KM 22 ALPHAVILLE','Rodovia CE-040','Rodovia CE-040- s/n Quilômetro 22','Rua Belgica','RUA BELGICA Q V1 L03 ','Rua Espanhola','Rua Italia','Rua Italia Quadra Z 1 Lot. 7','RUA SUIÇA','RUA ÁUSTRIA')
