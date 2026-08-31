---
title: "Estatística Econômica I"
subtitle: "Notas de curso: MATF14"
author: "Raydonal Ospina"
date: "31 de August de 2026"
site: bookdown::bookdown_site
documentclass: book
bibliography: refs.bib
csl: apa.csl
link-citations: true
biblio-style: apalike
description: "Livro-texto de apoio à disciplina MATF14 (Estatística Econômica I), Departamento de Estatística, UFBA."
---



# Prefácio {-}

Todo dia você já decide sob incerteza, mesmo sem chamar isso de Estatística:

> Vale a pena trocar o investimento em poupança por um fundo multimercado, sabendo que o retorno
> pode ser maior, mas também pode ser negativo em algum mês?

> Uma pesquisa de opinião mostra o candidato A com 52% e o candidato B com 48%, com margem de erro
> de 3 pontos, a eleição já está decidida?

> O IBGE divulga que a inflação do mês veio "dentro da meta", dentro da meta de quem, medida em
> que amostra, com que margem de erro?

> Um banco te oferece crédito pré-aprovado porque seu escore está "acima da média", acima de que
> distribuição, exatamente, esse escore está sendo comparado?

> Uma seguradora de automóveis cobra um prêmio mais alto para condutores jovens, essa diferença
> reflete um risco real, mensurado como, ou é só um estereótipo com aparência de número?

Nenhuma dessas perguntas se responde bem sem o vocabulário formal que este livro constrói: dado,
variável, distribuição, probabilidade condicional, valor esperado. **MATF14, Estatística
Econômica I** é a disciplina do Departamento de Estatística da Universidade Federal da Bahia (UFBA)
que constrói esse vocabulário para quem vai lidar com essas perguntas profissionalmente, economistas
e estatísticos. Este livro acompanha os slides de aula (`Aulas2026/`) e as listas de exercícios
(`Listas2026/`), formando um material único de apoio.

## Para quem é este livro {-}

Para estudantes de Economia e de Estatística que estão tendo o primeiro contato sério com dados,
não como um exercício de sala de aula, mas como a matéria-prima de decisões reais: um banco central
decidindo a taxa de juros, um fundo de pensão calibrando risco, uma prefeitura decidindo onde
investir com base em indicadores sociais. A Economia, como disciplina, é feita quase inteiramente de
inferências a partir de dados incompletos e ruidosos, séries curtas, amostras enviesadas, choques
que nunca se repetem exatamente. A Estatística é o único ferramental que formaliza *o que dá e o que
não dá* para concluir a partir desse tipo de evidência. Cada conceito formal deste livro, de uma
tabela de frequências ao Teorema de Bayes, de uma variância amostral à distribuição Normal, é
imediatamente testado contra um problema real da área: preços, renda, câmbio, desemprego, mercado
financeiro, pesquisas de opinião, política pública.

**Avaliação da disciplina:** três provas (P1, P2 e P3), com nota final $NF=(P_1+P_2+P_3)/3$. P1
cobre a Unidade 1 (Estatística Descritiva); P2 cobre as Unidades 2 e 3 (Probabilidade e Variáveis
Aleatórias Discretas); P3 cobre a Unidade 4 (Variáveis Aleatórias Contínuas). As listas de
exercícios **não valem nota**, mas são o principal instrumento de preparação, cada lista de
`Listas2026/` traz gabarito completo para autoavaliação. Não há projetos nesta disciplina: o
objetivo é dominar os conceitos com profundidade suficiente para resolvê-los sob prova, sem
consulta, e para reconhecê-los quando reaparecerem, e vão reaparecer, em Econometria,
Microeconomia e qualquer leitura crítica de dados que você fizer depois de formado.

## Por que as discussões importam tanto quanto as contas {-}

Um erro comum de quem estuda Estatística pela primeira vez é tratar cada capítulo como uma coleção
de fórmulas a decorar e aplicar. As fórmulas deste curso são, de fato, poucas e simples, a
dificuldade real está em **saber qual pergunta cada fórmula responde, e qual não responde**. Uma
correlação de 0,86 entre gasto em propaganda e vendas prova que a propaganda causa as vendas? Um
teste de fraude com 95% de acerto significa que 95% dos alarmes são fraudes de verdade? Uma média
salarial de R\$ 6.000 descreve bem o "trabalhador típico" de uma categoria profissional?

As respostas a essas perguntas não vêm de uma fórmula a mais, vêm de entender os **limites** de
cada ferramenta, e isso só se constrói discutindo casos concretos, de preferência antes de ver a
resposta pronta. Por isso, cada seção deste livro e cada bloco dos slides de aula trazem blocos de
discussão **substanciais**, não uma pergunta decorativa ao final, mas várias perguntas
interligadas, que você deveria tentar responder por escrito, sozinho ou em grupo, antes de seguir
adiante. Nas provas, a diferença entre nota alta e nota mediana quase sempre está aqui: não em saber
a fórmula, mas em saber quando ela se aplica e o que ela deixa de fora.

