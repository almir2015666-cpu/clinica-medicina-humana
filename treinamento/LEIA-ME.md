# Treinamentos em NRs — como colocar no ar

Passo a passo, na ordem. São 6 passos; os quatro primeiros são no painel do
Supabase e levam uns 15 minutos.

Endereço final: **clinicamedicinahumana.com.br/treinamento/**

---

## Passo 1 — Criar o bucket (2 min)

Painel do Supabase → **Storage** → **New bucket**

- Nome: `treinamentos`
- **Public bucket: DESMARCADO** (tem de ficar privado)
- Create

> Faça isto **antes** do passo 2. O SQL cria regras de acesso para este
> bucket; se ele ainda não existir, essa parte do script falha.

---

## Passo 2 — Criar as tabelas (3 min)

Supabase → **SQL Editor** → **New query**

1. Abra `servidor-sql/01-esquema.sql`, copie tudo, cole e clique em **Run**.
2. Repita com `servidor-sql/02-cursos.sql` — é o catálogo dos 13 treinamentos.

O segundo termina mostrando a lista do que entrou. Se aparecerem as 13
linhas, deu certo.

**Confira a carga horária.** Preenchi com a usual de mercado, mas cada Norma
tem a sua e algumas mudam conforme a atividade. Hora errada no certificado é
problema na fiscalização — peça ao responsável técnico para conferir.

**O preço está em branco de propósito.** O site mostra "Sob consulta"
enquanto for nulo. Para preencher:

```sql
update public.trein_curso set preco = 149.00 where codigo = 'NR-35';
```

---

## Passo 3 — Publicar a função de resgate (5 min)

Supabase → **Edge Functions** → **Deploy a new function**

- Nome: `resgatar-cupom` ← tem de ser exatamente isso
- Apague o código de exemplo, cole o conteúdo de
  `servidor-edge/resgatar-cupom/index.ts` e publique.

É essa função que cria a conta do trabalhador quando ele digita o código.
Sem ela, o resgate não funciona.

---

## Passo 4 — Testar antes de vender (5 min)

Rode `servidor-sql/03-cupom-de-teste.sql`. Ele cria o código **TESTE-2026**,
com 3 vagas, valendo para NR-35 e NR-06.

Abra `treinamento/entrar.html` e vá na aba **Tenho um código**:

1. Digite `TESTE-2026`. Em um segundo a tela mostra "EMPRESA DE TESTE LTDA"
   e os dois cursos — se mostrar, o banco está respondendo.
2. Preencha nome completo, **um CPF válido de verdade** (o dígito
   verificador é conferido) e uma senha.
3. Clique em liberar. Você cai direto no painel, com os dois cursos.

Teste também o que **tem de dar errado**:

| O que fazer | O que tem de acontecer |
|---|---|
| Código que não existe | "Código não encontrado ou fora do prazo" |
| O mesmo código duas vezes, mesmo CPF | "Você já usou esse código" |
| Resgatar com 4 CPFs diferentes | O quarto recebe "as vagas acabaram" |

O fim do `03-cupom-de-teste.sql` mostra como apagar tudo o que o teste criou.

---

## Passo 5 — Publicar o site (2 min)

Pasta nova dentro do repositório que já existe. **Sem DNS nenhum.**

```
cd C:\Projetos\Web\clinica-medicina-humana
git add -A
git commit -m "Treinamentos em NRs: site, area do aluno e cupons"
git push origin master
```

Em um ou dois minutos o GitHub Pages publica, e o botão **Treinamento NRs**
passa a levar para lá.

---

## Passo 6 — Vender

Enquanto a tela do SistemaCMH não existe, o cupom se cria pelo SQL Editor:

```sql
-- 1) o cupom
insert into public.trein_cupom
  (codigo, empresa, empresa_cnpj, contato, quantidade,
   expira_resgate, acesso_dias, criado_por)
values
  ('NR35-CONSTRUTORA-X', 'CONSTRUTORA X LTDA', '12345678000190',
   'Maria, do RH', 50,
   '2026-12-31',   -- até quando dá para RESGATAR
   365,            -- cada pessoa fica 1 ano com o curso
   'Fulano');

-- 2) quais cursos ele libera
insert into public.trein_cupom_curso (cupom_id, curso_id)
select c.id, k.id from public.trein_cupom c
  join public.trein_curso k on k.codigo in ('NR-35', 'NR-06')
 where c.codigo = 'NR35-CONSTRUTORA-X';
```

Depois é só entregar o código ao cliente.

**Cuidado com `quantidade`:** é quantas pessoas podem resgatar. `0`
significa **ilimitado** — bom para cortesia, ruim para venda.

Acompanhar quem já usou:

```sql
select c.codigo, c.empresa, c.quantidade,
       count(r.aluno_id) as resgatados,
       c.quantidade - count(r.aluno_id) as restam
  from public.trein_cupom c
  left join public.trein_resgate r on r.cupom_id = c.id
 group by c.id order by c.criado_em desc;
```

Cancelar um cupom sem apagar o histórico:

```sql
update public.trein_cupom set ativo = false where codigo = 'NR35-CONSTRUTORA-X';
```

---

## O que ainda não existe

1. **Tela no SistemaCMH** — gerar cupom, ver quem resgatou e cancelar sem
   precisar de SQL. É o próximo passo natural.
2. **Player das aulas** — depende de decidir **onde os vídeos ficam
   hospedados** (YouTube não listado, Vimeo ou Storage do Supabase). Hoje o
   painel lista os cursos, mas o "Continuar" ainda não abre nada.
3. **Prova e certificado** — duas Edge Functions: uma serve a prova sem as
   respostas e corrige; outra emite o certificado depois de conferir que
   passou.
4. **Página de conferência** do certificado. A função no banco
   (`trein_conferir_certificado`) já está pronta.

---

## Como funciona, para quando você voltar aqui daqui a seis meses

Você gera um **cupom** — quais cursos, para quantas pessoas, dois prazos. O
cliente recebe **um código só** e repassa à equipe. Cada trabalhador resgata
com CPF e nome, cria a própria senha, e a partir daí tem **conta
individual** — que é o que permite o certificado sair nominal, como a NR
exige. Cada resgate consome uma vaga.

**Os dois prazos são coisas diferentes.** `expira_resgate` é até quando o
*cupom* pode ser usado; `acesso_dias` (ou `acesso_ate`) é quanto tempo a
*pessoa* fica com o curso. Um cupom pode parar de circular em março e quem
resgatou em fevereiro seguir estudando até dezembro.

**Onde a segurança mora.** Prazo, resposta da prova e contagem de vagas
ficam todos no banco, e não no JavaScript — o que o navegador esconde,
qualquer um mostra de volta. A vaga é consumida com a linha do cupom
travada, senão dois resgates no mesmo segundo pegariam a mesma.

## Os arquivos

| Onde | O que é |
|---|---|
| `index.html` | A vitrine: cursos, como funciona, chamada para o comercial. |
| `entrar.html` | Login por CPF, resgate de cupom e painel do aluno. |
| `css/estilo.css` | O visual próprio (marinho da clínica + âmbar de EPI). |
| `servidor-sql/01-esquema.sql` | Tabelas, funções e regras de acesso. |
| `servidor-sql/02-cursos.sql` | O catálogo. Dá para rodar de novo para corrigir. |
| `servidor-sql/03-cupom-de-teste.sql` | O cupom de teste, e como apagá-lo. |
| `servidor-edge/resgatar-cupom/` | Cria a conta do aluno no resgate. |
