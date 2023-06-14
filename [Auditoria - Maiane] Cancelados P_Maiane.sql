SELECT DISTINCT
c.id AS Cod_Contrato,
p.name AS Cliente,
(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
p.tx_id AS CPF_CNPJ,
p.cell_phone_1 AS celular,
p.phone AS telefone,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = c.company_place_id) AS empresa,
p.neighborhood AS Bairro, 
p.city AS Cidade, 
(SELECT s.title FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, 
c.amount AS Valor_contrato, 
c.collection_day AS Dia_Vencimento,
(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor,
ce.description AS Motivo_cancelamento,
(SELECT cet.title FROM contract_event_types AS cet WHERE ce.contract_event_type_id = cet.id) AS Evento,
ce.created AS data_evento,
c.cancellation_date AS data_cancelamento_contrato,
c.beginning_date AS data_ativacao,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = ce.created_by) AS Operador_Cancelamento,
c.v_status AS Status_Contrato

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
left JOIN contract_items AS con ON c.id = con.contract_id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id
INNER JOIN contract_event_types AS cet ON cet.id = ce.contract_event_type_id

WHERE ce.created BETWEEN '2021-12-01' AND '2022-01-01' AND ce.contract_event_type_id IN (110,154,156,157,158,159,163,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,224,225,226)
/*WHERE c.cancellation_date BETWEEN "2021-06-01" AND "2021-06-30" AND c.v_status = "cancelado" */
GROUP BY ce.created
ORDER BY ce.created DESC
