-- =======================================================
-- Mês do acordo (pisos/CCT)
-- Execute no Supabase > SQL Editor (uma vez só)
--
-- Adiciona campo pra registrar em qual mês a CCT foi fechada, usado
-- pra montar o relatório mensal (quais CCTs saíram naquele mês).
-- Valor 1-12 (Janeiro-Dezembro), opcional.
-- =======================================================

ALTER TABLE pisos ADD COLUMN IF NOT EXISTS mes_acordo SMALLINT
  CHECK (mes_acordo IS NULL OR (mes_acordo >= 1 AND mes_acordo <= 12));
