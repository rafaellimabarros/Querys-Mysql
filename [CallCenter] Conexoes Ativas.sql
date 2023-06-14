SELECT 
c.id AS id_contrato,
p.name AS nome,
p.tx_id AS CPF_CNPJ,
c.v_status AS status_contrato

FROM
contracts AS c
INNER JOIN authentication_contracts AS ac ON c.id = ac.contract_id
INNER JOIN people AS p ON p.id = c.client_id

WHERE c.created <= '2022-02-11' AND c.contract_type_id NOT IN (4)
GROUP BY c.id
ORDER BY c.created DESC
