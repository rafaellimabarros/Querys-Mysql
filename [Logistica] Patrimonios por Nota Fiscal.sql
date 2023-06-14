SELECT DISTINCT
ivn.client_id,
ivn.client_name,
c.v_status AS Status_Contrato,
c.cancellation_date AS Data_Cancelamento,
ivn.client_city AS Cidade,
ivn.client_neighborhood AS Bairro,
ini.description AS Equipamento

FROM invoice_notes AS ivn
INNER JOIN invoice_note_items AS ini ON ivn.id = ini.invoice_note_id
INNER JOIN contracts AS c ON ivn.client_id = c.client_id
INNER JOIN people AS p ON p.id = c.client_id

WHERE ivn.financial_operation_id = 8 AND ini.service_product_id IN (1481,1496,1581)
AND ivn.client_neighborhood = 'barra do ceara' AND c.cancellation_date >= '2021-04-01'

GROUP BY ivn.client_id