-- Reconciliacao dos dados de CCT/pisos 2025 com a planilha (Google Sheets, aba "2025 ").
-- v3: casamento de existencia agora usa (uf,abrangencia,tipo,sind_lab_id,sind_pat_id)
-- como criterio primario - a v2 ainda achava "linhas novas" que na verdade ja
-- existiam com um rotulo de texto em "grupo" diferente do cadastrado em
-- grupos_sindicais (ex: SC tinha 'sinpro'/'saae'/'sinpronorte' nas linhas de
-- pisos mas os grupos_sindicais correspondentes usam 'principal'), o que ia
-- criar linhas DUPLICADAS pra CCTs que ja existiam. Com essa chave, os 41
-- pares da planilha 100% batem com pisos ja existentes - zero insert novo.
-- Revisar antes de rodar no Supabase SQL Editor.

-- ===== BLOCO 0: pares faltando em grupos_sindicais =====

insert into grupos_sindicais (uf, abrangencia, tipo, grupo, sind_lab_id, sind_pat_id, ativo) values ('SC', 'todas', 'Município', 'saae_gfpolis', 32, 65, true);

-- ===== BLOCO 1: pisos 2025 - correcao de deslocamento, preenchimento de lacunas e backfill de grupo_sindical_id (34 updates) =====
-- 17 linha(s) tinham valores nas colunas erradas (corrigido).

