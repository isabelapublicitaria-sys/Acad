-- =======================================================
-- VINCULAÇÃO DE PARES DE SINDICATOS NAS CCTs DE 2026
-- Execute no Supabase > SQL Editor
--
-- Lógica:
--   • Estados com 1 par  → abrangencia='todas', grupo='principal'
--   • Estados com 2 pares (SINPEF + SENALBA) → ef + adm
--   • PR/SC/RJ com pares municipais → grupos nomeados
--
-- ON CONFLICT atualiza SOMENTE os vínculos de sindicato,
-- sem sobrescrever percentuais ou pisos já cadastrados.
-- =======================================================

INSERT INTO pisos (ano, uf, abrangencia, tipo, grupo, sind_lab_id, sind_pat_id)
VALUES

-- ── AL ─────────────────────────────────────────────────
(2026,'AL','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='10.884.443/0001-46' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── AM ─────────────────────────────────────────────────
(2026,'AM','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='34.593.491/0001-43' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── AP ─────────────────────────────────────────────────
(2026,'AP','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='05.359.823/0001-21' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── BA ─────────────────────────────────────────────────
-- Par EF: SINPEF-BA x SINDELIVRE-BA
(2026,'BA','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='07.792.110/0001-82' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='07.158.719/0001-02' LIMIT 1)),
-- Par ADM: SENALBA-BA x SINDELIVRE-BA
(2026,'BA','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='15.235.021/0001-63' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='07.158.719/0001-02' LIMIT 1)),

-- ── CE ─────────────────────────────────────────────────
-- Par EF: SINPEF-CE x SINDFIT-CE
(2026,'CE','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='18.780.240/0001-11' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='05.895.681/0001-17' LIMIT 1)),
-- Par ADM: SENALBA-CE x SINDFIT-CE
(2026,'CE','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='07.386.824/0001-90' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='05.895.681/0001-17' LIMIT 1)),

-- ── DF ─────────────────────────────────────────────────
(2026,'DF','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='00.395.419/0001-90' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='14.180.212/0001-02' LIMIT 1)),

-- ── ES ─────────────────────────────────────────────────
(2026,'ES','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='28.500.205/0001-55' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='04.589.764/0001-15' LIMIT 1)),

-- ── GO ─────────────────────────────────────────────────
-- Par EF: SINPEF-GO x SINDAC-GO
(2026,'GO','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='11.507.882/0001-00' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='14.167.460/0001-13' LIMIT 1)),
-- Par ADM: SENALBA-GO x SINDAC-GO
(2026,'GO','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='02.898.179/0001-71' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='14.167.460/0001-13' LIMIT 1)),

-- ── MA ─────────────────────────────────────────────────
(2026,'MA','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='69.575.637/0001-02' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── MG ─────────────────────────────────────────────────
(2026,'MG','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='00.786.960/0001-29' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='73.691.206/0001-89' LIMIT 1)),

-- ── MS ─────────────────────────────────────────────────
(2026,'MS','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='01.534.858/0001-07' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.177.458/0001-20' LIMIT 1)),

-- ── MT ─────────────────────────────────────────────────
(2026,'MT','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='07.752.434/0001-97' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='02.748.755/0001-02' LIMIT 1)),

-- ── PA ─────────────────────────────────────────────────
(2026,'PA','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='05.359.823/0001-21' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── PB ─────────────────────────────────────────────────
(2026,'PB','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='09.252.040/0001-03' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='06.938.758/0001-51' LIMIT 1)),

-- ── PE ─────────────────────────────────────────────────
(2026,'PE','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='09.056.763/0001-29' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── PI ─────────────────────────────────────────────────
(2026,'PI','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='04.957.606/0001-70' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── PR ─────────────────────────────────────────────────
-- SINACADN-PR x SENALBA LONDRINA
(2026,'PR','adm','Estado','londrina',
 (SELECT id FROM sindicatos WHERE cnpj='19.972.582/0001-04' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='03.045.493/0001-74' LIMIT 1)),
-- SINPEFEPAR x SINDICLUBES (Estado)
(2026,'PR','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='07.276.365/0001-92' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='02.740.267/0001-40' LIMIT 1)),
-- SENALBA Curitiba x SINDICLUBES (Município)
(2026,'PR','adm','Município','curitiba',
 (SELECT id FROM sindicatos WHERE cnpj='75.992.466/0001-49' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='02.740.267/0001-40' LIMIT 1)),
-- SINPEFEPAR x SINACAD NOROESTE
(2026,'PR','ef','Estado','noroeste',
 (SELECT id FROM sindicatos WHERE cnpj='07.276.365/0001-92' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='07.122.938/0001-23' LIMIT 1)),

-- ── RJ ─────────────────────────────────────────────────
-- SINPEF-RJ x SINDACAD (Todas as funções, Estado)
(2026,'RJ','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='03.389.506/0001-22' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='07.546.139/0001-84' LIMIT 1)),
-- SINDECLUBES-RJ x SECFETAARJ (Educ. Física, Município)
(2026,'RJ','ef','Município','principal',
 (SELECT id FROM sindicatos WHERE cnpj='33.966.441/0001-00' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='40.163.529/0001-40' LIMIT 1)),
-- SINDECLUBES-RJ x SINDACAD (Administrativo, Município)
(2026,'RJ','adm','Município','principal',
 (SELECT id FROM sindicatos WHERE cnpj='33.966.441/0001-00' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='07.546.139/0001-84' LIMIT 1)),

-- ── RN ─────────────────────────────────────────────────
(2026,'RN','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='09.428.194/0001-03' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── RO ─────────────────────────────────────────────────
(2026,'RO','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='34.449.892/0001-24' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── RR ─────────────────────────────────────────────────
(2026,'RR','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='34.449.892/0001-24' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── RS ─────────────────────────────────────────────────
-- Par EF: SINPEF-RS x SECRASO-RS
(2026,'RS','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='10.949.209/0001-50' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='93.013.670/0001-23' LIMIT 1)),
-- Par ADM: FESENALBA x SECRASO-RS
(2026,'RS','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='05.208.719/0001-36' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='93.013.670/0001-23' LIMIT 1)),

-- ── SC ─────────────────────────────────────────────────
-- SINPRONORTE x SIACADESC (Estado - Norte)
(2026,'SC','ef','Estado','norte',
 (SELECT id FROM sindicatos WHERE cnpj='95.954.400/0001-42' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='08.394.516/0001-70' LIMIT 1)),
-- SAAE GFPOLIS x SIACADESC (Florianópolis)
(2026,'SC','todas','Município','florianopolis-saae',
 (SELECT id FROM sindicatos WHERE cnpj='79.255.808/0001-70' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='08.394.516/0001-70' LIMIT 1)),
-- SINPABRE SC x SIACADESC (Blumenau)
(2026,'SC','todas','Município','blumenau',
 (SELECT id FROM sindicatos WHERE cnpj='72.498.892/0001-03' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='08.394.516/0001-70' LIMIT 1)),
-- SINPRO FPOLIS x SIACADESC (Florianópolis)
(2026,'SC','ef','Município','florianopolis-sinpro',
 (SELECT id FROM sindicatos WHERE cnpj='00.056.863/0001-80' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='08.394.516/0001-70' LIMIT 1)),

-- ── SE ─────────────────────────────────────────────────
(2026,'SE','todas','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='32.742.645/0001-96' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1)),

-- ── SP ─────────────────────────────────────────────────
-- Par EF: SINPEFESP x SEEAATESP
(2026,'SP','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='05.376.877/0001-03' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='61.398.905/0001-56' LIMIT 1)),
-- Par ADM: SINDESPORTE x SEEAATESP
(2026,'SP','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='62.654.496/0001-74' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='61.398.905/0001-56' LIMIT 1)),

-- ── TO ─────────────────────────────────────────────────
-- Par EF: SINPEF-TO x SINDILIVRETO
(2026,'TO','ef','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='12.479.264/0001-59' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='26.016.680/0001-25' LIMIT 1)),
-- Par ADM: SENALBA-TO x FENAC
(2026,'TO','adm','Estado','principal',
 (SELECT id FROM sindicatos WHERE cnpj='00.925.880/0001-07' LIMIT 1),
 (SELECT id FROM sindicatos WHERE cnpj='37.138.096/0001-69' LIMIT 1))

ON CONFLICT (ano, uf, abrangencia, tipo, grupo)
DO UPDATE SET
  sind_lab_id = EXCLUDED.sind_lab_id,
  sind_pat_id = EXCLUDED.sind_pat_id;
