SELECT cv.contract_id, p.name, cv.created AS data_evento, REPLACE(SUBSTRING_INDEX(cv.description, "|", 1), "Serviço alterado de", "") AS plano_antigo, cv.description
FROM contract_events AS cv
INNER JOIN contracts AS c ON cv.contract_id = c.id
INNER JOIN people AS p ON c.client_id = p.id
WHERE cv.description LIKE "Serviço Alterado%" AND cv.created BETWEEN "2021-07-01" AND "2021-07-07"