SELECT 
	nf.id AS id_nota, 
	(SELECT p.name FROM people AS p WHERE p.id = supplier_id) AS fornecedor,
	nfi.description AS produtos,
	(SELECT oper.title FROM financial_operations AS oper WHERE nf.financial_operation_id = oper.id) AS natureza_financeira,
	(SELECT nfna.title FROM financers_natures AS nfna WHERE nf.financer_nature_id = nfna.id) AS natureza_financeira,
	nf.entry_date AS data_da_nota
FROM 
	invoice_notes AS nf
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
WHERE 
	nf.entry_date BETWEEN '2021-01-01' AND '2021-10-26' AND nf.financial_operation_id IN (2,3,7,16) AND nf.`status` != 9
	

