SELECT
	ca.contract_id AS id_contrato,
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
	date(ass.beginning_date) AS data_abertura,
	ca.activation_date AS data_ativacao,
	date(ass.final_date) AS prazo_SLA,
	datediff(ca.activation_date,DATE(ass.final_date)) AS dias_atraso
FROM
	contract_assignment_activations AS ca
INNER JOIN 
	contracts AS c ON ca.contract_id = c.id
INNER JOIN
	people AS p ON c.client_id = p.id
LEFT JOIN
	assignment_incidents AS ost ON ca.assignment_id = ost.assignment_id
LEFT JOIN
	assignments AS ass ON ca.assignment_id = ass.id
LEFT JOIN 
	invoice_notes AS nf ON ca.invoice_note_id = nf.id
LEFT JOIN
	authentication_contracts AS pl ON ca.contract_id = pl.contract_id
WHERE
	ca.activation_date BETWEEN '2021-10-01' AND '2021-11-31' AND c.company_place_id != 3
ORDER BY
	ca.activation_date