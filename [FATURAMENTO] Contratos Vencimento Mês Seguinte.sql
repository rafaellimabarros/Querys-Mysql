SELECT 
	c.id AS id_contrato,
	p.name AS nome_cliente,
	(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS Tipo_Cliente,
	c.collection_day AS vencimento,
	c.cut_day AS dia_corte,
	(SELECT cicl.title FROM contract_date_configurations AS cicl WHERE c.contract_date_configuration_id = cicl.id) AS ciclo_faturamento,
	c.v_status AS status_contrato,
	billing_beginning_date,
	c.created AS criacao_contrato
FROM 
	contracts AS c
INNER JOIN 
	people AS p ON c.client_id = p.id
LEFT JOIN 
	contract_items AS pl ON c.id = pl.contract_id
WHERE 
	c.automatic_blocking = 0 AND c.v_status != "Cancelado" AND c.v_status != "Encerrado" AND c.company_place_id != 3
	/*c.expiration_docket = 0 AND c.v_status != "Cancelado" AND c.v_status != "Encerrado" AND c.billing_beginning_date = '2021-08-01'*/
GROUP BY
	c.id
ORDER BY
	id_contrato DESC