## Como o material está organizado {-}

O livro segue **exatamente** a numeração da ementa oficial da disciplina, para que o aluno consiga
localizar qualquer tópico cobrado em prova diretamente pelo número da seção:

| Capítulo | Tópico | Seções da ementa | Aulas correspondentes | Prova |
|---|---|---|---|---|
| 1 | Estatística Descritiva e Exploratória de Dados | 1.1 – 1.6 | Aulas 01–08 | P1 |
| 2 | Introdução à Teoria das Probabilidades | 2.1 – 2.7 | Aulas 09–16 | P2 |
| 3 | Variáveis Aleatórias Discretas | 3.1 – 3.4 | Aulas 17–23 | P2 |
| 4 | Variáveis Aleatórias Contínuas | 4.1 – 4.4 | Aulas 24–30 | P3 |
| Apêndice A | Revisão de Cálculo (derivadas e integrais) | - | apoio ao Cap. 4 | - |
| Apêndice B | Fórmulário e tabelas de referência | - | consulta para as provas | - |

Os slides de aula (`Aulas2026/`) seguem o cronograma **dia a dia** do semestre (uma aula, um
deck); as listas (`Listas2026/`) agrupam esses dias em blocos temáticos maiores, com questões
contextualizadas e gabarito à parte. O livro é a versão de referência mais completa: cada capítulo
cobre com mais vagar, e com mais discussão, o que os slides do bloco correspondente apresentam de
forma resumida em sala.

## Um fio condutor: três lentes sobre os mesmos dados {-}

Ao longo do livro, os exemplos giram em torno de três domínios que qualquer economista ou
estatístico vai encontrar na prática:

- **Macroeconomia e política econômica**, inflação (IPCA), taxa de câmbio, taxa de desemprego
  (PNAD Contínua), crescimento do PIB. Séries **simuladas**, mas construídas para reproduzir a
  ordem de grandeza e o comportamento real dessas variáveis no Brasil recente, sempre identificadas
  como ilustrativas quando não vierem de fonte primária citada.
- **Mercado de trabalho e distribuição de renda**, salários, desigualdade, escolaridade,
  informalidade, representatividade política, incluindo `dados_prefeitos.csv`, base **real** com
  características sociodemográficas de prefeitos eleitos em todos os municípios brasileiros.
- **Empresas e mercado financeiro**, faturamento, porte, setor, retorno de ações, incluindo
  `empresas.csv`, base **real** de 200 empresas brasileiras (porte, faturamento, setor, região),
  usada como fio condutor do Capítulo 1.

## Convenções tipográficas {-}

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação</strong>, um exemplo completo, com dados reais ou
simulados e a pergunta econômica/estatística que motiva a técnica em questão.</div>
<div class="caixa-discussao"><strong>Para discutir</strong>, bloco estendido de perguntas abertas,
sem resposta única, pensado para debate em sala ou resolução escrita antes de seguir adiante. É,
deliberadamente, a seção mais longa de cada capítulo.</div>
<div class="caixa-r"><strong>Uso do R</strong>, código comentado, sempre reprodutível a partir do
próprio capítulo.</div>
<div class="caixa-economia"><strong>Leitura econômica</strong>, o que o resultado numérico
significa fora da estatística: para um formulador de política, um investidor, um gestor.</div>
```

Todo o código usa o pacote `tidyverse` para manipulação de dados e `ggplot2` para gráficos. Sempre
que um resultado tiver uma leitura formal (somatório, definição, propriedade), ela aparece antes do
exemplo numérico, o objetivo é que o aluno saiba *de onde* o número do R vem, não só copiar o
comando.

## Bibliografia {-}

A bibliografia básica segue as referências oficiais do plano de ensino: @hoffmann2006estatistica,
@morettinbussab2012, @magalhaes2004probabilidade e @ross2010probabilidade. Como complementares:
@dantas1997probabilidade, @hoggmckeancraig2013 e @triola2007introducao.

## Agradecimentos {-}

Este material foi elaborado por **Raydonal Ospina**, com a colaboração de **Rodney Vasconcelos
Fonseca**, docente responsável pela turma de MATF14 no semestre 2026.1, cujo material de aula
original (slides por unidade, laboratórios em R, listas e provas já aplicadas em sala) serviu de
referência de conteúdo, cronograma e nível de exigência para a construção deste livro, dos slides
e das listas de exercícios aqui reunidos.
