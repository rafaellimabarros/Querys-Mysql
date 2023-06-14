SELECT 
c.id AS codigo_contrato,
p.name AS cliente,
(SELECT txt.name FROM tx_types AS txt WHERE txt.id = p.type_tx_id) AS tipo,
(SELECT title FROM financers_natures AS f WHERE c.financer_nature_id = f.id) AS natureza_financeira, 
c.amount AS valor_servico,
ci.description AS servico,
c.approval_date AS data_ativacao,
c.beginning_date AS data_inicio,
c.final_date AS data_fim,
c.v_status AS status_contrato

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id
LEFT JOIN authentication_contracts AS ac ON ac.contract_id = c.id
INNER JOIN contract_items AS ci ON ci.contract_id = c.id and ci.deleted = 0

WHERE c.company_place_id = 3 AND c.v_status != 'cancelado'
GROUP BY c.id