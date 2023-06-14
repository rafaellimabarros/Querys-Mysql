SELECT
	p.id AS id_forncedor,
	p.name AS fornecedor,
	(SELECT emp.description FROM companies_places as emp WHERE titp.company_place_id = emp.id) AS empresa_contrato,
	(SELECT nf.title FROM financers_natures AS nf WHERE titp.financer_nature_id = nf.id) AS natureza_financeira,
	tit.title AS titulo,
	tit.complement AS complemento,
	tit.parcel AS parcela,
	tit.expiration_date AS data_vencimento,
	titp.payment_date AS data_pagamento,
	titp.amount AS valor_original,
	titp.increase_amount AS juros,
	titp.fine_amount AS multa,
	titp.discount_value AS valor_desconto,
	titp.total_amount AS valor_total,
	(SELECT bank.description FROM bank_accounts AS bank WHERE bank.id = titp.bank_account_id) AS conta_liq
FROM 
	financial_paid_titles AS titp
LEFT JOIN 
	financial_payable_titles AS tit ON titp.financial_payable_title_id = tit.id
INNER JOIN
	people AS p ON titp.supplier_id = p.id
WHERE
	titp.payment_date BETWEEN '2021-01-26' AND '2021-05-31' AND titp.company_place_id =  5