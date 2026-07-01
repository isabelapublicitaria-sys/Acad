-- Corrige falha de segurança encontrada em 2026-07-01: a tabela
-- grupos_sindicais aceitava INSERT/UPDATE/DELETE da chave anon (pública,
-- embutida no código do site) sem exigir login. Todas as outras tabelas
-- (pisos, sindicatos, negociacoes, assembleias, config, encontros,
-- resumos_mes) já bloqueavam escrita anônima corretamente — só esta
-- ficou sem RLS configurado desde que foi criada (fix_grupo_sindical.sql).
--
-- Efeito: leitura pública continua igual (o Mapa e a tela pública
-- continuam funcionando sem login); escrita passa a exigir usuário
-- autenticado (login do admin.html), igual às demais tabelas.

alter table grupos_sindicais enable row level security;

drop policy if exists "grupos_sindicais_select_public" on grupos_sindicais;
create policy "grupos_sindicais_select_public"
  on grupos_sindicais for select
  to anon, authenticated
  using (true);

drop policy if exists "grupos_sindicais_write_authenticated" on grupos_sindicais;
create policy "grupos_sindicais_write_authenticated"
  on grupos_sindicais for all
  to authenticated
  using (true)
  with check (true);

revoke insert, update, delete on grupos_sindicais from anon;
