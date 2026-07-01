-- Importacao de CCT/pisos e negociacoes para 2023 e 2024 (aba "2024/2023" do
-- Google Sheets). Ambos os anos estavam totalmente vazios no banco (0 linhas
-- em pisos e negociacoes), entao tudo aqui e INSERT novo - sem risco de
-- duplicar ou sobrescrever dado existente.
--
-- "Mediador" na planilha = CCT publicada -> assinada=true, publicada_mediador=true,
-- negociacao concluida. "Nao encontrada" = negociacao aconteceu mas CCT nao foi
-- localizada/publicada -> so cria a negociacao (status sem_acordo), sem linha de pisos.
--
-- Piso salarial: a planilha tem so 3 colunas genericas (nao separa mensalista/
-- horista como o cadastro atual). Mapeadas conforme a Abrangencia de cada par:
--   Educ. Fisica/Todas -> ef_men, ef_cmen, ef_hor
--   Administrativo      -> adm_44, adm_sup, adm_dia
--
-- Revisar antes de rodar no Supabase SQL Editor.

-- ===== 2024 (19 de 22 pares com CCT encontrada) =====

insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'AL', 2, 41, 'todas', 'Estado', 'principal', 3, '4', 'R$  1.422,70', 'R$  1.433,70', 'R$  12,90', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'AM', 3, 42, 'todas', 'Estado', 'principal', 5, '3,5', 'R$  1.735,32', 'R$  1.735,32', 'R$  16,00', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'BA', 6, 43, 'adm', 'Estado', 'principal', 8, '4', null, null, null, 'R$  1.425,00', 'R$  1.425,00', 'R$  12,07', true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'ES', 10, 46, 'todas', 'Estado', 'principal', 15, '3,23', 'R$  1.412,00', 'R$  1.412,00', 'R$  13,86', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'GO', 11, 47, 'ef', 'Estado', 'principal', 17, '5', 'R$  2.249,83', 'R$  2.249,83', 'R$  13,45', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'GO', 12, 47, 'adm', 'Estado', 'principal', 16, '5', null, null, null, 'R$  1.485,00', null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'MA', 13, 48, 'todas', 'Estado', 'principal', 18, '4', 'R$  1.414,00', 'R$  1.632,68', 'R$  12,13', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'MG', 14, 49, 'todas', 'Estado', 'principal', 19, '4,50', 'R$  1.450,00', null, 'R$  6,59', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'MT', 16, 51, 'ef', 'Estado', 'principal', 21, '4', 'R$  1.543,96', 'R$  1.543,96', 'R$  13,12', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'PE', 19, 54, 'todas', 'Estado', 'principal', 25, '5', 'R$  1.460,00', null, 'R$  14,24', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'PI', 20, 55, 'todas', 'Estado', 'principal', 26, '4', 'R$  1.419,49', 'R$  1.719,11', 'R$  11,63', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'PR', 23, 57, 'adm', 'Município', 'curitiba', 28, '4', null, null, null, 'R$  1.804,00', null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'PR', 21, 56, 'todas', 'Município', 'londrina', 33, '5', 'R$  1.650,00', null, null, null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'RJ', 24, 59, 'ef', 'Estado', 'principal', 37, '4', 'R$  1.500,00', 'R$ 1. 500,00  + 40%', 'R$  11,60', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'RN', 26, 61, 'todas', 'Estado', 'principal', 40, '5', 'R$  1.440,00', null, 'R$  12,80', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'RO', 27, 62, 'todas', 'Estado', 'principal', 41, '4', 'R$  1.444,00', null, 'R$  13,00', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'SC', 34, 65, 'todas', 'Município', 'principal', 71, '4', null, 'R$  1.529,82', 'R$  14,50', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'SP', 36, 67, 'ef', 'Estado', 'principal', 55, '4', 'R$  1.489,77', null, 'R$  14,38', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'SP', 37, 67, 'todas', 'Estado', 'principal', 57, '6,23', 'R$  2.018,37', null, null, null, null, null, true, true);

insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'AL', 'todas', 'Estado', 'principal', 3, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'AM', 'todas', 'Estado', 'principal', 5, 'concluido', '3,5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'BA', 'ef', 'Estado', 'Educação Fisica', 9, 'sem_acordo', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'BA', 'adm', 'Estado', 'principal', 8, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'CE', 'adm', 'Estado', 'principal', 11, 'sem_acordo', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'ES', 'todas', 'Estado', 'principal', 15, 'concluido', '3,23');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'GO', 'ef', 'Estado', 'principal', 17, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'GO', 'adm', 'Estado', 'principal', 16, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'MA', 'todas', 'Estado', 'principal', 18, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'MG', 'todas', 'Estado', 'principal', 19, 'concluido', '4,50');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'MS', 'todas', 'Estado', 'principal', 20, 'sem_acordo', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'MT', 'ef', 'Estado', 'principal', 21, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'PE', 'todas', 'Estado', 'principal', 25, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'PI', 'todas', 'Estado', 'principal', 26, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'PR', 'adm', 'Município', 'curitiba', 28, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'PR', 'todas', 'Município', 'londrina', 33, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'RJ', 'ef', 'Estado', 'principal', 37, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'RN', 'todas', 'Estado', 'principal', 40, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'RO', 'todas', 'Estado', 'principal', 41, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'SC', 'todas', 'Município', 'principal', 71, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'SP', 'ef', 'Estado', 'principal', 55, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'SP', 'todas', 'Estado', 'principal', 57, 'concluido', '6,23');

