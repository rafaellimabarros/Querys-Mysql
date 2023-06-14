SELECT DISTINCT c.id AS id_contrato,
p.name AS nome,
p.birth_date AS DT_Nascimento,
(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
p.tx_id AS CPF_CNPJ,
p.email AS email,
p.phone AS telefone,
p.cell_phone_1 AS telefone_2,
p.street AS Endereço,
p.neighborhood AS Bairro, 
p.city AS Cidade, 
c.beginning_date AS data_ativacao, 
(SELECT s.title FROM service_products AS s WHERE con.service_product_id = s.id) AS Plano, 
c.amount AS Valor_contrato, 
c.v_status AS Contrato_status, 
c.cancellation_date AS data_cancelamento,
c.cancellation_motive AS motivo_Cancelamento,
c.observation AS Data_Inicio_Fidelidade

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
INNER JOIN contract_items AS con ON c.id = con.contract_id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id

WHERE c.cancellation_date BETWEEN "2021-06-01" AND "2021-11-30" AND c.v_status = "cancelado" 
AND c.cancellation_motive LIKE "%inadim%"

GROUP BY c.id
ORDER BY c.cancellation_motive