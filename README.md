# Monitor Sindical ACAD

Sistema de acompanhamento de negociações coletivas e CCTs (Convenções Coletivas de Trabalho) para a ACAD Brasil.

## Arquivos

- `index.html` — painel principal (visualização pública)
- `admin.html` — painel administrativo (edição de dados)

## Banco de dados

Utiliza [Supabase](https://supabase.com). As credenciais ficam no topo do `<script>` em `index.html`.

### Tabelas

| Tabela | Conteúdo |
|--------|----------|
| `negociacoes` | Status e percentual de reajuste por estado/ano |
| `sindicatos` | Cadastro de sindicatos laborais e patronais |
| `pisos` | CCTs com pisos salariais e benefícios por estado/ano |
| `assembleias` | Calendário de assembleias e reuniões |
| `encontros` | Encontros semanais internos da ACAD |
| `resumos_mes` | Links de resumo mensal dos encontros |
| `config` | Configurações da interface (anos ativos, status, textos) |

### Campos de piso (`pisos`)

Salários: `ef_men`, `ef_cmen`, `ef_resp`, `ef_hor`, `ef_chor`, `ef_col`, `adm_44`, `adm_sup`, `adm_dia`, `serv_gerais`

Benefícios: `cesta`, `vr_8h`, `vr_7h`, `vr_6h`, `vr_4h`, `anuenio`, `vale_transporte`, `adic_noturno`, `quebra_caixa`, `bsf`, `outros`

Contribuições: `cont_assist`, `cont_patronal`, `cont_laboral`

## Funcionalidades

- **Mapa Sindical** — visão geral por estado com sindicatos e assembleias do ano
- **CCTs e pisos** — detalhes de cada CCT por grupo de sindicato, com pisos salariais e benefícios (toggle, abre só se tiver dados)
- **Calendário** — assembleias e reuniões por mês
- **Histórico** — comparativo de reajustes entre anos
- **Sindicatos** — cadastro completo de sindicatos
- **Encontros ACAD** — registro das reuniões semanais internas

## Navegação

Todos os estados aparecem em **ordem alfabética**. A região é apenas um filtro (não agrupa por cabeçalho).

Para SP há dois grupos de CCT distintos:
- SINDESPORTE (laboral) + SEEAATE-SP (patronal) — cobre todas as funções
- SINPEFE-SP (laboral) + SEEAATE-SP (patronal) — cobre Educação Física
