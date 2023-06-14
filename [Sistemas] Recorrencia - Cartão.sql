SELECT
p.name AS nome,
(SELECT fct.title FROM financial_collection_types AS fct WHERE fct.id = c.financial_collection_type_id) AS Tipo_cobranca

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id

WHERE financial_collection_type_id IN (25,26,27,54,55,56,57,58,59,60,61,62,63,64,65,66)