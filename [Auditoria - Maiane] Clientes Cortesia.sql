SELECT DISTINCT
c.id AS cod_contrato,
p.name AS nome,
(SELECT emp.description FROM companies_places as emp WHERE c.company_place_id = emp.id) AS empresa_contrato,(SELECT tipo.name FROM tx_types AS tipo WHERE p.type_tx_id = tipo.id) AS Tipo,
p.tx_id AS CPF_CNPJ,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.neighborhood AS Bairro, 
p.city AS Cidade, 
(SELECT s.title FROM service_products AS s WHERE ac.service_product_id = s.id) AS Plano,
(SELECT p.name FROM people AS p WHERE p.id = c.seller_1_id) AS vendedor, 
c.v_status AS Status_Contrato,
(SELECT ct.title FROM contract_types AS ct WHERE ct.id = c.contract_type_id) AS Tipo

FROM contracts AS c
LEFT JOIN authentication_contracts AS ac ON c.id = ac.contract_id
INNER JOIN people AS p ON p.id = c.client_id

WHERE c.contract_type_id = 4 AND c.v_status NOT IN ('Cancelado','Encerrado') AND p.tx_id NOT IN ('97385595022')

GROUP BY c.id