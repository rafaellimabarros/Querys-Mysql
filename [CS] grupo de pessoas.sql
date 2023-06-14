SELECT 
p.name AS nome,
ppg.people_group_id AS grupo,
p.email AS email

FROM people AS p
INNER JOIN person_people_groups AS ppg ON ppg.person_id = p.id

WHERE ppg.people_group_id = 10