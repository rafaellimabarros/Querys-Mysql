SELECT
vu.name AS nome,
prof.name AS perfil

FROM v_users AS vu
INNER JOIN `profiles` AS prof ON prof.id = vu.profile_id

WHERE vu.active = 1 AND vu.deleted = 0