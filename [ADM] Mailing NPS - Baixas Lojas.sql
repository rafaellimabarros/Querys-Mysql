SELECT
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
frt.receipt_date AS data_baixa,
vu.name AS operador

FROM financial_receipt_titles AS frt
INNER JOIN people AS p ON frt.client_id = p.id
LEFT JOIN v_users AS vu ON vu.id = frt.created_by

WHERE frt.receipt_date BETWEEN '2021-12-27' AND '2022-01-02' AND frt.origin = 4 AND vu.profile_id IN (30,37,47,48)
GROUP BY p.id
