SELECT DISTINCT
	c.id AS id_contrato,
	p.name AS nome,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.cell_phone_1 AS celular,
	p.phone AS telefone,
	p.email AS email,
	(SELECT pl.title FROM service_products AS pl WHERE pl.id = conx.service_product_id) AS plano,
	c.amount AS valor_contrato,
	c.v_status AS status_contrato,
	max(os.protocol) AS protocolo,
	(SELECT inct.title FROM incident_types AS inct WHERE os.incident_type_id = inct.id) AS tipo_os,
	prto.created AS abertura,
	prto.conclusion_date AS encerramento
FROM
	assignment_incidents AS os
INNER JOIN 
	assignments AS prto ON os.assignment_id = prto.id
INNER JOIN 
	people AS p ON os.client_id = p.id
INNER JOIN
	contracts AS c ON os.client_id = c.client_id
INNER JOIN 
	authentication_contracts AS conx ON conx.contract_id = c.id
WHERE
	prto.conclusion_date  > CURDATE()-1 AND os.incident_type_id IN (1005, 1006, 10010, 1011, 1012, 1013, 1016, 1018, 1019, 1017, 1070, 1079, 1069, 1073) AND incident_status_id = 4 
GROUP BY
	p.name