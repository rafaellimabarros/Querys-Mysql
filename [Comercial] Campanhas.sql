SELECT DISTINCT 
p.name AS Nome,
(SELECT camp.title FROM crm_campaigns AS camp WHERE crm.crm_campaign_id = camp.id) AS Campanha,
p.created AS Data_Cadastro

FROM people_crm_informations AS crm
INNER JOIN people AS p ON crm.person_id = p.id

WHERE p.created BETWEEN '2021-05-20' AND '2021-06-25' AND crm.crm_campaign_id IN (1,2,3,4,5)
GROUP BY p.id