SELECT
movi.invoice_note_id, 
ivn.document_number,
movi.desc_operacao,
movi.empresa,
movi.dt_movimentacao,
ivn.observation_invoice_1 AS Obs,
movi.pessoa,
movi.serie,
movi.desc_movimentacao,
movi.sinal,
movi.quantidade,
movi.vlr_item,
movi.unidade,
movi.vlr_total_item,
movi.grupo_item,
movi.nome_item,
movi.serial,
movi.desc_cfop,
movi.desc_operacao,
movi.origem

FROM v_bi_materiais_nf_movimentation AS movi
INNER JOIN invoice_notes AS ivn ON ivn.id = movi.invoice_note_id

WHERE movi.dt_movimentacao BETWEEN '2022-06-01' AND '2022-06-10' AND sinal = 'sa├¡da'
AND ivn.company_place_id IN (1,4) AND ivn.financial_operation_id IN (10,14,15,46,47,49)

