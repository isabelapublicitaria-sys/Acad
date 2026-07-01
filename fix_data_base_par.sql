-- Adiciona Data Base como atributo do PAR sindical (grupos_sindicais), nao só
-- do registro de CCT de um ano especifico. Isso permite ver a data base mesmo
-- de pares que ainda nao tem nenhuma CCT cadastrada (ex: Amapá) - antes só
-- aparecia quando já existia uma linha em pisos daquele ano.

alter table grupos_sindicais add column if not exists data_base text;
