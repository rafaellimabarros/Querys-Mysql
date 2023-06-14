SELECT DISTINCT
p.name AS Cliente,
p.city AS Cidade,
p.neighborhood AS Bairro,
p.street AS Endereco,
p.number AS Numero_casa,
p.street_type AS tipo_endereco,
p.address_complement AS Complemento_1,
p.address_reference AS Complemento_2

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE p.neighborhood = 'camara' AND p.street LIKE '%manoel%'