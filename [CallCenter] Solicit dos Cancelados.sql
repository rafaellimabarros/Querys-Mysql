SELECT DISTINCT
ai.protocol AS Protocolo,
(SELECT p.name FROM people AS p WHERE a.requestor_id = p.id) AS Cliente,
/*(SELECT p.name FROM people AS p WHERE p.id = (SELECT apr.origin_person_id FROM assignment_person_routings AS apr WHERE apr.id = (SELECT MIN(apr.id) FROM assignment_person_routings AS apr WHERE a.id = apr.assignment_id))) AS Menor_ID,
4 selects */
c.v_status AS Status_Contrato,
(SELECT p.tx_id FROM people AS p WHERE a.requestor_id = p.id) AS CPF_CNPJ,
(SELECT it.title FROM incident_types AS it WHERE ai.incident_type_id = it.id) AS Tipo_Solicitacao,
a.created AS Data_Abertura,
a.final_date AS Data_Prazo,
a.modified AS Data_Encerramento,
IF( a.modified > a.final_date, "Sim", "Nao" ) AS Em_Atraso,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.created_by) AS Atendente_Origem,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = a.modified_by) AS Atendente_Encerramento,
(SELECT t.title FROM teams AS t WHERE ai.origin_team_id = t.id) AS Equipe_Origem,
a.title AS Titulo,
a.description AS Descricao,
(SELECT ins.title FROM incident_status AS ins WHERE ai.incident_status_id = ins.id) AS Status_Solicitacao

FROM assignments AS a
INNER JOIN assignment_incidents AS ai ON ai.assignment_id = a.id
INNER JOIN contracts AS c ON c.client_id = a.requestor_id

WHERE a.assignment_type = "INCI" AND a.responsible_id IS NOT NULL AND c.cancellation_date BETWEEN "2021-06-01" AND "2021-11-30" AND c.v_status = "cancelado" AND c.cancellation_motive LIKE "%inadim%"