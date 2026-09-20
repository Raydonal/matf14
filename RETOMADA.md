# Retomada — MATF14 2026.2 (revisão profunda: exemplos do Rodney + renderização)

## Sessão 2026-09-17: probabilidade aprofundada, contas nacionais, aulas 2 × 50 min

**Estado:** o professor aprovou a nova versão (2026-09-17). Alterações **não commitadas**
(somam-se às de 2026-09-16): **o professor fará o commit e o push ele mesmo** — não commitar nem
empurrar sem pedido explícito. Backup fora do git feito no fim da sessão (ver "Backup" abaixo).

**Pedido do professor:** capítulo de probabilidade superficial (contagem, axiomas, probabilidade
geométrica, tabelas de contingência, chances/razão de chances/prevalência); ampliar todos os
capítulos com contas nacionais, CEI, contas monetárias e financeiras, trimestrais, regionais e
insumo-produto; reorganizar os slides para duas aulas de 50 min por encontro; P1 em 23/09; nome do
Rodney fora dos slides.

**Feito:**
1. **Cronograma:** Aula 09 em 21/09 e P1 em 23/09 (README, `index.Rmd`, `date:` do deck 09, avisos nos decks 08 e 09 e
   slide de avaliação do deck 01). Nada mais mudou.
2. **Créditos:** nome do Rodney removido de slides, listas e legendas; fica só nos Agradecimentos
   do livro (`Livro/index.Rmd`). Regra registrada no `CLAUDE.md`.
3. **Capítulo 2 reescrito:** interpretações de probabilidade, σ-álgebra e axiomas de Kolmogorov
   com consequências (Boole/Bonferroni), os quatro tipos de contagem com exemplos e o elo com a
   probabilidade clássica (só vale com resultados equiprováveis), hipergeométrica, probabilidade
   geométrica, tabelas de contingência com a PNAD Contínua (perfis, Simpson), risco relativo,
   razão de chances, prevalência/incidência, VPP/VPN, Bayes na forma de chances.
4. **Contas nacionais:** nova seção `#contas-nacionais` no Cap. 1 (PIB pelas três óticas, taxas
   trimestrais, contas regionais, CEI, agregados monetários, matriz de Leontief) e seções de
   aplicação macro nos Caps. 3 (`#va-discreta-macro`: recessões e deflação) e 4
   (`#va-continua-macro`: normalidade do crescimento do PIB). Dados oficiais em `Livro/data/`
   (cópias em `Aulas2026/`), baixados por `Livro/data/baixar_contas.R`.
5. **Slides:** todos os decks do cronograma reorganizados em Roteiro → Parte 1 (50 min) →
   Intervalo → Parte 2 (50 min), com tempo por slide (`.tempo[...]`) e atividades em sala;
   decks 10–14 refeitos para o novo Cap. 2; slides novos com dados reais nas Unidades 1, 3 e 4.
6. **Listas:** seção "Aprofundamento" (A1, A2, …) nas Listas 01–07 e 09–12, com os novos tópicos e
   dados reais; todas recompiladas (`needspace` no `preamble.tex`).
7. **Gabaritos:** mantidos **fora do repositório**, em
   `../matf14-gabaritos-privado/Listas2026/GabaritoNN.{tex,pdf}` (inclui as soluções dos
   exercícios de Aprofundamento; corrigidos erros numéricos antigos nos Gabaritos 02, 03, 08 e 10).
8. **Verificação:** capturas automáticas de todos os slides dos decks do cronograma e das 69 páginas do livro
   (corte, TeX cru, imagem quebrada, erro de R) → **0 problemas** no fim; revisão visual das
   listas e dos slides novos. Correções achadas assim: slide 52 do deck 01 e 32 do deck 27
   cortados; rótulos cortados no boxplot do PIB (deck 05); legenda `fig-cn-qq` do livro dizia 2
   atípicos (são 8: quedas de 1998, 2008T4, 2015T2, 2020T1–T2; altas de 1996T3, 2020T3–T4).
9. Dicas de resposta removidas das listas (Lista 04, complementar do coeficiente de correlação;
   Lista 05 C7) — as respostas estão só nos gabaritos. Figuras órfãs **não rastreadas** em
   `Aulas2026/*_files/` apagadas.
