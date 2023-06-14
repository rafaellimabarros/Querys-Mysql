SELECT
c.id AS numero_contrato,
p.name AS cliente,
pa.city AS cidade,
pa.neighborhood AS bairro,
pa.code_city_id AS cod_IBGE,
pa.postal_code AS CEP,
c.created AS data_cadastro,
(SELECT vu.name FROM v_users AS vu WHERE vu.id = c.created_by) AS operador_cadastro

FROM contracts AS c
INNER JOIN people AS p ON p.id = c.client_id
INNER JOIN people_addresses AS pa ON pa.person_id = p.id

WHERE DATE(c.created) BETWEEN '2022-01-01' AND '2022-05-06'	

AND (pa.city = 'Acarape' AND pa.code_city_id != 2300150
OR pa.city = 'aquiraz' AND pa.code_city_id != 2301000
OR pa.city = 'Aracoiaba' AND pa.code_city_id != 2301208
OR pa.city = 'Barreira' AND pa.code_city_id != 2301950
OR pa.city = 'Beberibe' AND pa.code_city_id != 2302206
OR pa.city = 'Cascavel' AND pa.code_city_id != 2303501
OR pa.city = 'Caucaia' AND pa.code_city_id != 2303709
OR pa.city = 'Choro' AND pa.code_city_id != 2303931
OR pa.city = 'Chorozinho' AND pa.code_city_id != 2303956
OR pa.city = 'Eusebio' AND pa.code_city_id != 2304285
OR pa.city = 'Fortaleza' AND pa.code_city_id != 2304400
OR pa.city = 'Guaiuba' AND pa.code_city_id != 2304954
OR pa.city = 'Itaitinga' AND pa.code_city_id != 2306256
OR pa.city = 'Maracanau' AND pa.code_city_id != 2307650
OR pa.city = 'Maranguape' AND pa.code_city_id != 2307700
OR pa.city = 'Pacajus' AND pa.code_city_id != 2309607
OR pa.city = 'Pacatuba' AND pa.code_city_id != 2309706
OR pa.city = 'Pindoretama' AND pa.code_city_id != 2310852
OR pa.city = 'Redenção' AND pa.code_city_id != 2311603
OR pa.city = 'genibau'
OR pa.city LIKE '%diogo%'
OR pa.city LIKE '%barra%'
OR pa.city = 'iguape'
OR pa.city = 'tapera'
OR pa.city = 'caponga'
)

GROUP BY c.id
ORDER BY pa.city asc