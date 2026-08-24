# matf14

MATF14: Estatística Econômica I (UFBA, Departamento de Estatística, código MATF14, 60h,
pré-requisito MAT047). Turma 2026.2, encontros às 2ª e 4ª-feira, 10:40–12:30, início em
24/08/2026. Material elaborado por Raydonal Ospina, com colaboração de Rodney Vasconcelos Fonseca.

Disciplina de serviço para os cursos de Economia e Estatística. Ementa: estatística descritiva,
probabilidade, variáveis aleatórias discretas e contínuas. Avaliação: três provas (P1, P2, P3),
NF = (P1+P2+P3)/3. P1 cobre a Unidade 1; P2 cobre as Unidades 2 e 3; P3 cobre a Unidade 4. Sem
projetos; listas de exercícios não valem nota.

## Estrutura do repositório

- `Apoio/`: material original do professor (slides `.odp` por unidade, laboratórios em R,
  listas e provas já aplicadas no semestre 2026.1). Não é alterado por este projeto.
- `Livro/`: livro-texto em [bookdown](https://bookdown.org/) (gitbook), com a mesma numeração da
  ementa oficial (Capítulos 1-4) mais dois apêndices (revisão de cálculo e fórmulário). Renderizar
  com `bookdown::render_book("Livro/index.Rmd")`.
- `Aulas2026/`: slides de aula em [xaringan](https://slides.yihui.org/xaringan/), um deck por
  encontro do cronograma oficial. As aulas 01 e 02 do cronograma original (apresentação da
  disciplina; população/amostra e tipos de variáveis) foram fundidas em um único deck
  (`MATF14-01.Rmd`), já que o novo horário reúne em um só encontro (1h50) o conteúdo que antes
  ocupava dois dias separados; a renumeração completa dos demais decks para o calendário 2026.2
  fica para uma próxima revisão. Renderizar cada deck com
  `rmarkdown::render("Aulas2026/MATF14-NN.Rmd")`.
- `Listas2026/`: listas de exercícios em LaTeX, contextualizadas em cenários de economia e
  estatística (mercado de trabalho, inflação, finanças, pesquisas eleitorais), organizadas por
  bloco temático, incluindo três simulados no formato oficial de prova (um por P1/P2/P3). Não
  substituem as listas de `Apoio/Listas`, já em uso. Os gabaritos (tanto de `Apoio/Listas` quanto
  de `Listas2026`) não ficam neste repositório — alunos têm acesso a este material, e as respostas
  são mantidas em repositório privado separado.

Este material segue o mesmo padrão de organização adotado no curso irmão
[MATD48](https://github.com/Raydonal/matd48).
