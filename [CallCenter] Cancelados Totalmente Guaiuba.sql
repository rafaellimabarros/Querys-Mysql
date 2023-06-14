SELECT DISTINCT 
c.id AS Cod_Contrato,
p.name AS Nome,
p.tx_id AS CPF_CNPJ,
p.neighborhood AS Bairro, 
p.city AS Cidade, 
p.cell_phone_1 AS Telefone,
p.phone AS Telefone_2,
p.email AS Email,
(SELECT s.title FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, 
c.amount AS Valor_Plano, 
c.v_status AS Status_Contrato,
c.cancellation_date AS Data_Cancelamento,
(SELECT cet.title FROM contract_event_types AS cet WHERE ce.contract_event_type_id = cet.id) AS Evento

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
INNER JOIN contract_items AS con ON c.id = con.contract_id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id

WHERE c.v_status = "cancelado" AND p.company_place_id = 2 AND c.cancellation_date BETWEEN '2021-12-01' AND '2022-02-28' AND ce.contract_event_type_id IN (110,154,156,157,158,159,163,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,225,226)
AND c.client_id NOT IN (SELECT c.client_id FROM contracts AS c INNER JOIN authentication_contracts AS ac ON c.id = ac.contract_id)

GROUP BY c.id