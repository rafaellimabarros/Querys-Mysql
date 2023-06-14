SELECT
n.id AS id_nota,
n.document_number AS numero_serie,
n.client_name AS nome_cliente,
n.company_place_name AS local_nota,
n.movement_date AS emissao,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ini.service_product_id) AS item,
ini.description AS descricao,
(SELECT um.title FROM units_measures AS um WHERE um.id = ini.first_units_measure_id) AS tipo_medida,
ini.units AS quantidade,
ini.unit_amount AS valor_unitario,
ini.total_amount AS valor_total,
ini.discount AS desconto

FROM invoice_notes AS n 
INNER JOIN invoice_note_items AS ini ON ini.invoice_note_id = n.id

WHERE 
	n.movement_date BETWEEN '2022-04-01' AND '2022-04-30'
	AND n.status = 1
	AND n.financial_operation_id IN (15,46)
	
ORDER BY n.movement_date asc
	