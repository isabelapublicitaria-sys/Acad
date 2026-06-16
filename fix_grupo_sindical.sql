-- =======================================================
-- GRUPO SINDICAL como entidade central
-- Execute no Supabase > SQL Editor (uma vez só, depois de já ter
-- rodado fix_negociacoes_por_par.sql)
--
-- Problema: `pisos` (CCT) e `negociacoes` só se encontravam casando
-- por texto (uf + abrangência + tipo + grupo). Isso é frágil: se um
-- par é editado/criado de um lado (ex: CCT) sem o outro lado
-- acompanhar (ex: Negociação), eles "se perdem" — foi o caso
-- relatado no Rio de Janeiro.
--
-- Esta migração cria uma tabela `grupos_sindicais` — a DUPLA
-- laboral×patronal, estável ano a ano (o par não muda todo ano, só a
-- CCT e a negociação daquele ano mudam). `pisos` e `negociacoes`
-- passam a referenciar essa tabela por id (`grupo_sindical_id`), em
-- vez de tentar adivinhar por texto.
--
-- A partir de agora (no código já atualizado), toda vez que uma CCT
-- ou um par é cadastrado, a Negociação correspondente é criada
-- automaticamente (e vice-versa não é necessário: a negociação pode
-- existir antes da CCT sair, como no fluxo real: assembleia →
-- negociação → CCT).
-- =======================================================

-- 1) Tabela do par (grupo sindical) — sem `ano`, porque o par em si
--    não muda de um ano pro outro.
CREATE TABLE IF NOT EXISTS grupos_sindicais (
  id BIGSERIAL PRIMARY KEY,
  uf TEXT NOT NULL,
  abrangencia TEXT NOT NULL DEFAULT 'todas',
  tipo TEXT NOT NULL DEFAULT 'Estado',
  grupo TEXT NOT NULL DEFAULT 'principal',
  sind_lab_id BIGINT REFERENCES sindicatos(id),
  sind_pat_id BIGINT REFERENCES sindicatos(id),
  ativo BOOLEAN NOT NULL DEFAULT true,
  criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(uf, abrangencia, tipo, grupo)
);

-- 2) Popular a partir dos pares já existentes em `pisos` (pega o
--    sindicato laboral/patronal do ano mais recente de cada par).
INSERT INTO grupos_sindicais (uf, abrangencia, tipo, grupo, sind_lab_id, sind_pat_id)
SELECT DISTINCT ON (uf, abrangencia, tipo, grupo)
  uf, abrangencia, tipo, grupo, sind_lab_id, sind_pat_id
FROM pisos
ORDER BY uf, abrangencia, tipo, grupo, ano DESC
ON CONFLICT (uf, abrangencia, tipo, grupo) DO NOTHING;

-- Cobre também pares que hoje só existem em `negociacoes` (uma
-- negociação pode ter sido criada manualmente sem CCT ainda).
INSERT INTO grupos_sindicais (uf, abrangencia, tipo, grupo)
SELECT DISTINCT n.uf, n.funcao, n.tipo, n.grupo
FROM negociacoes n
WHERE NOT EXISTS (
  SELECT 1 FROM grupos_sindicais g
  WHERE g.uf=n.uf AND g.abrangencia=n.funcao AND g.tipo=n.tipo AND g.grupo=n.grupo
)
ON CONFLICT (uf, abrangencia, tipo, grupo) DO NOTHING;

-- 3) FK em pisos e negociacoes, com backfill pelo casamento antigo
--    (texto) — depois disso, o vínculo passa a ser pelo id.
ALTER TABLE pisos ADD COLUMN IF NOT EXISTS grupo_sindical_id BIGINT REFERENCES grupos_sindicais(id);
ALTER TABLE negociacoes ADD COLUMN IF NOT EXISTS grupo_sindical_id BIGINT REFERENCES grupos_sindicais(id);

UPDATE pisos p SET grupo_sindical_id = g.id
FROM grupos_sindicais g
WHERE g.uf=p.uf AND g.abrangencia=p.abrangencia AND g.tipo=p.tipo AND g.grupo=p.grupo
  AND p.grupo_sindical_id IS NULL;

UPDATE negociacoes n SET grupo_sindical_id = g.id
FROM grupos_sindicais g
WHERE g.uf=n.uf AND g.abrangencia=n.funcao AND g.tipo=n.tipo AND g.grupo=n.grupo
  AND n.grupo_sindical_id IS NULL;

-- 4) Garante que toda CCT já cadastrada tenha uma negociação
--    correspondente no mesmo ano (resolve o caso do Rio de Janeiro:
--    CCT existia, negociação não tinha sido criada pra aquele par).
INSERT INTO negociacoes (ano, uf, funcao, tipo, grupo, grupo_sindical_id, status)
SELECT p.ano, p.uf, p.abrangencia, p.tipo, p.grupo, p.grupo_sindical_id, 'aguardando'
FROM pisos p
WHERE p.grupo_sindical_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM negociacoes n
    WHERE n.ano = p.ano AND n.grupo_sindical_id = p.grupo_sindical_id
  )
ON CONFLICT (ano, uf, funcao, tipo, grupo) DO NOTHING;

-- 5) Nova chave única pelo id do grupo sindical (mais robusta que a
--    antiga por texto — duas linhas com grupo_sindical_id NULL não
--    conflitam entre si, então linhas sem vínculo continuam
--    funcionando como antes). Idempotente — pode rodar de novo sem
--    erro se a constraint já existir.
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname='pisos_ano_grupo_sindical_key') THEN
    ALTER TABLE pisos ADD CONSTRAINT pisos_ano_grupo_sindical_key UNIQUE (ano, grupo_sindical_id);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname='negociacoes_ano_grupo_sindical_key') THEN
    ALTER TABLE negociacoes ADD CONSTRAINT negociacoes_ano_grupo_sindical_key UNIQUE (ano, grupo_sindical_id);
  END IF;
END $$;
