SELECT DISTINCT
c.id AS Cod_Contrato,
p.name AS Cliente,
(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
p.tx_id AS CPF_CNPJ,
p.cell_phone_1 AS celular,
p.phone AS telefone,
(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS empresa_contrato,
p.neighborhood AS Bairro, 
p.city AS Cidade, 
(SELECT s.title FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, 
c.amount AS Valor_contrato, 
c.collection_day AS Dia_Vencimento,
ce.description AS Motivo_cancelamento,
(SELECT cet.title FROM contract_event_types AS cet WHERE ce.contract_event_type_id = cet.id) AS Evento,
ce.created AS data_suspensao,
c.beginning_date AS data_ativacao,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = ce.created_by) AS Operador_Cancelamento,
c.v_status AS Status_Contrato

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
left JOIN contract_items AS con ON c.id = con.contract_id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id
INNER JOIN contract_event_types AS cet ON cet.id = ce.contract_event_type_id

WHERE ce.created BETWEEN '2021-12-01' AND '2022-01-01' AND ce.contract_event_type_id IN (43,153,152,206,207,208,209,210,211,212,224,219,221,207,223,220,208,222,206,209)
GROUP BY ce.created
ORDER BY ce.created DESC
