SELECT
p.id AS cod_cliente,
p.name AS cliente,
date(pcii.created) AS data_descarte,
(SELECT cdm.title FROM crm_discart_motives AS cdm WHERE cdm.id = pcii.crm_discart_motive_id) AS motivo_descarte,
pcii.description AS descricao,
(SELECT p.name FROM people AS p WHERE p.id = pcii.responsible_id) AS reponsavel_descarte,
DATE(p.created) AS data_cadastro,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS endereco

FROM people_crm_information_interactions AS pcii
INNER JOIN people AS p on p.id = pcii.client_id

WHERE pcii.crm_discart_motive_id IS NOT NULL AND DATE(pcii.created) BETWEEN '2021-01-01' AND '2022-07-13'
AND pcii.situation NOT IN  (3,4)

ORDER BY pcii.created desc