update pisos set assinada=true, publicada_mediador=true, grupo_sindical_id=2 where id=54; -- AC
update pisos set adm_dia=null, serv_gerais='R$  1.519,05', vr_8h='R$  9,00', assinada=true, publicada_mediador=true where id=55; -- AL -- CORRECAO DE DESLOCAMENTO
update pisos set ef_cmen='R$  1.866,00', ef_resp=null, ef_chor=null, adm_dia=null, serv_gerais='R$  1.520,80', vr_8h=null, vr_6h='R$  22,33', assinada=true, publicada_mediador=true where id=56; -- AM -- CORRECAO DE DESLOCAMENTO
update pisos set vr_8h='R$  10,53', assinada=true, grupo_sindical_id=9 where id=57; -- BA
update pisos set adm_dia=null, serv_gerais='R$  1.530,00', cesta='R$  120,00', vr_8h=null, assinada=true, publicada_mediador=true where id=58; -- BA -- CORRECAO DE DESLOCAMENTO
update pisos set vr_8h='R$  15,00', bsf='R$  22,00', assinada=true, publicada_mediador=true where id=60; -- CE
update pisos set adm_dia=null, serv_gerais='R$  1.522,00', vr_8h='R$  24,00', assinada=true, publicada_mediador=true where id=61; -- DF -- CORRECAO DE DESLOCAMENTO
update pisos set bsf='R$  25,00', assinada=true, publicada_mediador=true where id=62; -- ES
update pisos set vr_8h='R$  16,01', assinada=true, publicada_mediador=true where id=63; -- GO
update pisos set adm_dia='R$  73,50', vr_4h='R$ 17,00', assinada=true, publicada_mediador=true where id=64; -- GO
update pisos set ef_col='R$  12,74', adm_dia=null, serv_gerais='R$  1.520,20', vr_8h=null, assinada=true, publicada_mediador=true where id=65; -- MA -- CORRECAO DE DESLOCAMENTO
update pisos set cesta='Acima de 110 horas trabalhadas mensalmente ganha um cesta basica com itens descritos no CCT ou o valor de R$219 por mensal. Caso trabalhe menos que 110 horas/mês, ganhará sempre que alcancar o montante de 110h', vr_4h='Oferecerá um lanche composto de no minimo de pao c/manteiga, café e leite ou R$83,93 mensais para jornadas de até 4h ou R$167,86 para jornadas acima de 4h', assinada=true, publicada_mediador=true where id=66; -- MG
update pisos set vr_6h='R$ 19 (arcando o trabalhador com a quantia de  1,00 por mês, importância que será descontada na folha de pagamento.)', quebra_caixa='10%', assinada=true, publicada_mediador=true where id=67; -- MS
update pisos set ef_cmen='R$  1.636,60', ef_resp='R$  2.975,76', ef_chor=null, adm_sup='R$  1.636,60', assinada=true, publicada_mediador=true, grupo_sindical_id=21 where id=68; -- MT -- CORRECAO DE DESLOCAMENTO
update pisos set ef_cmen='R$  1.636,40', ef_resp=null, ef_hor='R$  13,68', ef_chor=null, adm_dia=null, serv_gerais='R$  1.519,05', vr_8h=null, bsf='R$  23,00', assinada=true, publicada_mediador=true where id=71; -- PE -- CORRECAO DE DESLOCAMENTO
update pisos set vr_8h='R$  19,00', assinada=true, publicada_mediador=true, grupo_sindical_id=28 where id=73; -- PR
update pisos set vr_8h='R$  16,14', bsf='R$  7,50', assinada=true, publicada_mediador=true where id=74; -- PR
update pisos set grupo_sindical_id=29 where id=75; -- PR
update pisos set assinada=true, publicada_mediador=true where id=76; -- PR
update pisos set assinada=true, publicada_mediador=true, grupo_sindical_id=37 where id=77; -- RJ
update pisos set ef_cmen='R$ 1. 605,00 + 40%', adm_dia=null, serv_gerais='R$  1.540,00', vr_8h=null, bsf='R$  20,00', assinada=true, publicada_mediador=true, grupo_sindical_id=69 where id=78; -- RJ -- CORRECAO DE DESLOCAMENTO
update pisos set ef_cmen='R$ 1.602,30 + 40%', ef_col='R$  12,12', adm_dia=null, serv_gerais='R$  1.538,20', vr_8h=null, quebra_caixa='10%', assinada=true, publicada_mediador=true where id=79; -- RJ -- CORRECAO DE DESLOCAMENTO
update pisos set adm_dia=null, serv_gerais='R$  1.519,05', vr_8h=null, bsf='R$  23,00', assinada=true, publicada_mediador=true where id=80; -- RN -- CORRECAO DE DESLOCAMENTO
update pisos set assinada=true, publicada_mediador=true where id=81; -- RO
update pisos set ef_cmen='R$  3.089,80', ef_resp='R$  3.089,80', ef_hor='R$ 14,02 + 1/6', ef_chor='R$ 14,74 + 1/6', assinada=true, publicada_mediador=true, grupo_sindical_id=45 where id=83; -- RS -- CORRECAO DE DESLOCAMENTO
update pisos set assinada=true, publicada_mediador=true, grupo_sindical_id=43 where id=84; -- RS
update pisos set adm_dia=null, serv_gerais='R$  2.090,58', vr_8h=null, assinada=true, publicada_mediador=true where id=85; -- SC -- CORRECAO DE DESLOCAMENTO
update pisos set adm_dia=null, serv_gerais='R$  2.090,58', vr_8h=null, assinada=true, publicada_mediador=true, grupo_sindical_id=(select id from grupos_sindicais where sind_lab_id=32 and grupo='saae_gfpolis') where id=86; -- SC -- CORRECAO DE DESLOCAMENTO
update pisos set assinada=true, publicada_mediador=true, grupo_sindical_id=71 where id=87; -- SC
update pisos set adm_dia=null, serv_gerais='R$  2.090,58', vr_8h=null, assinada=true, publicada_mediador=true, grupo_sindical_id=73 where id=88; -- SC -- CORRECAO DE DESLOCAMENTO
update pisos set ef_cmen='R$  1.644,56', ef_resp=null, ef_hor='R$  15,23', ef_chor=null, adm_dia=null, serv_gerais='R$  1.519,05', vr_8h='R$  17,00', assinada=true, publicada_mediador=true where id=89; -- SE -- CORRECAO DE DESLOCAMENTO
update pisos set ef_chor='R$  11,82', cesta='R$  111,37', vr_8h='R$  30,83', assinada=true, publicada_mediador=true where id=91; -- SP
update pisos set ef_cmen='R$  1.412,00', ef_resp='R$  1.412,00', ef_chor=null, ef_col='R$ 21,86+1/6', adm_dia=null, serv_gerais='R$  1.412,00', vr_8h=null, quebra_caixa='10%', assinada=true, publicada_mediador=true, grupo_sindical_id=59 where id=92; -- TO -- CORRECAO DE DESLOCAMENTO
update pisos set adm_dia=null, serv_gerais='R$  1.549,24', vr_8h=null, vr_6h='R$  16,00', assinada=true, publicada_mediador=true, grupo_sindical_id=70 where id=93; -- TO -- CORRECAO DE DESLOCAMENTO