10. Livro inteiro, `index.Rmd` e todos os decks re-renderizados no fim; os 74 links da página do
    curso apontam para arquivos existentes.

**Pendências / decisões em aberto:**
- Commit e push: com o professor. Ao commitar, conferir `git status` (≈520 caminhos alterados,
  incluindo figuras novas em `Aulas2026/*_files/` e `Livro/*_files/` e os CSVs de `Livro/data/`).
- 25 figuras órfãs **rastreadas** pelo git em `Aulas2026/MATF14-*_files/figure-html/` (de nomes de
  chunk antigos) não são mais usadas; podem sair no commit com `git rm`.
- Simulados (Listas 08, 13, 14) não ganharam exercícios de Aprofundamento.
- `README.md` ainda credita "colaboração de Rodney Vasconcelos Fonseca" na abertura (não é slide,
  lista nem legenda; o professor decide se mantém).
- O render do livro emite 13 *warnings* do R (sem erro; não investigados nesta sessão).
- Leitura humana ponta a ponta antes da P1 (23/09/2026) continua recomendada.

**Backup (2026-09-17):** em `/home/raydonal/MyGithub/Raydonal/matf14-backups/` (fora do repo):
`matf14_backup_<TS>.tar.gz` (árvore de trabalho sem `.git`, com todas as alterações não
commitadas), `matf14-gabaritos-privado_<TS>.tar.gz` e `ferramentas-sessao_<TS>.tar.gz` (scripts
da sessão: `restructure.py` + `cfgNN.py` para reorganizar decks em 2 × 50 min, `escape_sub.py`,
`fix_spans.py`, `shoot_deck.R`/`shoot_book.R` para auditoria por captura de tela, `calc_listas*.R`
com as contas dos exercícios novos, planos da sessão), mais `SHA256SUMS`. Restaurar com
`tar -xzf <arquivo> -C <destino>`.

---

## Sessão 2026-09-16: correção massiva (livro, slides, listas, site)

**Estado:** alterações **não commitadas** (aguardando o professor pedir commit/push).

**Motivo:** o professor apontou que slides e livro ainda prometiam material que não aparecia (ex.:
`MATF14-05`, "Rodada 3: leitura de boxplot (ENEM/SISU/FUVEST)" sem gráfico nem dados), equações
quebradas e pouca extração do material do Rodney (texto **e imagens** dos `.odp`).

**Feito:**
1. Extração completa dos `.odp` do Rodney (4 unidades + aula de exercícios): cada slide em PNG,
   texto por slide e imagens embutidas. 66 figuras (notícias, gráficos, tabelas, desenhos de
   cálculo) copiadas para `Aulas2026/images/` e `Livro/images/`, sempre com fonte indicada.
2. Todos os decks (01, 03–15, 17–30) reescritos/enriquecidos com os exemplos do Rodney; `02`
   reorganizado. Novos helpers `Aulas2026/R/venn.R` e `fda.R` (cópias em `Livro/R/`).
   `custom-styles.css` reescrito (código legível, classes `.fonte`, `.pull-*-40/60`, `caixa-resposta`).
3. Livro: Caps. 1–4 reescritos com caixas em *fenced divs* (`::: {.caixa-*}`), figuras do Rodney,
   IDs de seção preservados (links da página do curso continuam válidos); Apêndices B e C
   revisados; rótulos "Figura/Tabela", data e referências em português.
4. Listas 01–14: removida a promessa de gabarito, adicionados "Exercícios complementares"
   adaptados das listas/provas de 2026.1; todas recompiladas.
5. Contas conferidas em R; erros corrigidos (ex.: Bin(10; 0,86) P(X=8)=0,264; N(500,100²)
   P(600<X<800)=15,7%; fórmula de CV invertida no lab do Rodney).
6. Verificação: captura de tela automática de **todos** os slides e de todas as 61 páginas do livro
   com checagem de corte, TeX cru, imagem quebrada e erro de R — 0 problemas no fim. As lições
   novas de renderização estão no `CLAUDE.md`.

---

