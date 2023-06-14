SELECT DISTINCT
c.id AS cod_contrato,
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
c.v_status AS Status_Contrato,
p.neighborhood AS bairro,
p.city AS cidade,
ai.protocol AS Protocolo,
(SELECT it.code FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS cod_solicitacao,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
a.description AS Descricao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao,
a.created AS Data_Abertura,
a.final_date AS Data_Prazo,
a.modified AS Data_Encerramento,
IF( a.modified > a.final_date, "Sim", "Nao" ) AS Em_Atraso,
(SELECT t.title FROM teams AS t WHERE ai.origin_team_id = t.id) AS Equipe_Abertura,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_Abertura,
(SELECT t.title FROM teams AS t WHERE ai.team_id = t.id) AS Equipe_Encerramento,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN contracts AS c ON c.client_id = a.requestor_id
INNER JOIN people AS p ON p.id = c.client_id
inner JOIN  authentication_contracts AS ac ON c.id = ac.contract_id

WHERE a.assignment_type = "INCI" AND a.created BETWEEN '2022-01-01' AND '2022-03-31' AND p.city LIKE '%aracoiaba%'
OR a.assignment_type = "INCI" AND a.created BETWEEN '2022-01-01' AND '2022-03-31' AND p.city LIKE '%acarape%'
OR a.assignment_type = "INCI" AND a.created BETWEEN '2022-01-01' AND '2022-03-31' AND p.city LIKE '%redenção%'
OR a.assignment_type = "INCI" AND a.created BETWEEN '2022-01-01' AND '2022-03-31' AND p.city LIKE '%antonio diogo%'
OR a.assignment_type = "INCI" AND a.created BETWEEN '2022-01-01' AND '2022-03-31' AND p.city LIKE '%guaiuba%'

GROUP BY ai.protocol
ORDER BY p.name