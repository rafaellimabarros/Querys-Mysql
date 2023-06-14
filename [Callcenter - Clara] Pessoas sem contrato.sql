SELECT
p.id AS id_cliente,
p.name AS cliente,
p.deleted,
p.status,
p.client,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS edenreco,
p.email,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.created AS data_criacao,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = p.created_by) AS usuario_criador

FROM people AS p
LEFT JOIN assignments AS a ON a.requestor_id = p.id

WHERE p.id NOT IN (SELECT c.client_id FROM contracts AS c) AND a.requestor_id IS NULL
AND p.cell_phone_1 not IN (SELECT p.cell_phone_1 FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)
AND p.phone NOT IN (SELECT p.phone FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)
AND p.email NOT IN (SELECT p.email FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)

OR p.id NOT IN (SELECT c.client_id FROM contracts AS c) AND a.requestor_id IS NULL AND p.phone IS NULL
AND p.cell_phone_1 not IN (SELECT p.cell_phone_1 FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)
AND p.email NOT IN (SELECT p.email FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)

OR p.id NOT IN (SELECT c.client_id FROM contracts AS c) AND a.requestor_id IS NULL AND p.cell_phone_1 IS NULL
AND p.phone NOT IN (SELECT p.phone FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)
AND p.email NOT IN (SELECT p.email FROM people AS p INNER JOIN contracts AS c ON c.client_id = p.id)

GROUP BY p.id
ORDER BY p.created desc