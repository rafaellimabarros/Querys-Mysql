SELECT
pat.id AS cod_patrimonio,
pat.title AS titulo,
pat.serial_number AS num_se_serie,
pat.tag_number AS num_patrimonio,
(SELECT cp.description FROM companies_places AS cp WHERE cp.id = pat.company_place_id) AS empresa,
if(pat.p_is_disponible = 1, 'Sim','Não') AS disponivel,
if(pat.deleted = 1, 'Sim','Não') AS descartado,
pato.id AS cod_ocorrencia,
pato.description AS descricao,
pato.modified AS data_ocorrencia,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = pato.modified_by) AS responsavel

FROM patrimonies AS pat
INNER JOIN patrimony_occurrences AS pato ON pato.patrimony_id = pat.id

WHERE pato.description LIKE '%de Separado Manutenção para Normal%'
AND date(pato.modified) BETWEEN '2022-04-01' AND '2022-04-30'

ORDER BY pat.id, pato.modified desc