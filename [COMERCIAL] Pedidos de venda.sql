SELECT
	nf.document_number AS numero_nf,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	nf.client_name AS nome_cliente,
	p.city AS cidade,
	nfi.description AS produtos,
	nf.sale_request_id,
	pv.vendor_id,
	nf.created_by,
	nf.entry_date AS emissao,
	nf.`status`,
	pv.situation,
	nf.company_place_name AS local
FROM 
	invoice_notes AS nf
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
INNER JOIN
	people AS p ON nf.client_id = p.id
LEFT JOIN 
	service_products AS serv ON nfi.service_product_id = serv.id
LEFT JOIN
	sale_requests AS pv ON nf.sale_request_id = pv.id
WHERE
	nf.document_number = 186985
GROUP BY
	nf.document_number,
	nf.company_place_number