**Última atualização:** 2026-09-13, ~21:45 (horário local). Tudo commitado e empurrado para o
`main` (`git@github.com:Raydonal/matf14.git`, HEAD = `89875dc`). Página do curso no ar em
<https://raydonal.github.io/matf14/>. Este arquivo existe para retomar o trabalho sem precisar
reconstruir o contexto do zero — para os detalhes técnicos de cada bug de renderização, o lugar
certo é `CLAUDE.md` (seções "Rendering pitfalls..."), que já documenta tudo isso para qualquer
sessão futura ler antes de editar. Este arquivo é mais a narrativa: o que motivou a sessão, o que
foi feito, o que ainda falta.

## Por que esta sessão aconteceu

O professor revisou o material (já tinha passado por uma rodada de correção de renderização em
2026-08-31, ver histórico do git) e ficou insatisfeito com **profundidade de conteúdo**, não só
renderização: livro e slides subaproveitavam o material original de aula do Prof. Rodney Fonseca
(`Apoio/aulas/unidade_0{1-4}/*.odp`, ~230 slides só na Unidade 1, mais 3 R labs e uma folha de
fórmulas — tudo lido/convertido nesta sessão), tinham exemplos pouco desenvolvidos (fórmula →
direto para o resultado do R, sem conta na mão) para alunos com base matemática fraca, e exemplos
de R rasos. Pediu revisão profunda com múltiplos agentes para validar tudo: livro, slides, página
do curso, listas de exercícios.

No meio do processo, o professor também levantou dois pontos novos: **ritmo de aula** (cada
encontro tem ~100 min, "duas sessões de 50 min" — alguns decks não tinham material suficiente) e
**não há laboratório de informática presencial neste semestre** (os 3 decks `[Laboratório]`
precisavam de um formato virtual/reproduzível em casa).

## Estado atual (git — tudo limpo e commitado e empurrado)

`git status` sem pendências. Working tree = remote = `main` (`89875dc`). Sem branches divergentes
nem stash pendente.

## O que foi feito nesta sessão

1. **Conteúdo**: as 4 unidades (livro + decks correspondentes) foram revisadas em paralelo,
   incorporando exemplos do material do Rodney — contas na mão antes de cada chamada de R, o
   padrão "simulado vs. teórico" (`rbinom`/`rpois` comparados a `dbinom`/`dpois`) que faltava no
   Cap. 3/decks de VA discreta, seções novas no Cap. 1 (razão/taxa de variação, ligada à
   inflação/IPCA; algoritmo geral de percentil; tabela de contingência de Yule 1912), correção de
   um erro factual (`empresas.csv` tem 106 linhas, não 200 como o texto antigo dizia).
2. **Sem laboratório presencial**: `MATF14-07`, `13`, `22` ganharam seção de setup no **Google
   Colab** (screenshots copiados de `Apoio/aulas/lab0{1,2}_*`, renomeados `colab-07-NN-*.png` em
   `Aulas2026/`), espelhando como o próprio Rodney já resolvia isso.
3. **Ritmo de aula**: decks identificados como curtos demais para ~100 min (`06`, `09`, `26`,
   `29`) foram expandidos com mais exemplos/discussão do material do Rodney. `MATF14-30` (revisão
   geral pré-Prova 3) ficou curto de propósito, não foi mexido.
4. **Renderização — verificação visual real, não só render sem erro** (lição que já vinha da
   sessão anterior, reforçada nesta: `rmarkdown::render()`/`bookdown::render_book()` sempre saem
   com exit 0, mesmo quebrados). Usado `chromote` com uma receita corrigida nesta sessão (ver
   `CLAUDE.md` — a receita antiga, que esperava `Page$loadEventFired()`, trava para sempre nestas
   páginas; a nova navega uma vez e dirige os slides via `slideshow.gotoSlide(i)`). Bugs achados e
   corrigidos, todos agora documentados em `CLAUDE.md` para não precisarem ser redescobertos:
   - Matemática dentro das caixas `{=html}` do livro (`caixa-aplicacao`, `caixa-economia`, ...)
     nunca era processada pelo pandoc — `$...$`, `\@ref(...)` e `@citação` todos ficavam como
     texto literal, e as citações **sumiam até da bibliografia**. Bug pré-existente, não
     introduzido nesta sessão, afetava o livro inteiro.
   - Matemática inline `\(...\)` com barra simples nos slides é engolida pelo parser do
     `remark.js` antes do MathJax rodar — precisa de `\\(...\\)` (barra dupla). Achado depois de
     descobrir que **o `MATF14-05` inteiro** (29 fórmulas) estava assim, mais 2 casos no `04` e 6
     no `03`.
   - "Bloco 4: Uso do R" sem quebra de slide (`---`) depois do divisor de fundo escuro deixava o
     código ilegível (12 decks).
   - Duas páginas HTML órfãs do livro (sobras de renomeações antigas) removidas; rótulo de
     apêndice corrigido (A/B trocados) no livro e em 3 slides.
   - Overflow horizontal (fórmula de 3 termos cortando a borda) e legendas sobrepondo o rodapé,
     em pontos isolados.
