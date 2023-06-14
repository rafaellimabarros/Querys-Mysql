SELECT DISTINCT
	c.id AS id_contrato,
	DATE_FORMAT(c.date, '%d-%m-%Y') AS data_contrato,
	p.name AS nome,
	p.tx_id AS cpf_cnpj,
	p.neighborhood AS bairro,
	p.city AS cidade,
	p.street AS logradouro,
	p.number AS numero,
	p.address_complement AS complemento,
	p.cell_phone_1 AS celular,
	p.phone AS telefone,
	p.email AS email,
	con.user AS PPPoE,
	(SELECT cx.title FROM authentication_concentrators AS cx WHERE con.authentication_concentrator_id = cx.id) AS concentrador
FROM 
	contracts AS c
INNER JOIN
	people AS p ON c.client_id = p.id
INNER JOIN
	authentication_contracts AS con ON c.id = con.contract_id
WHERE 
	con.authentication_concentrator_id = 1
	AND c.date <= '2020-12-31'