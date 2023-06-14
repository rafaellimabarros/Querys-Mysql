SELECT 
c.id AS Cod_Contrato,
p.name AS Cliente,
(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
c.beginning_date AS data_ativacao,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.neighborhood AS Bairro, 
p.street AS logradouro,
p.number AS numero,
p.address_complement AS complemento,
p.city AS Cidade, 
(SELECT s.title FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, 
c.amount AS Valor_contrato, 
ce.description AS Motivo_cancelamento,
(SELECT cet.title FROM contract_event_types AS cet WHERE ce.contract_event_type_id = cet.id) AS Evento,
c.cancellation_date AS data_cancelamento_contrato,
c.v_status AS Status_Contrato,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS empresa

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN contract_events AS ce ON c.id = ce.contract_id AND ce.contract_event_type_id IN (110,154,156,157,158,159,163,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,225,226)
LEFT JOIN contract_items AS con ON c.id = con.contract_id

WHERE c.company_place_id = 7 AND (c.v_status = "cancelado" OR c.v_status = "Encerrado") AND cancellation_date BETWEEN '2021-01-01' AND '2022-02-28'
 
GROUP BY c.id
