SELECT
c.id AS Cod_Contrato,
p.name AS Cliente,
c.v_status AS Status_Contrato

FROM people AS p
INNER JOIN financial_receivable_titles AS frt ON p.id = frt.client_id
INNER JOIN contracts AS c ON p.id = c.client_id

WHERE frt.deleted = 0 AND frt.financial_collection_type_id IS NOT NULL
AND frt.p_is_receivable = 1 AND frt.original_expiration_date BETWEEN "2021-05-01" AND "2021-05-31"
AND c.v_status != 'cancelado' AND c.v_status != 'encerrado'

GROUP BY c.id
