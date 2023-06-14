SELECT
c.id AS id_contrato,
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
(SELECT pl.title FROM service_products AS pl WHERE pl.id = ac.service_product_id) AS plano,
c.amount AS valor_contrato,
c.v_status AS status_contrato,
max(ai.protocol) AS protocolo,
(SELECT inct.title FROM incident_types AS inct WHERE ai.incident_type_id = inct.id) AS tipo_solicitacao,
(SELECT ist.title FROM incident_status AS ist WHERE ist.id = ai.incident_status_id) AS status_solict,
a.created AS abertura,
a.conclusion_date AS encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_abertura,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento

FROM assignment_incidents AS ai
INNER JOIN assignments AS a ON a.id = ai.assignment_id
INNER JOIN people AS p ON p.id = ai.client_id
INNER JOIN contracts AS c ON c.client_id = ai.client_id
INNER JOIN authentication_contracts AS ac ON ac.contract_id = c.id

WHERE a.conclusion_date > '2021-10-10' AND a.created_by IN (73,85,77,76,196,80,75,83,279,72,74,66,205,78,67,186,65,70,222) and ai.incident_status_id = 4 
GROUP BY ai.client_id