SELECT
	c.id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.name AS nome,
	p.tx_id AS cpf_cnpj,
	p.cell_phone_1 AS telefone1,
	p.phone AS telefone2,
	p.neighborhood AS bairro,
	p.city AS cidade,
	c.amount AS valor_contrato,
	(SELECT serv.title FROM service_products AS serv WHERE serv.id = pl.service_product_id) AS plano,
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor_1,
	ost.protocol AS protocolo,
	(SELECT tos.title FROM incident_types AS tos WHERE tos.id = ost.incident_type_id) AS tipo_os,
	(SELECT p.name FROM people AS p WHERE p.id = ass.responsible_id) AS tecnico,
	ass.description AS relato_abertura,
	DATE(ass.beginning_date) AS data_abertura,
	DATE(ass.final_date) AS prazo_SLA,
	DATE(ass.conclusion_date) AS data_encerramento,
	datediff(DATE(ass.conclusion_date),DATE(ass.final_date)) AS dias_atraso
FROM
	assignments AS ass
INNER JOIN
	assignment_incidents AS ost ON ass.id = ost.assignment_id
INNER JOIN 	
	people AS p ON ost.client_id = p.id
LEFT JOIN 
	contracts AS c ON p.id = c.client_id
LEFT JOIN
	authentication_contracts AS pl ON c.id = pl.contract_id
WHERE
	ass.conclusion_date BETWEEN '2021-12-01' AND '2022-01-01' AND c.company_place_id != 3 AND ost.incident_type_id IN (1010, 1011, 1012, 1331, 1349, 1350) AND ost.incident_status_id = 4
GROUP BY
	ass.id
ORDER BY
	ass.conclusion_date