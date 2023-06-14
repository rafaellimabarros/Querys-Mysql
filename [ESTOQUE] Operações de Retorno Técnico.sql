SELECT
	nf.document_number AS numero_doc,
	nf.client_name AS `local`, 
	(SELECT u.name FROM v_users AS u WHERE u.id = nf.created_by) AS usuario,
	nfi.units AS qtd,
	nfi.description AS produtos,
	nf.entry_date AS data_da_nota,
	(SELECT op.title FROM financial_operations AS op WHERE nf.financial_operation_id = op.id) AS operacao
FROM
	invoice_notes AS nf
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
WHERE 
	nf.financial_operation_id = 11 AND nf.origin = 12 AND nf.entry_date > '2021-08-01'
ORDER BY 
	nf.document_number DESC
