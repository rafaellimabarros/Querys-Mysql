SELECT 
	c.id AS id_contrato,
	p.name AS nome,
	p.tx_id AS CPF,
	COALESCE((SELECT p.phone FROM people AS p WHERE p.id = c.responsible_financial_id),p.phone) AS telefone,
	p.cell_phone_1 AS celular1,
	p.email AS email,
	fat.title AS fatura,
	fat.balance AS valor,
	fat.expiration_date AS vencimento,
	(SELECT MAX(pag.receipt_date) FROM financial_receipt_titles AS pag WHERE fat.client_id = pag.client_id) AS ult_liq,
	(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato
FROM 
	financial_receivable_titles AS fat
INNER JOIN 
	people AS p ON fat.client_id = p.id 
LEFT JOIN
	contracts AS c ON fat.contract_id = c.id
WHERE
	fat.p_is_receivable = 1
	AND fat.`type` = 2
	AND fat.deleted = 0
	AND fat.origin NOT IN (2, 3, 5, 7)
	AND c.contract_type_id NOT IN (4, 6, 7, 8, 9)
	AND fat.company_place_id != 3
	AND fat.financer_nature_id != 158
	AND fat.financial_collection_type_id IS NOT NULL
	AND fat.renegotiated = 0
	AND DATE(fat.expiration_date) BETWEEN '2021-12-01' AND '2021-12-31'
GROUP BY
	p.id,
	fat.id
ORDER BY
	fat.expiration_date asc
