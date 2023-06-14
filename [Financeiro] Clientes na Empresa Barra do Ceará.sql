SELECT
c.id AS numero_contrato,
p.name AS nome,
IF( p.type_tx_id > 1, "CPF", "CNPJ" ) AS tipo,
(SELECT sp.title FROM service_products AS sp WHERE sp.id = ac.service_product_id) AS Plano,
c.amount AS valor_plano,
c.v_status AS status_contrato,
(SELECT fn.title FROM financers_natures AS fn WHERE fn.id = c.financer_nature_id) AS natureza_financeira,
(SELECT fo.title FROM financial_operations AS fo WHERE fo.id = c.operation_id) AS operacao

FROM people AS p
INNER JOIN contracts AS c ON c.client_id = p.id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE c.company_place_id = 5