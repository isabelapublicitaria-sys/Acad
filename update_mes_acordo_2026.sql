-- =======================================================
-- Preenche mês do acordo (2026) — backfill retroativo
-- Execute no Supabase > SQL Editor (uma vez só)
--
-- Requer add_mes_acordo.sql já executado (confirmado).
-- Bahia foi deixada de fora (nenhum dos 2 pares está concluído
-- ainda). Cada UPDATE tem comentário com o par/estado pra conferência.
-- =======================================================

-- ABRIL
UPDATE pisos SET mes_acordo = 4 WHERE id = 45;  -- PE
UPDATE pisos SET mes_acordo = 4 WHERE id = 47;  -- RN
UPDATE pisos SET mes_acordo = 4 WHERE id = 44;  -- GO (Administrativo — SENALBA-GO)
UPDATE pisos SET mes_acordo = 4 WHERE id = 96;  -- DF
UPDATE pisos SET mes_acordo = 4 WHERE id = 51;  -- SP (SINDESPORTE — todas)

-- MAIO
UPDATE pisos SET mes_acordo = 5 WHERE id = 41;  -- AL
UPDATE pisos SET mes_acordo = 5 WHERE id = 126; -- RS (Educ. Física — SINPEF-RS)
UPDATE pisos SET mes_acordo = 5 WHERE id = 127; -- RS (Administrativo — FESENALBA)
UPDATE pisos SET mes_acordo = 5 WHERE id = 121; -- RJ (Município EF — SINDECLUBES-RJ)
UPDATE pisos SET mes_acordo = 5 WHERE id = 50;  -- SP (SINPEFE — Educ. Física)

-- JUNHO
UPDATE pisos SET mes_acordo = 6 WHERE id = 137; -- AC
UPDATE pisos SET mes_acordo = 6 WHERE id = 98;  -- AM
UPDATE pisos SET mes_acordo = 6 WHERE id = 109; -- MG
UPDATE pisos SET mes_acordo = 6 WHERE id = 110; -- MS
UPDATE pisos SET mes_acordo = 6 WHERE id = 117; -- PR (Principal EF — SINPEFEPAR)
UPDATE pisos SET mes_acordo = 6 WHERE id = 48;  -- RO
UPDATE pisos SET mes_acordo = 6 WHERE id = 128; -- SC (Principal EF — SINPRONORTE)
UPDATE pisos SET mes_acordo = 6 WHERE id = 129; -- SC (Principal Município — SAAE GFPOLIS)
UPDATE pisos SET mes_acordo = 6 WHERE id = 135; -- TO (Educ. Física — já marcado concluído)
