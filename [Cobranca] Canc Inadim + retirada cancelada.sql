SELECT DISTINCT
c.id AS id_contrato,
(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
p.tx_id AS CPF_CNPJ,
p.name AS Cliente,
p.city AS Cidade, 
p.neighborhood AS Bairro, 
p.street AS Endereco,
p.number AS numero,
p.address_complement AS complemento,
p.cell_phone_1 AS celular,
p.phone AS telefone,
ce.description AS Motivo_cancelamento,
c.cancellation_date AS data_cancelamento_contrato,
c.v_status AS Status_Contrato,
ai.protocol AS protocolo,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_os,
(SELECT ist.title FROM incident_status AS ist WHERE ist.id = ai.incident_status_id) AS statu_solicitacao

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
LEFT JOIN contract_items AS con ON c.id = con.contract_id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id
INNER JOIN contract_event_types AS cet ON cet.id = ce.contract_event_type_id
LEFT JOIN assignments AS a ON a.requestor_id = p.id
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id

WHERE ce.created BETWEEN '2021-01-27' AND '2022-03-31' AND ce.contract_event_type_id IN (163, 184, 213)
AND ai.incident_status_id = 8 AND ai.incident_type_id IN (1015,1151,1231,1271,1291,1385,1387) AND c.v_status = 'Cancelado'
GROUP BY ce.created
ORDER BY ce.created DESC