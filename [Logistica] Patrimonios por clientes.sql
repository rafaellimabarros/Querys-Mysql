SELECT
p.name AS Cliente,
pa.title AS Equipamento,
pa.serial_number AS Serial_Equipamento,
p.phone AS telefone,
p.cell_phone_1 AS telefone_2,
p.city AS Cidade, 
p.neighborhood AS Bairro, 
c.v_status AS Contrato_status

FROM patrimonies AS pa
INNER JOIN contracts AS c ON c.id = pa.contract_id
INNER JOIN people AS p ON p.id = c.client_id

WHERE pa.patrimony_type_id = 3 AND c.created >= '2021-01-26'