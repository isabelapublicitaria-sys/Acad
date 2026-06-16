# CLAUDE.md

Contexto para o Claude Code neste projeto. Ver também `README.md` (lista de
tabelas e campos do Supabase).

## O que é

Monitor Sindical ACAD — acompanhamento de negociações coletivas e CCTs
(Convenções Coletivas de Trabalho) da ACAD Brasil. Site estático, **sem
build/bundler**: dois arquivos HTML com JS inline em `<script type="module">`.

- `index.html` — painel público (visualização, sem login)
- `admin.html` — painel administrativo (login via Supabase Auth, CRUD)
- Backend: Supabase (Postgres + Auth), cliente importado por CDN.
- **A branch `main` é a produção.** Não há pipeline de build — o que está em
  `main` é literalmente o que está no ar.

## Modelo de domínio (não é óbvio lendo só o código)

- Cada **estado** tem de 1 a 4 **pares de sindicato** (laboral × patronal).
  Ex: Santa Catarina tem 4 pares: SINPRONORTE×SIACADESC (estado),
  SAAE GFPOLIS×SIACADESC, SINPABRE SC×SIACADESC, SINPRO FPOLIS×SIACADESC
  (esses 3 últimos municipais).
- Cada par = uma linha em `pisos` (a "CCT"), historicamente chaveada por
  `(ano, uf, abrangencia, tipo, grupo)`. `grupo` é texto livre (default
  `'principal'`), só varia quando 2+ CCTs do mesmo estado compartilham
  `abrangencia`+`tipo` (casos conhecidos: SC, PR, RJ — ver
  `vincular_pares_cct.sql` pros nomes de grupo usados).
- **`grupos_sindicais` (2026-06, `fix_grupo_sindical.sql`) é a entidade
  central** que liga tudo: representa a DUPLA laboral×patronal em si,
  **sem `ano`** (o par é estável ano a ano; CCT e negociação são as
  atividades anuais em cima dele). `pisos.grupo_sindical_id` e
  `negociacoes.grupo_sindical_id` são FK pra ela. Antes disso, CCT e
  Negociação só se achavam casando por texto
  `(uf, abrangencia/funcao, tipo, grupo)` — frágil, e foi o que causou o
  bug relatado no Rio de Janeiro (CCT existia, negociação não achava o
  par porque os dois lados não eram sincronizados automaticamente).
- **Fluxo real (importante pro modelo mental)**: sindicato faz assembleia
  (individual, 99% das vezes) → a DUPLA entra em negociação (conjunta) →
  da negociação sai a CCT (assinada e/ou publicada no Mediador). Ou seja,
  a Negociação pode — e costuma — existir ANTES de qualquer CCT. É por
  isso que o seletor de par na aba Negociações lista `grupos_sindicais`
  direto (sem filtrar por ano/CCT existente).
- **Como o vínculo é mantido automaticamente** (ver admin.html):
  - `getOrCreateGrupoSindical(...)` — acha ou cria o grupo sindical pra
    uma combinação uf+abrangencia+tipo+grupo. Chamado ao salvar CCT
    (`saveCCT`) e ao salvar par em "Grupos de sindicatos" (`saveGrupo`).
  - `ensureNegociacaoParaGrupo(...)` — garante que existe uma negociação
    pra aquele grupo sindical naquele ano (sem sobrescrever status já
    existente). Chamado depois de `getOrCreateGrupoSindical` nos mesmos
    dois fluxos. **Toda vez que se cria/edita uma CCT ou um par, a
    negociação correspondente é garantida automaticamente** — não deve
    nunca mais "se perder" como aconteceu no RJ.
  - A aba "Negociações" guarda o `grupo_sindical_id` escolhido em
    `nf-grupo-sindical-id` (hidden) e usa ele como chave de
    upsert/leitura quando há um par vinculado.
- **Regra ao cruzar `pisos` × `negociacoes` no Mapa**: casar primeiro por
  `grupo_sindical_id` (FK, bulletproof); só cair pro casamento por texto
  `(funcao/abrangencia, tipo, grupo)` como fallback pra linhas antigas
  sem essa FK populada ainda. Padrão usado hoje (admin.html e
  index.html, função `renderAdmMapa`/`renderMapa`/`renderCCTs`):
  ```js
  (cct.grupo_sindical_id && negs.find(n=>n.grupo_sindical_id===cct.grupo_sindical_id))
    ||negs.find(n=>n.funcao===cct.abrangencia&&n.tipo===cct.tipo&&(n.grupo||'principal')===(cct.grupo||'principal'))
    ||negs.find(n=>n.funcao===cct.abrangencia&&n.tipo===cct.tipo)
    ||negs.find(n=>n.funcao===cct.abrangencia)||{}
  ```
  Nunca casar só por `funcao` sem `tipo`/`grupo`/FK — esse foi o bug
  original (SC), parcialmente mitigado por `grupo` em 2026-06 e resolvido
  de vez pelo `grupo_sindical_id`.
