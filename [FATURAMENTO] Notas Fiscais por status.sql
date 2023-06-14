SELECT
	nf.document_number AS numero_nf,
	c.id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	if(p.taxes_municipality = 1, "SIM", "NÃO") AS tributa_municipio,
	if(p.taxes_issqn = 1, "SIM", "NÃO") AS tributa_iss,
	if(p.resp_retains = 1, "SIM", "NÃO") AS responsavel_retencao,
	nf.client_name AS nome_cliente,
	p.phone AS telefone,
	p.cell_phone_1 AS celular,
	p.email AS email,
	p.city AS cidade, 
	nfi.description AS produtos,
	nf.company_place_name,
	nf.status
FROM 
	invoice_notes AS nf
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
INNER JOIN
	people AS p ON nf.client_id = p.id
LEFT JOIN 
	contracts AS c ON nf.client_id = c.client_id
WHERE
	nf.company_place_id = 9 AND nf.`status` = 1
	AND nf.financial_operation_id IN (1, 65)
	
	# and c.v_stage = "Aprovado"
	# AND c.v_status != "Encerrado"
	# AND c.contract_date_configuration_id IN (3, 5, 6)
GROUP BY
	nf.id
	