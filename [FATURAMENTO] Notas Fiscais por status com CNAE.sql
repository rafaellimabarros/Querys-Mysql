SELECT
	nf.document_number AS numero_nf,
	c.id AS id_contrato,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	nf.client_name AS nome_cliente,
	p.city AS cidade,
	nfi.description AS produtos,
	nfi.service_code_provided AS codigo_servico,
	cnae.activity_code AS cnae, 
	nf.issqn_tax AS aliquota_iss,
	nf.issqn_amount AS valor_iss,
	nf.total_amount_service AS valor,
	nf.entry_date AS emissao,
	nf.company_place_name AS local
FROM 
	invoice_notes AS nf
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
INNER JOIN
	people AS p ON nf.client_id = p.id
LEFT JOIN 
	contracts AS c ON nf.client_id = c.client_id
LEFT JOIN 
	service_products AS serv ON nfi.service_product_id = serv.id
LEFT JOIN
	service_products_company_places AS cnae ON serv.id = cnae.service_product_id AND cnae.company_place_id = nf.company_place_id
WHERE
	nf.company_place_id = 9 AND nf.`status` = 1
	AND nf.financial_operation_id IN (1, 65)
	AND nf.entry_date BETWEEN '2022-03-01' AND '2022-03-31'
	
	# and c.v_stage = "Aprovado"
	# AND c.v_status != "Encerrado"
	# AND c.contract_date_configuration_id IN (3, 5, 6)
GROUP BY
	nf.id

	/*nf.issqn_tax,
	nf.issqn_amount,
	nf.issqn_deducted,
	nf.pis_tax,
	nf.pis_amount,
	nf.inss_tax,
	nf.inss_amount,
	nf.inss_deducted, */