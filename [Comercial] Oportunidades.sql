SELECT
p.name AS nome,
p.neighborhood AS bairro,
p.city AS cidade,
p.cell_phone_1 AS celular,
p.phone AS telefone,
p.email AS email,
p.observ AS observacoes_tecnicas

FROM crm_person_oportunities AS cpo
INNER JOIN people AS p ON p.id = cpo.person_id

WHERE cpo.proprietary_id = 80017

GROUP BY cpo.id
ORDER BY p.name asc