SELECT 
c.id AS id_contrato,
p.name AS nome,
p.tx_id AS CNPJ,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS endereço,
p.cell_phone_1 AS celular1,
p.phone AS telefone,
p.email AS email,
c.amount AS valor_plano,
(SELECT comp.description FROM companies_places AS comp WHERE c.company_place_id = comp.id AND c.company_place_id != 3) AS empresa_contrato,
c.v_status AS status_contrato,
c.observation AS fidelidade,
c.v_status AS status_contrato,
c.cancellation_date AS data_cancelamento,
c.cancellation_motive AS motico_cancelamento

FROM people AS p
INNER JOIN contracts AS c ON p.id = c.client_id

WHERE p.type_tx_id = 1 AND c.v_status = 'cancelado'
AND c.client_id NOT IN (SELECT c.client_id FROM contracts AS c INNER JOIN authentication_contracts AS ac ON c.id = ac.contract_id)

GROUP BY p.id