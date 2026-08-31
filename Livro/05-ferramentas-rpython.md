# (APPENDIX) Apêndices {-}

# Ferramentas de Trabalho: R e Python {#ferramentas-rpython}



Este curso usa R nos laboratórios (Aulas 07, 13 e 22, Capítulos 1 a 3) porque é o padrão histórico
em Estatística e Economia aplicada. Python aparece como referência complementar porque é o padrão
em ciência de dados e machine learning fora da academia, e porque a sintaxe das duas linguagens é
parecida o bastante para que aprender uma acelere a outra. Este apêndice não substitui os
laboratórios do curso (nem o material extra "[Aula 02](../Aulas2026/MATF14-02.html)", com o mesmo
conteúdo em formato de slides), ele existe como referência de consulta rápida, lado a lado nas duas
linguagens.

## Instalação

Para R, é preciso instalar dois programas, nessa ordem: a linguagem
([cran.r-project.org](https://cran.r-project.org)) e o RStudio Desktop, o ambiente onde se escreve
e roda código
([posit.co/download/rstudio-desktop](https://posit.co/download/rstudio-desktop/)), gratuitos os
dois. Para Python, a forma mais simples para quem está começando é instalar o Anaconda
([anaconda.com/download](https://www.anaconda.com/download)), que já vem com Python, Jupyter
Notebook e os pacotes mais usados em ciência de dados (`pandas`, `numpy`, `matplotlib`) juntos.

## R e Python como calculadora

Antes de qualquer coisa, as duas linguagens já funcionam como calculadora, sem instalar nada
extra:


``` r
2 + 2
```

```
## [1] 4
```

``` r
(10 - 4) / 3
```

```
## [1] 2
```

``` r
2^10
```

```
## [1] 1024
```

``` r
sqrt(81)
```

```
## [1] 9
```

``` r
round(exp(1), 4)
```

```
## [1] 2.7183
```

O mesmo em Python (`**` no lugar de `^`, e as funções matemáticas vêm do módulo `math`):

```python
2 + 2
(10 - 4) / 3
2 ** 10
import math
math.sqrt(81)
round(math.e, 4)
```

## Leitura de dados

`read_csv`/`read.csv` (R) e `pd.read_csv` (Python) fazem o mesmo trabalho: abrir um arquivo de
texto separado por vírgulas e organizar em uma tabela (`data.frame`/`tibble` em R, `DataFrame` em
Python). A base `empresas` usada no Capítulo 1 inteiro:


``` r
empresas <- read_csv("data/empresas.csv", show_col_types = FALSE)
glimpse(empresas)
```

```
## Rows: 106
## Columns: 11
## $ Empresa       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1…
## $ constituicao  <chr> "Ltda.", "S.A.", "Ltda.", "Ltda.", "Ltda.", "S.A.", "Ind…
## $ porte         <chr> "Pequena", "Média", "Grande", "Média", "Pequena", "Grand…
## $ empregados99  <dbl> 9, 31, 119, 35, 6, 46, 23, 162, 7, 6, 34, 243, 35, 7, 13…
## $ faturamento98 <dbl> 64302, 177330, 449546, 200223, 86559, 413846, 208081, 43…
## $ faturamento99 <dbl> 74392, 251488, 369409, 230843, 98436, 408905, 226582, 39…
## $ idade         <dbl> 15, 5, 21, 12, 18, 25, 12, 19, 24, 9, 35, 3, 37, 3, 42, …
## $ cidade        <chr> "São Paulo", "Rio de Janeiro", "Salvador", "Salvador", "…
## $ atividade     <chr> "Artigos para embalagens e acondicionamento", "Artigos p…
## $ setor         <chr> "Embalagens", "Embalagens", "Outros", "Embalagens", "Man…
## $ regiao        <chr> "sudeste", "sudeste", "nordeste", "nordeste", "nordeste"…
```

```python
import pandas as pd
empresas = pd.read_csv("empresas.csv")
empresas.info()
```

## Funções

Uma função dá nome a um cálculo repetido, um exemplo já visto no Capítulo 1, o coeficiente de
variação:


``` r
cv <- function(x) {
  100 * sd(x) / mean(x)
}
cv(empresas$faturamento99)
```

```
## [1] 31.64911
```

A mesma função em Python:

```python
import numpy as np

def cv(x):
    return 100 * np.std(x, ddof=1) / np.mean(x)

cv(empresas["faturamento99"])
```

Em ambas: um nome (`cv`), um ou mais argumentos entre parênteses (`x`), um corpo que calcula algo
e devolve (`return` em Python é explícito; em R, o valor da última linha já é o retorno).

## Loops

Um `for` repete a mesma tarefa para vários valores, por exemplo, o quadrado dos números de 1 a 5:


``` r
for (i in 1:5) {
  print(i^2)
}
```

```
## [1] 1
## [1] 4
## [1] 9
## [1] 16
## [1] 25
```

O mesmo em Python (a indentação substitui as chaves `{ }` do R):

```python
for i in range(1, 6):
    print(i ** 2)
```

Em R, `sapply()`/`purrr::map()` costumam substituir o loop explícito com menos código, mas o `for`
é a base que funciona em qualquer linguagem.

## Números aleatórios

`set.seed()` fixa a "semente" do sorteio, sem ela, cada execução dá um resultado diferente, e os
laboratórios de simulação do curso (Aulas 13 e 22, Capítulo 2 e 3) dependem dessa reprodutibilidade:


``` r
set.seed(42)
runif(5, min = 0, max = 1)     # 5 valores Uniforme(0,1)
```

```
## [1] 0.9148060 0.9370754 0.2861395 0.8304476 0.6417455
```

``` r
rnorm(5, mean = 0, sd = 1)     # 5 valores Normal(0,1)
```

```
## [1]  0.04788474 -1.10459944  0.53902380  0.58020632 -0.65750284
```

``` r
sample(1:6, size = 3)          # sorteia 3 números de 1 a 6, sem repetir
```

```
## [1] 5 4 2
```

O mesmo em Python, com `numpy`:

```python
import numpy as np
rng = np.random.default_rng(42)
rng.uniform(0, 1, size=5)
rng.normal(0, 1, size=5)
rng.choice(range(1, 7), size=3, replace=False)
```

## Gráficos básicos

Os quatro gráficos do Capítulo 1, na versão mais direta de cada linguagem (R base; o curso usa
`ggplot2` no restante do livro, mais flexível, mas com mais sintaxe):


``` r
plot(empresas$faturamento98, empresas$faturamento99,
     xlab = "Faturamento 1998", ylab = "Faturamento 1999",
     main = "Dispersão: faturamento 1998 x 1999", pch = 19, col = "#0d3b54")
```

<img src="05-ferramentas-rpython_files/figure-html/grafico-dispersao-1.png" alt="" width="672" style="display: block; margin: auto;" />

```python
import matplotlib.pyplot as plt
plt.scatter(empresas["faturamento98"], empresas["faturamento99"])
plt.xlabel("Faturamento 1998"); plt.ylabel("Faturamento 1999")
plt.title("Dispersão: faturamento 1998 x 1999")
plt.show()
```


``` r
hist(empresas$faturamento99,
     main = "Histograma do faturamento (1999)",
     xlab = "Faturamento 1999 (R$)", col = "#c9971e")
```

<img src="05-ferramentas-rpython_files/figure-html/grafico-histograma-1.png" alt="" width="672" style="display: block; margin: auto;" />

```python
plt.hist(empresas["faturamento99"], color="#c9971e")
plt.title("Histograma do faturamento (1999)")
plt.xlabel("Faturamento 1999 (R$)")
plt.show()
```

Pizza e barras, na mesma base de setores usada na abertura do Capítulo 1 (Seção
\@ref(tabelas-graficos)):


``` r
setor_freq <- table(trimws(empresas$setor))
pie(setor_freq, main = "Empresas por setor (pizza)")
```

<img src="05-ferramentas-rpython_files/figure-html/grafico-pizza-1.png" alt="" width="672" style="display: block; margin: auto;" />

```python
setor_freq = empresas["setor"].str.strip().value_counts()
plt.pie(setor_freq, labels=setor_freq.index)
plt.title("Empresas por setor (pizza)")
plt.show()
```


``` r
par(mar = c(12, 4, 3, 1))
barplot(sort(setor_freq, decreasing = TRUE),
        main = "Empresas por setor (barras)", las = 2, cex.names = 0.85, col = "#0d3b54")
```

<img src="05-ferramentas-rpython_files/figure-html/grafico-barras-base-1.png" alt="" width="672" style="display: block; margin: auto;" />

```python
setor_freq.sort_values(ascending=False).plot(kind="bar", color="#0d3b54")
plt.title("Empresas por setor (barras)")
plt.show()
```

Como já visto no Capítulo 1, é bem mais fácil comparar os setores na barra do que na pizza, isso
vale tanto em R quanto em Python, o problema é do tipo de gráfico, não da linguagem.

## Para continuar estudando, de graça

```{=html}
<div class="caixa-aplicacao"><strong>R</strong>
<ul>
<li><a href="https://r4ds.hadley.nz/">R for Data Science (r4ds.hadley.nz)</a> — o livro-texto de
referência do tidyverse, gratuito, online, em inglês.</li>
<li><a href="https://swirlstats.com/">swirl</a> — aprende R dentro do próprio R, respondendo
exercícios no console (<code>install.packages("swirl")</code>).</li>
<li><a href="https://curso-r.com/">Curso-R</a> — comunidade brasileira, material introdutório em
português.</li>
<li><a href="https://www.coursera.org/learn/r-programming">Coursera: R Programming (Johns
Hopkins)</a> — gratuito no modo "somente assistir" (audit).</li>
</ul>
</div>
```

```{=html}
<div class="caixa-aplicacao"><strong>Python</strong>
<ul>
<li><a href="https://www.kaggle.com/learn">Kaggle Learn</a> — micro-cursos gratuitos e práticos:
Python, Pandas, introdução a Machine Learning, SQL.</li>
<li><a href="https://automatetheboringstuff.com/">Automate the Boring Stuff with Python</a> —
livro completo gratuito online, ótimo para quem nunca programou.</li>
<li><a href="https://www.coursera.org/specializations/python">Coursera: Python for Everybody
(Univ. Michigan)</a> — também gratuito em modo audit.</li>
<li>freeCodeCamp (canal no YouTube) tem cursos completos de Python e de R, gravados, gratuitos,
do zero ao avançado.</li>
</ul>
</div>
```

Plataformas pagas (Udemy, cursos com certificado no Coursera) funcionam bem como complemento, mas
não são necessárias para acompanhar o curso, tudo que se precisa está nos laboratórios e nos links
gratuitos acima.
