SELECT 
	pr.id, 
	pr.name, 
	u.name,
	cont.name, 
	(SELECT c.description from companies_places AS c WHERE u.place_id = c.id) AS local
FROM 
	`profiles` AS pr
INNER JOIN 
	profiles_permissions as perm ON pr.id = perm.profile_id
INNER JOIN 
	controllers AS cont ON perm.controller = cont.id
INNER JOIN
	v_users AS u ON pr.id = u.profile_id
WHERE 
	cont.id = 208 
	AND u.active = 1
