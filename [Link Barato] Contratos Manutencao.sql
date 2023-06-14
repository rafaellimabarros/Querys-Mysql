SELECT
c.id AS cod_contrato,
p.name AS cliente,
p.city AS cidade,
p.neighborhood AS bairro,
c.v_status AS status_contrato,
if(ac.service_product_id IS NULL,(SELECT sp.title FROM service_products AS sp WHERE sp.id = ci.service_product_id),(SELECT sp.title FROM service_products AS sp WHERE sp.id = ci.service_product_id)) AS servico_if,
if(ac.service_product_id IS NULL,ci.total_amount,ci.total_amount) AS valor_servico,
c.amount AS valor_total_contrato

FROM contracts AS c
LEFT JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN contract_items AS ci ON ci.contract_id = c.id

WHERE c.company_place_id = 3 AND c.v_stage ='Aprovado' AND c.v_status IN ('Normal','Demonstração', 'Cortesia', 'Suspenso', 'Bloqueio Financeiro', 'Bloqueio Administrativo')
AND ci.deleted = 0

ORDER BY p.name ASC,c.id asc