-- ===== ATENCAO: 1 linha(s) que o script NAO conseguiu casar com nenhuma linha existente =====
-- AP  x 

-- ===== BLOCO 2: negociacoes 2025 (26 updates, 14 inserts) =====

update negociacoes set status='concluido' where id=62; -- AL
update negociacoes set status='concluido' where id=63; -- AM
update negociacoes set status='concluido' where id=65; -- BA
update negociacoes set status='negociacao' where id=53; -- CE
update negociacoes set status='concluido' where id=66; -- CE
update negociacoes set status='concluido' where id=67; -- DF
update negociacoes set status='concluido' where id=68; -- ES
update negociacoes set status='concluido' where id=69; -- GO
update negociacoes set status='concluido' where id=70; -- GO
update negociacoes set status='concluido' where id=71; -- MA
update negociacoes set status='concluido' where id=72; -- MG
update negociacoes set status='concluido' where id=73; -- MS
update negociacoes set status='negociacao' where id=54; -- PA
update negociacoes set status='negociacao' where id=55; -- PB
update negociacoes set status='concluido' where id=75; -- PE
update negociacoes set status='sem_acordo' where id=56; -- PI
update negociacoes set status='concluido' where id=77; -- PR
update negociacoes set status='concluido' where id=78; -- PR
update negociacoes set status='concluido' where id=81; -- RJ
update negociacoes set status='concluido' where id=52; -- RN
update negociacoes set status='concluido' where id=82; -- RO
update negociacoes set status='negociacao' where id=58; -- RR
update negociacoes set status='concluido' where id=85; -- SC
update negociacoes set status='concluido' where id=89; -- SE
update negociacoes set status='negociacao' where id=60; -- SP
update negociacoes set status='concluido' where id=90; -- SP
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'AC', 'todas', 'Estado', 'principal', 2, 'concluido', '5', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'BA', 'ef', 'Estado', 'Educação Fisica', 9, 'concluido', '5,32', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'MT', 'todas', 'Estado', 'principal', 21, 'concluido', '6', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'PR', 'todas', 'Município', 'curitiba', 28, 'concluido', '5', '1º de setembro');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'PR', 'ef', 'Município', 'noroeste', 29, 'negociacao', null, '1º de março');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'RJ', 'todas', 'Estado', 'principal', 37, 'concluido', '6', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'RJ', 'ef', 'Município', 'principal', 69, 'concluido', '6,5', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'RS', 'adm', 'Estado', 'principal', 45, 'concluido', '5,5', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'RS', 'todas', 'Estado', 'principal', 43, 'concluido', '5,5', '1º de abril');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'SC', 'todas', 'Município', 'saae_gfpolis', (select id from grupos_sindicais where sind_lab_id=32 and grupo='saae_gfpolis'), 'concluido', '6,7', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'SC', 'todas', 'Município', 'principal', 71, 'concluido', '6,7', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'SC', 'adm', 'Estado', 'principal', 73, 'concluido', '6,7', '1º de maio');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'TO', 'todas', 'Estado', 'principal', 59, 'concluido', '5', '1º de agosto');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual, data_base) values (2025, 'TO', 'ef', 'Estado', 'principal', 70, 'concluido', '5', '1º de março');