5. Todos os 29 decks de `Aulas2026/` e o livro completo (`bookdown::render_book`) foram
   re-renderizados no final da sessão e confirmados limpos.

## O que falta / pendente — decisão do professor ou próxima sessão

- **Nenhuma leitura humana ponta-a-ponta** aconteceu ainda. As verificações desta sessão foram
  extensas mas automatizadas (screenshot real de uma amostra grande de slides/páginas, não de
  100% de cada um) — vale o professor abrir o material publicado e navegar de verdade antes da
  P1 (21/09/2026).
- **`Listas2026/`**: uma auditoria de coerência foi feita (nenhuma lista contradiz a notação nova
  do livro), mas as 14 listas em si não foram enriquecidas — não fazia parte do pedido desta
  sessão além de checar consistência.
- **Backup**: não foi gerado um snapshot fora do git desta vez (a sessão anterior tinha um
  processo pra isso). Recomendado antes de qualquer mudança grande futura:
  ```bash
  TS=$(date +%Y%m%d-%H%M)
  cd /home/raydonal/MyGithub/Raydonal   # caminho atual (antes: /home/raydonal/Github/Cursos)
  tar --exclude='matf14/.git' -czf "matf14-backups/matf14_backup_${TS}.tar.gz" matf14
  gzip -t "matf14-backups/matf14_backup_${TS}.tar.gz" && echo OK
  ```
- Pendências já antigas da sessão de 2026-08-31 (repositório privado? e-mail de contato na página
  do curso?) — não foram retomadas nesta sessão, seguem em aberto.

## Como retomar

1. Ler o feedback específico do professor sobre o que revisar/ajustar.
2. **Antes de editar `Aulas2026/*.Rmd` ou `Livro/*.Rmd`, ler as seções "Rendering pitfalls" do
   `CLAUDE.md` inteiras** — cobrem todos os bugs de renderização já descobertos (subscritos, `<`/
   `>`, `R\$`, barra simples vs. dupla em `\(...\)`, "Bloco N" sem quebra, matemática em caixas
   `{=html}`) e a receita de verificação visual que funciona neste ambiente.
3. Depois de qualquer edição com fórmula/tabela/imagem nova: renderizar **e** abrir o HTML gerado
   de verdade (ou usar a receita `chromote` do `CLAUDE.md`) — nunca só confiar no render ter
   terminado sem erro.
4. Só commitar/pushar quando o professor confirmar (nesta sessão ele pediu commit e depois push
   explicitamente, em mensagens separadas — não assuma isso como automático numa próxima rodada).

### Comandos de verificação rápida

```bash
# Livro (bookdown) — precisa rodar de dentro de Livro/, senão renderiza o arquivo errado
cd Livro
Rscript -e 'bookdown::render_book("index.Rmd", quiet = TRUE)'

# Um deck de Aulas2026
cd ../Aulas2026 && Rscript -e "rmarkdown::render('MATF14-NN.Rmd', quiet = TRUE)"
```

A receita de verificação visual real (screenshot via `chromote`, incluindo como navegar entre
slides de forma confiável com `slideshow.gotoSlide()`) está descrita passo a passo em
`CLAUDE.md`, seção "Headless-browser verification recipe that actually works in this sandbox" —
não duplicada aqui de propósito, para não ter duas versões que podem divergir.
