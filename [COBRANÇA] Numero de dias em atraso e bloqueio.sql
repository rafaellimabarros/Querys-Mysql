SELECT DISTINCT
	c.id AS id_contrato,
	c.v_status AS status_contrato,
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.neighborhood AS bairro,
	p.city AS cidade,
	fat.title AS fatura,
	fat.bank_title_number AS NN,
	fat.balance AS valor,
	fat.expiration_date AS vencimento,
	datediff(CURDATE(),DATE(min(fat.expiration_date))) AS dias_atraso,
	DATE(max(cev.date)) AS data_bloqueio,
	datediff(CURDATE(),DATE(max(cev.date))) AS dias_bloqueado,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	(SELECT oper.title FROM financial_operations AS oper WHERE fat.financial_operation_id = oper.id) operacao,
	(SELECT tipocobranca.title FROM financial_collection_types AS tipocobranca WHERE fat.financial_collection_type_id = tipocobranca.id) AS tipo_cobranca,
	(SELECT comp.description FROM companies_places AS comp WHERE fat.company_place_id = comp.id) AS empresa
FROM 
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
INNER JOIN
	contract_events AS cev ON (fat.contract_id = cev.contract_id)
WHERE
	fat.p_is_receivable -- em aberto,
	AND fat.title LIKE "FAT%"
	AND (c.contract_type_id NOT IN (4, 6 ,7, 8, 9) OR c.id IS NULL)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id NOT IN (127, 140, 128, 199)
	AND fat.financial_collection_type_id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 28, 29)
	AND c.v_status = "Bloqueio Financeiro"
	AND cev.contract_event_type_id = 40
GROUP BY
	c.id
HAVING dias_atraso >= 60 /*datediff(CURDATE(),DATE(max(cev.date))) >= 60 */
ORDER BY
	fat.expiration_date DESC
/*HAVING NOT ult_liq >= '2021-09-01'*/
