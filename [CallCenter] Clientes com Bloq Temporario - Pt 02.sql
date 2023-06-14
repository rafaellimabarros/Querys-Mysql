SELECT
c.id AS cod_contrato,
p.name AS cliente,
c.v_status AS status_contrato,
p.city AS cidade,
p.neighborhood AS bairro,
(SELECT cst.service_tag FROM contract_service_tags AS cst WHERE cst.id = ac.service_tag_id) AS etiqueta,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
ce.date,
(SELECT cet.title FROM contract_event_types AS cet WHERE ce.contract_event_type_id = cet.id) AS Evento,
ce.description AS Motivo

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
left JOIN authentication_contracts AS ac ON ac.contract_id = p.id
INNER JOIN contract_events AS ce ON c.id = ce.contract_id

WHERE c.v_status = 'suspenso' AND ce.contract_event_type_id IN (151) 
AND c.id NOT IN (SELECT c.id FROM contracts AS c INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id INNER JOIN contract_events AS ce ON ce.contract_id = c.id WHERE c.v_status = 'suspenso' AND ce.contract_event_type_id IN (43,152,153,206,207,208,209,210,211,212,215,216,217,218,219,220,221,222,223,224,231))
AND ce.description LIKE '%Qtde contas suspensas%'
/*OR 
c.v_status = 'suspenso' AND ce.contract_event_type_id IN (151) 
AND c.id NOT IN (SELECT c.id FROM contracts AS c INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id INNER JOIN contract_events AS ce ON ce.contract_id = c.id WHERE c.v_status = 'suspenso' AND ce.contract_event_type_id IN (43,152,153,206,207,208,209,210,211,212,215,216,217,218,219,220,221,222,223,224,231))
*/
GROUP BY c.id