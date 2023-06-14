SELECT
	u.id,
	u.NAME,
	u.login,
	u.email,
	(SELECT pr.name FROM profiles AS pr WHERE u.profile_id = pr.id) AS PROFILE,
	u.active
FROM
	v_users AS u
