-- Limpa qualquer registro FENAC existente e reinsere o correto
DELETE FROM assembleias WHERE sindicato_nome = 'FENAC';

INSERT INTO assembleias
  (uf, estado, data_iso, hora, tipo, modalidade,
   sindicato_id, sindicato_nome, sindicato_tipo,
   endereco, link_meet, link_edital, link_pauta, link_ata,
   neg_pct, resumo, obs, viagem)
VALUES
  ('TODOS', 'Todos os estados', '2026-03-25', '15:30', 'Assembleia', 'remota',
   (select id from sindicatos where cnpj='37.138.096/0001-69' limit 1), 'FENAC', 'patronal',
   null, null, null, null, null,
   null, null, null, false);

-- Confirma inserção
SELECT uf, estado, data_iso, sindicato_nome FROM assembleias WHERE sindicato_nome = 'FENAC';
