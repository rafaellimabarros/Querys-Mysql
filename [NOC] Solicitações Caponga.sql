SELECT DISTINCT
ai.protocol AS Protocolo,
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
p.neighborhood AS bairro,
p.city AS cidade,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
a.description AS Descricao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.created AS Data_Abertura,
a.modified AS Data_Encerramento,
c.v_status AS Status_Contrato,
ac.user AS pppoe,
(SELECT acp.title FROM authentication_access_points AS acp WHERE acp.id = ac.authentication_access_point_id) AS Ponto_de_Acesso

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN contracts AS c ON c.client_id = a.requestor_id
INNER JOIN people AS p ON p.id = c.client_id
inner JOIN  authentication_contracts AS ac ON c.id = ac.contract_id

WHERE a.assignment_type = "INCI" AND p.neighborhood LIKE "%caponga" AND a.created >= '2021-12-27'

GROUP BY ai.protocol