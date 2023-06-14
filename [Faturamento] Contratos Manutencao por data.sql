SELECT
c.id,
c.description,
c.amount,
c.v_status,
c.final_date,
(SELECT ct.title FROM contract_types AS ct WHERE ct.id = c.contract_type_id) AS tipo_contrto,
c.v_stage,
c.beginning_date

FROM contracts AS c

WHERE c.v_status IN ('Normal','Demonstração', 'Cortesia', 'Suspenso', 'Bloqueio Financeiro', 'Bloqueio Administrativo') AND v_stage = 'Aprovado'
AND c.beginning_date < '2022-06-01'

/* tenho que pegar quem estava com esses status abaixo desse periodo */