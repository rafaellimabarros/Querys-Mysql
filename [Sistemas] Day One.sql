SELECT
c.id AS cod_contrato,
p.name AS nome,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS rua,
p.type_tx_id AS tipo,
(SELECT tx.name FROM tx_types AS tx WHERE p.type_tx_id = tx.id) AS tipo_cliente,
c.v_status AS status_contrato,
ac.user AS pppoe,
ac.service_product_id AS plano,
sp.title AS plano_nome

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN service_products AS sp ON sp.id = ac.service_product_id

WHERE p.name = 'RAFAEL LIMA BARROS'