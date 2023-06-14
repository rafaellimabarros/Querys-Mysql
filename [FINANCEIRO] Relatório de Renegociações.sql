SELECT 
	ren.id,
	p.name AS nome,
	date(ren.date) AS data_negociacao,
	(SELECT com.description FROM companies_places AS com WHERE ren.company_place_id = com.id) AS empresa,
	ren.total_amount_renegotiated AS valor_original,
	rent.expiration_date AS vencimento_original,
	ren.total_titles_renegotiated AS titulos_renegociados,
	fat.title AS titulo_gerado,
	fat.parcel AS parcela,
	ren.total_amount_generated AS valor_novo,
	max(fat.expiration_date) AS vencimento_novo,
	if(fat.balance = 0, 'Pago', 'Em aberto') AS status_pgt,
	ren.renegotiation_diff AS desconto_acrescimo,
	(SELECT vu.name FROM v_users AS vu WHERE ren.created_by = vu.id) usuario_renegociacao
FROM
	financial_renegotiations AS ren
INNER JOIN
	financial_renegotiation_titles AS rent ON ren.id = rent.financial_renegotiation_id
INNER JOIN
	financial_receivable_titles AS fat ON fat.id = rent.financial_receivable_title_id
INNER JOIN
	people AS p ON ren.client_id = p.id
WHERE
	date(ren.date) BETWEEN '2022-05-01' AND '2022-05-18'
	AND fat.renegotiated = 0
GROUP BY
	ren.id