-- ===== 2023 (21 de 23 pares com CCT encontrada) =====

insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'AL', 2, 41, 'todas', 'Estado', 'principal', 3, '3,83', 'R$  1.330,00', 'R$  1.340,00', 'R$  12,50', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'BA', 6, 43, 'adm', 'Estado', 'principal', 8, '4,36', null, null, null, 'R$  1.330,00', 'R$  1.330,00', 'R$  11,61', true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'ES', 10, 46, 'todas', 'Estado', 'principal', 15, '3,5', 'R$  1.320,00', 'R$  1.320,00', 'R$  13,43', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'GO', 11, 47, 'ef', 'Estado', 'principal', 17, '6', 'R$  2.142,70', 'R$  2.142,70', 'R$  12,81', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'GO', 12, 47, 'adm', 'Estado', 'principal', 16, '5,47', null, null, null, 'R$  1.350,00', null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'MA', 13, 48, 'todas', 'Estado', 'principal', 18, '4', 'R$  1.360,00', null, 'R$  12,87', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'MG', 14, 49, 'todas', 'Estado', 'principal', 19, '5.47', 'R$  1.340,00', null, 'R$  6,09', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'MS', 15, 50, 'todas', 'Estado', 'principal', 20, '4', 'R$  1.451,00', null, 'R$  21,00', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'MT', 16, 51, 'ef', 'Estado', 'principal', 21, '5', 'R$  1.484,58', 'R$  1.484,58', 'R$  12,62', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'PB', 18, 53, 'todas', 'Estado', 'principal', 24, null, null, null, null, null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'PE', 19, 54, 'todas', 'Estado', 'principal', 25, '5', 'R$  1.423,05', null, 'R$  12,53', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'PI', 20, 55, 'todas', 'Estado', 'principal', 26, '5', 'R$  1.305,00', 'R$  1.607,10', 'R$  11,18', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'PR', 23, 57, 'adm', 'Município', 'curitiba', 28, '4,74', null, null, null, 'R$  1.729,00', null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'PR', 21, 56, 'todas', 'Município', 'londrina', 33, '5,5', 'R$  1.530,00', null, null, null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'RJ', 24, 59, 'ef', 'Estado', 'principal', 37, '5', 'R$  1.365,00', null, 'R$  11,13', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'RJ', 25, 59, 'adm', 'Município', 'sindacad', 36, '5', null, null, null, 'R$  2.402,31', null, 'R$  10,91', true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'RN', 26, 61, 'todas', 'Estado', 'principal', 40, '5,6', 'R$  1.321,00', null, 'R$  12,33', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'RO', 27, 62, 'todas', 'Estado', 'principal', 41, '5', 'R$  1.350,00', null, 'R$  12,10', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'SC', 34, 65, 'todas', 'Município', 'principal', 71, '5,47', null, 'R$  1.430,14', 'R$  13,93', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'SP', 36, 67, 'ef', 'Estado', 'principal', 55, '3', 'R$  1.418,83', null, 'R$  13,70', null, null, null, true, true);
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'SP', 37, 67, 'todas', 'Estado', 'principal', 57, '15', 'R$  1.750,00', null, null, null, null, null, true, true);

insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'AL', 'todas', 'Estado', 'principal', 3, 'concluido', '3,83');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'BA', 'ef', 'Estado', 'Educação Fisica', 9, 'sem_acordo', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'BA', 'adm', 'Estado', 'principal', 8, 'concluido', '4,36');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'CE', 'adm', 'Estado', 'principal', 11, 'sem_acordo', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'ES', 'todas', 'Estado', 'principal', 15, 'concluido', '3,5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'GO', 'ef', 'Estado', 'principal', 17, 'concluido', '6');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'GO', 'adm', 'Estado', 'principal', 16, 'concluido', '5,47');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'MA', 'todas', 'Estado', 'principal', 18, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'MG', 'todas', 'Estado', 'principal', 19, 'concluido', '5.47');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'MS', 'todas', 'Estado', 'principal', 20, 'concluido', '4');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'MT', 'ef', 'Estado', 'principal', 21, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'PB', 'todas', 'Estado', 'principal', 24, 'concluido', null);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'PE', 'todas', 'Estado', 'principal', 25, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'PI', 'todas', 'Estado', 'principal', 26, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'PR', 'adm', 'Município', 'curitiba', 28, 'concluido', '4,74');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'PR', 'todas', 'Município', 'londrina', 33, 'concluido', '5,5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'RJ', 'ef', 'Estado', 'principal', 37, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'RJ', 'adm', 'Município', 'sindacad', 36, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'RN', 'todas', 'Estado', 'principal', 40, 'concluido', '5,6');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'RO', 'todas', 'Estado', 'principal', 41, 'concluido', '5');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'SC', 'todas', 'Município', 'principal', 71, 'concluido', '5,47');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'SP', 'ef', 'Estado', 'principal', 55, 'concluido', '3');
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'SP', 'todas', 'Estado', 'principal', 57, 'concluido', '15');
