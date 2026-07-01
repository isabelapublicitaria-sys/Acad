delete from assembleias;

insert into assembleias
  (uf, estado, data_iso, hora, tipo, modalidade, sindicato_id, sindicato_nome, sindicato_tipo,
   endereco, link_meet, link_edital, link_pauta, link_ata, neg_pct, resumo, obs, viagem)
values
('MG','Minas Gerais','2026-01-20','10:30','Reunião de negociação','presencial',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,null,false),

('PE','Pernambuco','2026-01-26','10:30','Assembleia','remota',
 (select id from sindicatos where cnpj='09.056.763/0001-29' limit 1),'SENALBA-PE','laboral',
 null,null,null,null,null,null,null,null,false),

('MG','Minas Gerais','2026-02-24','11:00','Reunião de negociação','presencial',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,null,false),

('SP','São Paulo','2026-02-24','13:30','Assembleia','remota',
 (select id from sindicatos where cnpj='61.398.905/0001-56' limit 1),'SEEAATESP','patronal',
 null,null,null,null,null,null,null,'ID da reunião: 830 6726 7308 / Senha: 704878',false),

('GO','Goiás','2026-02-25','09:00','Assembleia','remota',
 (select id from sindicatos where cnpj='02.898.179/0001-71' limit 1),'SENALBA-GO','laboral',
 null,null,null,null,null,null,null,null,true),

('SP','São Paulo','2026-03-10','14:00','Assembleia','remota',
 (select id from sindicatos where cnpj='61.398.905/0001-56' limit 1),'SEEAATESP','patronal',
 null,null,null,null,null,null,
 'SINPEFESP rejeita proposta. SINDESPORTE rejeita proposta.',
 'ID da reunião: 837 3779 3091 / Senha: 927748',false),

('RS','Rio Grande do Sul','2026-03-12','10:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='05.208.719/0001-36' limit 1),'FESENALBA','laboral',
 'R. Atílio Andreazza, 3355 - Sagrada Familia, Caxias do Sul/RS',
 null,null,null,null,null,null,null,true),

('MG','Minas Gerais','2026-03-18','15:00','Assembleia','remota',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,
 'Primeira chamada 14:30. ID 898 9670 3860 / senha 761423',false),

('MG','Minas Gerais','2026-03-25','11:00','Reforma de estatuto','remota',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,
 'ID 863 6491 2313 / senha 426091',false),

-- FENAC — assembleia única para todos os estados (25/03/2026 15:30)
('TODOS','Todos os estados','2026-03-25','15:30','Assembleia','remota',
 null,'FENAC','patronal',
 null,null,null,null,null,null,null,null,false),

('GO','Goiás','2026-03-31','08:30','Assembleia','hibrida',
 (select id from sindicatos where cnpj='02.898.179/0001-71' limit 1),'SENALBA-GO','laboral',
 'Rua 103, nº 120, Quadra F-24, Lote 14, Sala 02, Setor Sul, Goiânia/GO',
 null,null,null,null,null,null,null,false),

('MG','Minas Gerais','2026-04-09','11:30','Reunião de negociação','remota',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,null,false),

('DF','Distrito Federal','2026-04-10','08:30','Assembleia','presencial',
 (select id from sindicatos where cnpj='00.395.419/0001-90' limit 1),'SINDCLUBES-DF','laboral',
 'OPTADESK – SCRN 702/703 – Bloco B – Térreo – Brasília/DF, CEP: 70.720-620',
 null,null,null,null,null,null,null,false),

('PA','Pará','2026-04-10','18:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='05.359.823/0001-21' and uf='PA' limit 1),'SENALBA-PA/AP','laboral',
 'Auditório do SESC VER-O-PESO, Boulevard Castilho França 522/523 - Campina, Belém/PA',
 null,null,null,null,null,null,null,false),

('AP','Amapá','2026-04-10','18:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='05.359.823/0001-21' and uf='AP' limit 1),'SENALBA-PA/AP','laboral',
 'Auditório do SESC VER-O-PESO, Boulevard Castilho França 522/523 - Campina, Belém/PA',
 null,null,null,null,null,null,null,false),

('SP','São Paulo','2026-04-14','14:30','Assembleia','remota',
 (select id from sindicatos where cnpj='61.398.905/0001-56' limit 1),'SEEAATESP','patronal',
 null,null,null,null,null,null,null,'ID da reunião: 842 7602 3516 / Senha: 815680',false),