- Assembleias geralmente são por par individual (99% das vezes — confirmado
  pela usuária). Já a negociação pode envolver os sindicatos de um estado em
  conjunto, mas o resultado (a CCT) pode valer só pra 1 par, não pro estado
  todo.
- `negociacoes.status` tem 5 valores: `aguardando`, `negociacao`,
  `sem_acordo`, `concluido`, e `vigente` (novo — CCT plurianual que não
  precisa negociar neste ano; caso de uso: Ceará, que negociou em 2025 e a
  CCT continua válida em 2026).
- `pisos.assinada` e `pisos.publicada_mediador` (booleans, independentes) —
  uma CCT pode estar assinada e nunca ter sido publicada no Mediador (MTE).
- `pisos.link_adi` já cobre o caso "vai saber só um aditivo de reajuste, não
  uma CCT nova" (ex: Bahia 2026) — **não criar campo novo pra isso**, a
  usuária já validou que o link existente é suficiente.
- No Mapa (admin e público), cada card de estado mostra um selo resumo
  "X/Y resolvidas" quando há mais de 1 par, contando `concluido`+`vigente`
  como resolvido.

## Gotcha: tabela `config`

A tabela `config` (chave/valor) pode **sobrescrever totalmente** as opções
mostradas nos dropdowns: `status_negociacao` (lista de status), `anos_ativos`
(anos no seletor), `textos_interface` (textos da UI). Ver `initAdmin()` em
admin.html e `loadAll()` em index.html. Se adicionar um novo valor de status
no código, é preciso *também* atualizar a linha correspondente em `config`
no Supabase (via SQL) — senão o option novo nunca aparece pro usuário,
mesmo estando no HTML.

## Gotcha: listas de estado duplicadas

`admin.html` tem **duas** listas de estados que precisam ficar em sincronia
manualmente: `ESTADOS` (uf+nome, usada nos selects de formulário) e
`ESTADOS_ADM` (uf+nome+região, usada no Mapa). `index.html` tem sua própria
`ESTADOS` (com região). Se adicionar/renomear um estado, atualizar todas.

## Migrações SQL

Não há ORM nem migration tool — cada alteração de schema é um `.sql` solto
na raiz que a usuária roda manualmente no Supabase SQL Editor, e avisa
quando rodou. Arquivos:

- `fix_negociacoes_por_par.sql` — grupo em negociacoes, unique constraint,
  registros faltantes por par, correção pontual de SC, colunas
  `assinada`/`publicada_mediador` em pisos, status `vigente`. **Já
  executado em produção em 2026-06-16.**
- `fix_grupo_sindical.sql` — cria `grupos_sindicais`, popula a partir de
  `pisos`/`negociacoes` existentes, adiciona FK `grupo_sindical_id` nos
  dois, backfill, e garante negociação pra toda CCT sem par
  correspondente (resolve o caso relatado do RJ). **Já executado em
  produção em 2026-06-16.**
- `vincular_pares_cct.sql` — popula os pares laboral/patronal por estado em
  `pisos` para 2026 (referência dos nomes de `grupo` usados por estado).
- `insert_assembleias.sql`, `insert_fenac_assembleia.sql` — dados de
  assembleias.

## Convenções de trabalho neste projeto

- Editar os HTML diretamente; não há transpilação. Depois de editar,
  validar sintaxe do JS com `node --check` (extrair o conteúdo do
  `<script type="module">` pra um `.mjs` temporário, porque tem `import`
  no topo).
- Funções chamadas via `onclick="..."` inline precisam ser expostas em
  `window.nomeDaFuncao = ...`.
- Badges de status usam classes CSS já existentes: `b-ok`, `b-warn`,
  `b-red`, `b-neg`, `b-teal`, `b-orange`, `b-purple`, `b-gray`.
- Git: histórico do projeto é só commits diretos na `main` (repo pessoal,
  sem revisão por PR). Seguir a regra do harness de criar uma branch antes
  de comitar a partir da main; pode fazer fast-forward merge pra main na
  sequência e dar push quando a usuária pedir pra "subir pro GitHub".

## Sobre a usuária

Não é desenvolvedora — descreve o problema/processo de trabalho em
linguagem natural (em português) e espera que as decisões técnicas
(schema, nomes de campo, UX) sejam feitas e implementadas diretamente,
sem precisar aprovar cada detalhe. Prefere consolidar tudo numa migração
SQL só, em vez de várias pequenas. Confirma explicitamente quando já rodou
o SQL no Supabase antes de eu seguir pra próxima etapa que depende dele.
