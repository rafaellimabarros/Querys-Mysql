SELECT 
	con.user AS pppoe,
	p.name AS nome,
	p.tx_id AS cpf_cnpj,
	p.phone AS telefone,
	p.cell_phone_1 AS telefone2,
	p.email AS email,
	p.street AS logradouro,
	p.number AS numero,
	p.address_complement AS complemento,
	p.neighborhood AS bairro,
	p.city AS cidade
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
INNER JOIN
	authentication_contracts AS con ON c.id = con.contract_id
WHERE
	con.user = 'brenadefatimanunesdasilva'