('RJ','Rio de Janeiro','2026-04-15','11:30','Assembleia','hibrida',
 (select id from sindicatos where cnpj='40.163.529/0001-40' limit 1),'SECFETAARJ','patronal',
 'Av. Ernani do Amaral Peixoto, nº 36 – Sala 1020 – Centro – Niterói/RJ',
 null,null,null,null,null,null,
 'On-line via Zoom; link mediante solicitação: secfetaarj@gmail.com',true),

('RS','Rio Grande do Sul','2026-04-16','10:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='93.013.670/0001-23' limit 1),'SECRASO-RS','patronal',
 'Av. Ipiranga, 550 - Menino Deus, Porto Alegre/RS',
 null,null,null,null,null,null,null,true),

('GO','Goiás','2026-04-22',null,'Outro','presencial',
 (select id from sindicatos where cnpj='02.898.179/0001-71' limit 1),'SENALBA-GO','laboral',
 null,null,null,null,null,null,null,'VIAGEM CREF GO',true),

('BA','Bahia','2026-04-28','09:30','Assembleia','hibrida',
 (select id from sindicatos where cnpj='07.158.719/0001-02' limit 1),'SINDELIVRE-BA','patronal',
 'Auditório Ed. Empresarial Tancredo Neves, 1º andar, R. Edístio Pondé, 353, STIEP, Salvador/BA',
 null,null,null,null,null,null,
 'On-line mediante solicitação: sindelivre@bol.com.br ou sindelivre.bahia@gmail.com',true),

('GO','Goiás','2026-04-28','08:30','Assembleia','remota',
 (select id from sindicatos where cnpj='11.507.882/0001-00' limit 1),'SINPEF-GO','laboral',
 null,null,null,null,null,null,null,null,false),

('SC','Santa Catarina','2026-04-29','10:30','Assembleia','remota',
 (select id from sindicatos where cnpj='08.394.516/0001-70' limit 1),'SIACADESC','patronal',
 null,null,null,null,null,null,null,null,false),

('MS','Mato Grosso do Sul','2026-05-07','09:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='37.177.458/0001-20' limit 1),'SECRASO-MS','patronal',
 null,null,null,null,null,null,null,null,true),

('MT','Mato Grosso','2025-05-13','13:00','Assembleia','presencial',
 (select id from sindicatos where cnpj='02.748.755/0001-02' limit 1),'SIEEE-MT','patronal',
 null,null,null,null,null,null,null,null,true),

('MG','Minas Gerais','2025-05-15','11:00','Assembleia','remota',
 (select id from sindicatos where cnpj='73.691.206/0001-89' limit 1),'SENAGIC','patronal',
 null,null,null,null,null,null,null,null,false),

('PR','Paraná','2026-05-26','08:30','Assembleia','presencial',
 (select id from sindicatos where cnpj='02.740.267/0001-40' limit 1),'SINDICLUBES','patronal',
 null,null,null,null,null,null,null,null,true),

('SP','São Paulo','2025-05-29','12:30','Outro','presencial',
 null,null,null,
 null,null,null,null,null,null,null,null,true),

('BA','Bahia','2026-06-02','11:00','Assembleia','remota',
 (select id from sindicatos where cnpj='07.158.719/0001-02' limit 1),'SINDELIVRE-BA','patronal',
 null,null,null,null,null,null,null,null,false),

('GO','Goiás','2026-06-03','08:30','Assembleia','remota',
 (select id from sindicatos where cnpj='14.167.460/0001-13' limit 1),'SINDAC-GO','patronal',
 null,null,null,null,null,null,null,
 'Representante não-proprietário deve enviar procuração ao sindacgoias@yahoo.com 1h antes da assembleia.',false),

('BA','Bahia','2026-06-08','10:30','Assembleia','remota',
 (select id from sindicatos where cnpj='07.158.719/0001-02' limit 1),'SINDELIVRE-BA','patronal',
 null,null,null,null,null,null,null,null,false),

('RJ','Rio de Janeiro','2025-06-09','08:30','Assembleia','presencial',
 (select id from sindicatos where cnpj='07.546.139/0001-84' limit 1),'SINDACAD','patronal',
 null,null,null,null,null,null,null,null,true);
