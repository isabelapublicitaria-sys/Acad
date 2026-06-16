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
- Cada par = uma linha em `pisos` (a "CCT"), chave
  `(ano, uf, abrangencia, tipo, grupo)`. `grupo` é texto livre (default
  `'principal'`), só varia quando 2+ CCTs do mesmo estado compartilham
  `abrangencia`+`tipo` (casos conhecidos: SC, PR, RJ — ver
  `vincular_pares_cct.sql` pros nomes de grupo usados).
- `negociacoes` (status + percentual de reajuste) usa a **mesma chave**:
  `(ano, uf, funcao, tipo, grupo)` — `funcao` em negociacoes corresponde a
  `abrangencia` em pisos. Isso foi corrigido em 2026-06
  (`fix_negociacoes_por_par.sql`): antes não existia `grupo`, então pares
  diferentes com mesma abrangência/tipo eram OBRIGADOS a compartilhar status
  (bug real relatado pela usuária em SC).
- **Regra ao cruzar `pisos` × `negociacoes`**: sempre casar pelos 3 campos
  (`funcao`/`abrangencia`, `tipo`, `grupo`). Nunca só por `funcao` — esse foi
  o bug antigo, presente em várias funções (`negs.find(...)` em
  `renderAdmMapa` no admin.html, e em duas funções de mapa no index.html).
  Padrão correto usado hoje:
  ```js
  negs.find(n=>n.funcao===cct.abrangencia&&n.tipo===cct.tipo&&(n.grupo||'principal')===(cct.grupo||'principal'))
    ||negs.find(n=>n.funcao===cct.abrangencia&&n.tipo===cct.tipo)
    ||negs.find(n=>n.funcao===cct.abrangencia)||{}
  ```
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
