SELECT 
	evt.contract_id,
	p.name AS nome,
	evt.description,
	evt.date AS data_evento
FROM contract_events AS evt
INNER JOIN 
	contracts AS c ON evt.contract_id = c.id
INNER JOIN 
	people AS p ON c.client_id = p.id
WHERE
	evt.contract_event_type_id = 6
	AND evt.date BETWEEN '2021-08-01' AND '2021-08-31'
	/*AND description LIKE "%TWE%"*/