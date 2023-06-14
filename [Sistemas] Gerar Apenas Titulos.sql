SELECT DISTINCT
c.id AS ID_Contrato,
(SELECT p.name FROM people AS p WHERE p.id = c.client_id) AS Nome_Cliente,
c.v_status AS Status_Contrato,
IF( c.generate_only_title = 1, "Sim", "Nao" ) AS Gerar_Apenas_Titulos

FROM contracts AS c
WHERE c.generate_only_title = 1