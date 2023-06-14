SELECT
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
p.observ AS observacoes_tecnicas

FROM people_crm_informations AS pci
INNER JOIN people AS p ON p.id = pci.person_id

WHERE pci.proprietary_id = 80017 AND pci.waiting_list = 1

GROUP BY pci.person_id