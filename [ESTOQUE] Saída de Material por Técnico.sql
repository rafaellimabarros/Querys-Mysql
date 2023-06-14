SELECT
	nf.document_number,
	(SELECT u.name FROM v_users AS u WHERE nf.created_by = u.id) AS usuario,
	(SELECT op.title FROM financial_operations AS op WHERE nf.financial_operation_id = op.id) AS operacao,
	nfi.description,
	nfi.units,
	nfi.unit_amount,
	nf.issue_date AS data_envio
FROM 
	invoice_notes AS nf
INNER JOIN 
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
WHERE 
	nf.financial_operation_id = 10 
	AND observation_invoice_1 LIKE "%FRANCISCO ARILSON%" 
	AND nf.issue_date BETWEEN '2022-02-01' AND '2022-02-31'