SELECT
c.id AS id_contrato,
p.name AS nome,
p.tx_id AS CNPJ,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular1,
p.phone AS telefone,
p.email AS email,
(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
c.cancellation_date AS data_cancelamento,
c.v_status AS status_contrato

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id

WHERE c.v_status = 'cancelado' AND c.cancellation_date >= "2021-06-01"
GROUP BY c.id