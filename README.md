# matf14

MATF14: Estatística Econômica I (UFBA, Departamento de Estatística, código MATF14, 60h,
pré-requisito MAT047). Turma 2026.2, encontros às 2ª e 4ª-feira, 10:40–12:30, Sala 22, PAF I,
início em 24/08/2026. Material elaborado por Raydonal Ospina, com colaboração de Rodney
Vasconcelos Fonseca. Página do curso: <https://raydonal.github.io/matf14/>.

Disciplina de serviço para os cursos de Economia e Estatística. Ementa: estatística descritiva,
probabilidade, variáveis aleatórias discretas e contínuas. Avaliação: três provas (P1, P2, P3),
NF = (P1+P2+P3)/3. P1 cobre a Unidade 1; P2 cobre as Unidades 2 e 3; P3 cobre a Unidade 4. Sem
projetos; listas de exercícios não valem nota.

## Estrutura do repositório

- `Apoio/`: material original do professor (slides `.odp` por unidade, laboratórios em R,
  listas e provas já aplicadas no semestre 2026.1). Não é alterado por este projeto.
- `Livro/`: livro-texto em [bookdown](https://bookdown.org/) (gitbook), com a mesma numeração da
  ementa oficial (Capítulos 1-4) mais três apêndices (ferramentas de trabalho em R e Python,
  revisão de cálculo, fórmulário). Renderizar
  com `bookdown::render_book("Livro/index.Rmd")`.
- `Aulas2026/`: slides de aula em [xaringan](https://slides.yihui.org/xaringan/), um deck por
  encontro do cronograma oficial. As aulas 01 e 02 do cronograma original (apresentação da
  disciplina; população/amostra e tipos de variáveis) foram fundidas em um único deck
  (`MATF14-01.Rmd`), assim como as aulas 15 e 16 (revisão intermediária e exercícios das Unidades
  1-2, agora um único deck em `MATF14-15.Rmd`), para caber no novo horário (encontros de 1h50,
  2ª e 4ª-feira). Renderizar cada deck com `rmarkdown::render("Aulas2026/MATF14-NN.Rmd")`.

### Cronograma 2026.2

Datas conforme o [calendário acadêmico oficial da UFBA para 2026.2](https://supac.ufba.br/sites/supac.ufba.br/files/calendario_academico_2026.2_08.06.26.pdf)
(início do período letivo 19/08/2026, fim 19/12/2026): início da turma em 24/08/2026, sem aula nos
feriados de 07/09 (Independência), 12/10 (N. Sra. Aparecida) e 02/11 (Finados); 28/10 é ponto
facultativo (aula mantida). Os dias de **P1**, **P2** e **P3** não têm slide próprio, são a
continuação natural do deck anterior (que já fecha com um slide "Fim da Unidade").

| Data | Dia | Conteúdo |
|---|---|---|
| 24/08 | 2ª | `MATF14-01` — Apresentação da disciplina · População e amostra · Tipos de variáveis |
| 26/08 | 4ª | `MATF14-03` — Apresentação tabular e representação gráfica |
| 31/08 | 2ª | `MATF14-04` — Medidas de tendência central e suas relações |
| 02/09 | 4ª | `MATF14-05` — Quantis, distância interquartílica e boxplots |
| 09/09 | 4ª | `MATF14-06` — Medidas de dispersão: AT, DP e CV |
| 14/09 | 2ª | `MATF14-07` — [Laboratório] R para estatística descritiva |
| 16/09 | 4ª | `MATF14-08` — Correlação. Assimetria e curtose |
| **21/09** | **2ª** | **Prova 1** (Unidade 1) |
| 23/09 | 4ª | `MATF14-09` — Espaço amostral e eventos. Revisão de conjuntos |
| 28/09 | 2ª | `MATF14-10` — Propriedades de probabilidade. Métodos de contagem |
| 30/09 | 4ª | `MATF14-11` — Probabilidade condicional |
| 05/10 | 2ª | `MATF14-12` — Independência estatística |
| 07/10 | 4ª | `MATF14-13` — [Laboratório] Simulação de probabilidade em R |
| 14/10 | 4ª | `MATF14-14` — Teorema de Bayes |
| 19/10 | 2ª | `MATF14-15` — Revisão intermediária + exercícios: Unidades 1 e 2 |
| 21/10 | 4ª | `MATF14-17` — Variável aleatória discreta: conceituação |
| 26/10 | 2ª | `MATF14-18` — Esperança e Variância (VA discreta) |
| 28/10 | 4ª (facultativo) | `MATF14-19` — Função de distribuição acumulada (discreta) |
| 04/11 | 4ª | `MATF14-20` — Distribuição de Bernoulli e Distribuição Binomial |
| 09/11 | 2ª | `MATF14-21` — Distribuição de Poisson |
| 11/11 | 4ª | `MATF14-22` — [Laboratório] Simulação de VA discretas em R |
| 16/11 | 2ª | `MATF14-23` — Aula de exercícios + Revisão de cálculo |
| **18/11** | **4ª** | **Prova 2** (Unidades 2 e 3) |
| 23/11 | 2ª | `MATF14-24` — Variável aleatória contínua: conceituação |
| 25/11 | 4ª | `MATF14-25` — Esperança e Variância (VA contínua) |
| 30/11 | 2ª | `MATF14-26` — Função de distribuição acumulada (contínua) |
| 02/12 | 4ª | `MATF14-27` — Distribuição Uniforme |
| 07/12 | 2ª | `MATF14-28` — Distribuição Normal |
| 09/12 | 4ª | `MATF14-29` — Aula de exercícios: Unidade 4 |
| 14/12 | 2ª | `MATF14-30` — Revisão geral pré-Prova 3 |
| **16/12** | **4ª** | **Prova 3** (Unidade 4) — último dia letivo do semestre |

O cronograma acima usa **todos** os encontros disponíveis entre 24/08 e 16/12 sem folga, então
qualquer feriado ou paralisação não prevista aqui empurra as datas subsequentes; segunda chamada
fica, como já era, a combinar ao final do semestre.
- `Listas2026/`: listas de exercícios em LaTeX, contextualizadas em cenários de economia e
  estatística (mercado de trabalho, inflação, finanças, pesquisas eleitorais), organizadas por
  bloco temático, incluindo três simulados no formato oficial de prova (um por P1/P2/P3). Não
  substituem as listas de `Apoio/Listas`, já em uso. Os gabaritos (tanto de `Apoio/Listas` quanto
  de `Listas2026`) não ficam neste repositório — alunos têm acesso a este material, e as respostas
  são mantidas em repositório privado separado.

Este material segue o mesmo padrão de organização adotado no curso irmão
[MATD48](https://github.com/Raydonal/matd48).
