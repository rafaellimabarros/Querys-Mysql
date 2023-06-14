SELECT
p.name AS Cliente,
p.cell_phone_1 AS Celular,
p.phone AS Telefone

FROM people AS p

WHERE p.city = 'Maranguape'