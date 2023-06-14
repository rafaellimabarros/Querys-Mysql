SELECT
date(inv.created) AS data_criacao,
vu.name AS usuario_criador,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ini.service_product_id) AS material,
ini.units AS quantidade,
(SELECT um.title FROM units_measures AS um WHERE um.id = ini.first_units_measure_id) AS medida,
inv.company_place_name AS empresa,
(SELECT invs.title FROM invoice_series AS invs WHERE invs.id = inv.invoice_serie_id) AS serie,
(SELECT fo.title FROM financial_operations AS fo WHERE fo.id = inv.financial_operation_id) AS operacao,
inv.document_number AS numero_nota,
inv.client_name AS cliente

FROM invoice_notes AS inv
INNER JOIN invoice_note_items as ini ON inv.id = ini.invoice_note_id
LEFT JOIN v_users AS vu ON vu.id = inv.created_by
/*
INNER JOIN patrimony_packing_list_items AS pack ON pack.patrimony_id = ini.patrimony_id
INNER JOIN patrimony_packing_lists AS pp ON pp.id = pack.patrimony_packing_list_id
INNER JOIN assignments AS a ON a.id = pp.assignment_id
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id*/

WHERE inv.financial_operation_id = 17 AND date(inv.created) BETWEEN '2022-07-10' AND '2022-07-10'

