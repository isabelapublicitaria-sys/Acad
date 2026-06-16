-- =======================================================
-- CORREÇÃO: status de negociação independente por PAR de sindicato
-- Execute no Supabase > SQL Editor (uma vez só)
--
-- Problema: a tabela `negociacoes` era identificada só por
-- (ano, uf, funcao, tipo) — sem o `grupo` que a `pisos` (CCT) já tem.
-- Por isso, quando um estado tem 2 CCTs com a mesma Abrangência e
-- Tipo (ex: SC, com SAAE GFPOLIS e SINPABRE SC, ambos
-- "Todas as funções"/"Município"), eles ficavam OBRIGADOS a
-- compartilhar o mesmo status — sem chance de cadastrar 2 registros
-- separados.
--
-- Esta migração:
--   1) adiciona a coluna `grupo` em `negociacoes`;
--   2) tenta casar o grupo de cada negociação já existente com a
--      CCT correspondente em `pisos`;
--   3) troca a constraint de unicidade para incluir `grupo`;
--   4) cria os registros de negociação que faltavam para CCTs que
--      antes não podiam ter um status próprio (ex: SINPABRE SC);
--   5) corrige especificamente o caso relatado de SC: o registro
--      "Todas as funções / Município" já existente pertencia, na
--      prática, à dupla SAAE GFPOLIS × SIACADESC (Florianópolis) —
--      não à SINPABRE SC × SIACADESC (Blumenau).
-- =======================================================

-- 1) Nova coluna
ALTER TABLE negociacoes ADD COLUMN IF NOT EXISTS grupo TEXT NOT NULL DEFAULT 'principal';

-- 2) Backfill: casa cada negociação existente com a CCT de mesmo
--    ano/uf/abrangência/tipo. Quando há mais de uma CCT com a mesma
--    combinação (ex: SC, PR, RJ), pega a primeira em ordem alfabética
--    — o passo 4 garante que as demais ganhem um registro próprio.
UPDATE negociacoes n
SET grupo = sub.grupo
FROM (
  SELECT ano, uf, abrangencia AS funcao, tipo,
         (array_agg(grupo ORDER BY grupo))[1] AS grupo
  FROM pisos
  GROUP BY ano, uf, abrangencia, tipo
) sub
WHERE sub.ano = n.ano AND sub.uf = n.uf AND sub.funcao = n.funcao AND sub.tipo = n.tipo;

-- 3) Troca a constraint de unicidade (ano,uf,funcao,tipo) por
--    (ano,uf,funcao,tipo,grupo), sem precisar saber o nome exato
--    da constraint atual.
DO $$
DECLARE
  cname text;
BEGIN
  SELECT con.conname INTO cname
  FROM pg_constraint con
  JOIN pg_class rel ON rel.oid = con.conrelid
  WHERE rel.relname = 'negociacoes' AND con.contype = 'u'
    AND pg_get_constraintdef(con.oid) NOT ILIKE '%grupo%';
  IF cname IS NOT NULL THEN
    EXECUTE format('ALTER TABLE negociacoes DROP CONSTRAINT %I', cname);
  END IF;
END $$;

ALTER TABLE negociacoes
  ADD CONSTRAINT negociacoes_ano_uf_funcao_tipo_grupo_key UNIQUE (ano, uf, funcao, tipo, grupo);

-- 4) Cria a negociação que falta para toda CCT que ainda não tem um
--    registro próprio (status inicial: "Aguardando data base" —
--    revisar manualmente na tela de Negociações).
INSERT INTO negociacoes (ano, uf, funcao, tipo, grupo, status)
SELECT p.ano, p.uf, p.abrangencia, p.tipo, p.grupo, 'aguardando'
FROM pisos p
WHERE NOT EXISTS (
  SELECT 1 FROM negociacoes n
  WHERE n.ano = p.ano AND n.uf = p.uf AND n.funcao = p.abrangencia
    AND n.tipo = p.tipo AND n.grupo = p.grupo
)
ON CONFLICT (ano, uf, funcao, tipo, grupo) DO NOTHING;

-- 5) Correção pontual relatada para SC 2026:
--    SAAE GFPOLIS x SIACADESC (Florianópolis) = Acordo finalizado
--    SINPABRE SC x SIACADESC (Blumenau)       = ainda NÃO finalizado
--    (revisar e ajustar o status real do par de Blumenau na tela)
UPDATE negociacoes SET status = 'concluido'
WHERE ano = 2026 AND uf = 'SC' AND funcao = 'todas' AND tipo = 'Município' AND grupo = 'florianopolis-saae';

UPDATE negociacoes SET status = 'aguardando'
WHERE ano = 2026 AND uf = 'SC' AND funcao = 'todas' AND tipo = 'Município' AND grupo = 'blumenau';

-- ⚠ Atenção: PR (ef/Estado: "principal" x "noroeste") e RJ
-- (adm/Estado: "secfeta" x "sindacad") têm a mesma ambiguidade que SC
-- tinha. Depois de rodar esta migração, os dois pares de cada um
-- também passam a ter registros de negociação separados — um deles
-- herdou o status que já existia, o outro nasceu como "Aguardando
-- data base". Revise os 2 pares de PR e os 2 de RJ na tela de
-- Negociações para garantir que o status de cada um está correto.

-- =======================================================
-- EXTRA: campos "Assinada" e "Publicada no Mediador" na CCT
-- =======================================================
ALTER TABLE pisos ADD COLUMN IF NOT EXISTS assinada BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE pisos ADD COLUMN IF NOT EXISTS publicada_mediador BOOLEAN NOT NULL DEFAULT false;

-- =======================================================
-- EXTRA: novo status "vigente" (CCT plurianual — não terá
-- negociação neste ano, ex: Ceará, que já negociou em 2025 e a CCT
-- continua válida em 2026)
-- =======================================================

-- Remove eventual CHECK constraint antigo da coluna `status` que
-- ainda não inclua o valor "vigente" (se não existir nenhum, não faz
-- nada — os valores de status hoje são controlados pela tela, não
-- por constraint).
DO $$
DECLARE
  cname text;
BEGIN
  SELECT con.conname INTO cname
  FROM pg_constraint con
  JOIN pg_class rel ON rel.oid = con.conrelid
  WHERE rel.relname = 'negociacoes' AND con.contype = 'c'
    AND pg_get_constraintdef(con.oid) ILIKE '%status%'
    AND pg_get_constraintdef(con.oid) NOT ILIKE '%vigente%';
  IF cname IS NOT NULL THEN
    EXECUTE format('ALTER TABLE negociacoes DROP CONSTRAINT %I', cname);
  END IF;
END $$;

-- Acrescenta a opção "vigente" na lista de status configurada em
-- `config` (chave 'status_negociacao'), se essa linha existir — é o
-- que alimenta o seletor de status na tela de Negociações e o filtro
-- do Mapa público. Se a linha não existir, os valores padrão do
-- próprio admin.html/index.html já incluem essa opção.
UPDATE config c
SET valor = c.valor || jsonb_build_array(
  jsonb_build_object('valor','vigente','label','CCT vigente (sem negociação)','badge','b-teal')
)
WHERE c.chave = 'status_negociacao'
  AND NOT EXISTS (
    SELECT 1 FROM jsonb_array_elements(c.valor) e WHERE e->>'valor' = 'vigente'
  );
