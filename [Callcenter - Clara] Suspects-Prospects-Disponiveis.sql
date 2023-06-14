SELECT
p.name AS cliente,
p.city AS cidade,
p.neighborhood AS bairro,
p.street AS edenreco,
p.cell_phone_1 AS celular,
p.phone AS telefone,
pci.created AS data_cadastro

FROM people_crm_informations AS pci
INNER JOIN people AS p ON p.id = pci.person_id

WHERE pci.waiting_list = 0 AND pci.probability_sale != 100 AND p.situation IN (5,7) AND p.deleted = 0

ORDER BY p.name asc