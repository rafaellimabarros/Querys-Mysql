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
c.cancellation_date AS Data_Cancelamento

FROM contracts AS c
INNER JOIN people AS p ON c.client_id = p.id
INNER JOIN contract_items AS con ON c.id = con.contract_id

WHERE c.v_status = "cancelado"
AND c.client_id NOT IN (SELECT c.client_id FROM contracts AS c INNER JOIN authentication_contracts AS ac ON c.id = ac.contract_id)

GROUP BY p.id