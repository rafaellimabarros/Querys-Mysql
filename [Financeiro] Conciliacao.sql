SELECT 
	conc.financial_bank_conciliation_file_id AS id_conciliacao,
	conc.transation_type AS tipo,
	conc.description AS descricao,
	if(conc.`signal` = 1, "CREDITO", "DEBITO") AS sinal,
	conc.effective_date AS data_conciliacao
FROM 
	financial_bank_conciliation_occurrences AS conc
INNER JOIN 
	v_users AS u ON conc.modified_by = u.id
WHERE 
	date(effective_date) BETWEEN '2022-04-01' AND '2022-04-05'
	# AND financial_bank_conciliation_file_id = 2727
	AND conc.vinculated_posting = 1
	AND conc.modified_by = 40