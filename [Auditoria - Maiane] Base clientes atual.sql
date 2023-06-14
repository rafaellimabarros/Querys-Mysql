SELECT
c.id AS id_contrato,
p.name AS nome,
p.city AS cidade,
p.neighborhood AS bairro,
c.v_status AS status_contrato

FROM people AS p 
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.v_status NOT IN ('Cancelado')