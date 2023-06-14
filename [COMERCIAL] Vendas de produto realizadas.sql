SELECT 
	nf.id AS id_nota, 
	nf.client_name AS nome_cliente, 
	nfi.description AS produtos,
	nfi.units AS qtd,
	nfi.unit_amount AS valor_venda_produto, 
	nfi.mean_amount AS valor_custo_produto,
	nf.total_amount_liquid AS valor_da_nota, 
	ca.activation_date AS data_ativacao, 
	(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor_contrato,
	(SELECT u.name from v_users AS u where nf.created_by = u.id) AS vendedor_nota,
	(SELECT p.name from people AS p where nf.vendor_id = p.id) AS vendedor_nota,
	nf.entry_date AS data_da_nota
FROM
	invoice_notes AS nf
LEFT JOIN
	contracts AS c ON nf.client_id = c.client_id
LEFT JOIN 
	contract_assignment_activations AS ca ON c.id = ca.contract_id
INNER JOIN
	invoice_note_items AS nfi ON nf.id = nfi.invoice_note_id
WHERE 
	nf.entry_date BETWEEN '2022-01-01' AND '2022-01-31' AND (nf.financial_operation_id IN (15, 34, 63)) AND nf.`status` != 9

