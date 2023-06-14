SELECT DISTINCT
	p.id AS id_cliente,
	c.id AS id_contrato,
	p.name AS nome,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	p.tx_id AS cpf_cnpj,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone,
	p.cell_phone_1 AS celular,
	p.email AS email,
	p.street AS endereco,
	p.`number` AS numero_endereco,
	p.neighborhood AS bairro,
	p.city AS cidade,
	fat.title AS fatura,
	fat.bank_title_number AS NN,
	fat.typeful_line AS codigo_barras,
	fat.balance AS valor,
	fat.expiration_date AS vencimento,
	fat.competence AS competencia,
	(SELECT nf.title FROM financers_natures AS nf WHERE fat.financer_nature_id = nf.id) AS natureza_financeira,
	(SELECT oper.title FROM financial_operations AS oper WHERE fat.financial_operation_id = oper.id) operacao,
	(SELECT tipocobranca.title FROM financial_collection_types AS tipocobranca WHERE fat.financial_collection_type_id = tipocobranca.id) AS natureza_financeira,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	(SELECT s.title FROM service_products AS s WHERE s.id = con.service_product_id) AS plano,
	(SELECT s.selling_price FROM service_products AS s WHERE s.id = con.service_product_id) AS valor_plano,
	(SELECT comp.description FROM companies_places AS comp WHERE fat.company_place_id = comp.id) AS empresa
FROM 
	financial_receivable_titles AS fat
INNER JOIN  
	people AS p ON (fat.client_id = p.id)
LEFT JOIN 
	contracts AS c ON (fat.contract_id = c.id)
LEFT JOIN
	contract_items AS con ON (c.id = con.contract_id)
WHERE
	fat.p_is_receivable -- em aberto,
	AND fat.expiration_date BETWEEN '2021-05-01' AND '2021-05-31'
	AND fat.title LIKE "FAT%"
	AND fat.company_place_id != 3
	AND fat.financer_nature_id NOT IN (127, 140, 128, 199)
	AND fat.financial_collection_type_id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 28, 29)
GROUP BY
	fat.title