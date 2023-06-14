SELECT 
	nf.id,
	nf.document_number,
	COUNT(nfi.units) AS cont,
	(SELECT u.name FROM v_users AS u WHERE nf.created_by = u.id) AS usuario,
	(SELECT op.title FROM financial_operations AS op WHERE nf.financial_operation_id = op.id) AS operacao,
	nfi.description,
	nfi.units,
	nfi.unit_amount,
	(SELECT emp.description FROM companies_places AS emp WHERE nf.company_place_id = emp.id) AS empresa
FROM 
	invoice_notes AS nf
INNER JOIN 
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
WHERE 
	nf.financial_operation_id = 8
	AND nf.issue_date BETWEEN '2022-02-01' AND '2022-02-28'
	/*AND nf.document_number = 13698*/
GROUP BY
	nf.id
HAVING cont > 2
