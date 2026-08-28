-- =====================================================================
--  A ASSINATURA DO RESPONSÁVEL TÉCNICO NO CERTIFICADO
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  O que este arquivo faz
--  ----------------------
--  Abre um lugar no bucket privado para a imagem da assinatura, sem
--  torná-la pública. A imagem fica em `responsavel/assinatura.png`, o
--  admin envia por lá, e o certificado pede uma URL assinada de curta
--  duração na hora de desenhar.
--
--  Por que não deixar a imagem no site, junto com as outras
--  -------------------------------------------------------
--  Porque o site é público. Uma assinatura escaneada num endereço fixo e
--  adivinhável é uma assinatura que qualquer pessoa baixa e cola em
--  qualquer papel. No bucket privado ela só sai para quem está logado, e
--  a página de conferência pública NÃO a mostra: para o auditor, o que
--  prova o documento é o código, conferido no site da clínica.
--
--  DE QUEBRA, CONSERTA UM ERRO QUE JÁ ESTAVA AQUI
--  ----------------------------------------------
--  A política de leitura fazia isto:
--
--      public.trein_pode_ver( (storage.foldername(name))[1]::uuid )
--
--  Ela assume que a primeira pasta é SEMPRE um uuid de curso. Qualquer
--  arquivo guardado fora desse formato, inclusive o que este arquivo
--  passa a permitir, faria o cast levantar `invalid input syntax for
--  type uuid` e a leitura morrer com erro de banco, e não com "não
--  pode". Agora o formato é conferido antes do cast.
-- =====================================================================

drop policy if exists trein_stor_read on storage.objects;
create policy trein_stor_read on storage.objects
  for select using (
    bucket_id = 'treinamentos'
    and (
      public.trein_is_equipe()

      -- A assinatura: qualquer pessoa LOGADA lê. O aluno precisa dela
      -- para o próprio certificado sair assinado, e ele não é da equipe.
      -- Quem não tem login nenhum continua sem ver.
      or ( name like 'responsavel/%' and auth.uid() is not null )

      -- O material do curso: só com matrícula válida. O regex confere
      -- que a pasta tem cara de uuid ANTES de converter; sem isso o
      -- cast levanta exceção em vez de negar.
      or (
        (storage.foldername(name))[1] ~*
          '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
        and public.trein_pode_ver(((storage.foldername(name))[1])::uuid)
      )
    )
  );

-- Escrever, trocar e apagar continuam sendo só da equipe, e as políticas
-- de escrita já eram assim: ficam como estão.

-- =====================================================================
--  Confira
-- =====================================================================
-- Tem de listar as quatro políticas do bucket. A de leitura precisa
-- aparecer com `responsavel` no texto.
select policyname,
       cmd,
       (qual is not null and qual like '%responsavel%') as fala_da_assinatura
  from pg_policies
 where schemaname = 'storage' and tablename = 'objects'
   and policyname like 'trein_stor%'
 order by policyname;
