-- Correcao pontual: 2 pares tinham percentual/piso preenchido na planilha
-- 2023/2024 mas a celula "Mediador" (usada pra decidir se a linha tinha CCT)
-- estava em branco, entao a importacao original (fix_pisos_2023_2024.sql)
-- pulou essas 2 linhas por engano. Achado ao investigar "sumiu a CCT do
-- Amazonas" - conferido que nao ha conflito com nenhuma linha ja existente.

-- Amazonas 2023 (SECRAS-AM x FENAC) - reajuste 6%
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2023, 'AM', 3, 42, 'todas', 'Estado', 'principal', 5, '6', 'R$  1.622,72', 'R$  1.622,72', 'R$  22,95', null, null, null, true, true);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2023, 'AM', 'todas', 'Estado', 'principal', 5, 'concluido', '6');

-- Rio de Janeiro 2024 (SINDECLUBES-RJ x SINDACAD, Administrativo/Município) - reajuste 4%
insert into pisos (ano, uf, sind_lab_id, sind_pat_id, abrangencia, tipo, grupo, grupo_sindical_id, pct, ef_men, ef_cmen, ef_hor, adm_44, adm_sup, adm_dia, assinada, publicada_mediador) values (2024, 'RJ', 25, 59, 'adm', 'Município', 'sindacad', 36, '4', null, null, null, 'R$  2.498,40', null, 'R$  11,35', true, true);
insert into negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status, percentual) values (2024, 'RJ', 'adm', 'Município', 'sindacad', 36, 'concluido', '4');
