# (APPENDIX) Apêndices {-}

# Revisão de Cálculo {#revisao-de-calculo}



O Capítulo \@ref(variaveis-aleatorias-continuas) generaliza esperança, variância e função de
distribuição acumulada para variáveis aleatórias contínuas, e isso exige trocar somatórios
($\sum$) por integrais ($\int$). Este apêndice revisa o mínimo de cálculo diferencial e integral
necessário para acompanhar esse capítulo, sem pressupor um curso de Cálculo prévio completo.

## Por que integrais aparecem em probabilidade

No caso discreto, $P(X\in A) = \sum_{x_i\in A} p(x_i)$: soma-se a "massa" de probabilidade em cada
ponto. No caso contínuo, um único ponto tem probabilidade zero ($P(X=x)=0$ para todo $x$, um fato
formalizado no Capítulo 4), a probabilidade só se acumula em **intervalos**, e a ferramenta natural
para "somar uma quantidade que varia continuamente ao longo de um intervalo" é a integral.

## Derivadas: o essencial

A **derivada** de $f$ em $x$, $f'(x)$, mede a taxa de variação instantânea de $f$ naquele ponto,
a inclinação da reta tangente ao gráfico de $f$ em $x$.


Table: (\#tab:tabela-derivadas)Regras de derivação usadas neste curso

|Função               |Derivada             |
|:--------------------|:--------------------|
|$f(x)=c$ (constante) |$f'(x)=0$            |
|$f(x)=x^n$           |$f'(x)=nx^{n-1}$     |
|$f(x)=e^x$           |$f'(x)=e^x$          |
|$f(x)=\ln(x)$        |$f'(x)=1/x$          |
|$f(x)=c\cdot g(x)$   |$f'(x)=c\cdot g'(x)$ |
|$f(x)=g(x)+h(x)$     |$f'(x)=g'(x)+h'(x)$  |

```{=html}
<div class="caixa-economia"><strong>Leitura econômica</strong>, em Economia, a derivada é a
formalização de "marginal": receita marginal é a derivada da função de receita; custo marginal, a
derivada da função de custo. A mesma ferramenta usada aqui para variáveis aleatórias contínuas é a
que sustenta praticamente todo o vocabulário de otimização em microeconomia.</div>
```

```{=html}
<div class="caixa-discussao"><strong>Para discutir</strong>

<p><strong>1.</strong> Se o custo marginal de produzir uma unidade adicional é a derivada da
função custo, o que significa, em termos econômicos, o ponto onde essa derivada é igual a zero?
Isso é sempre um "bom" ponto de operação para uma empresa?</p>

<p><strong>2.</strong> No Capítulo 4, a derivada de $F$ (FDA) será a própria densidade $f$. Antes
de chegar lá: por que faz sentido que a \emph{taxa de variação} da probabilidade acumulada em um
ponto seja interpretada como "quão concentrada" a probabilidade está ali? Pense no que significa
$F$ crescer rápido versus devagar em torno de um ponto $x$.</p>
</div>
```

## Integrais: o essencial

A **integral definida** $\int_a^b f(x)\,dx$ é, geometricamente, a área **líquida** (positiva
acima do eixo $x$, negativa abaixo) entre o gráfico de $f$ e o eixo $x$, no intervalo $[a,b]$.

<img src="05-revisao-calculo_files/figure-html/area-exemplo-1.png" alt="" width="480" style="display: block; margin: auto;" />

A área sombreada é exatamente $\int_a^b f(x)\,dx$, o mesmo desenho, refeito aqui com a mesma
paleta usada nas aulas em sala (área sob a curva entre $a$ e $b$, com a região $A$ identificada).

### Soma de Riemann: de onde vem a integral

A integral é definida como o limite de uma **soma de retângulos** cada vez mais finos aproximando
a área sob a curva:

<img src="05-revisao-calculo_files/figure-html/riemann-1.png" alt="" width="499.2" style="display: block; margin: auto;" />

Cada retângulo tem base $\Delta x = x_{i}-x_{i-1}$ e altura $f(x_{i-1})$, a soma das áreas dos
retângulos aproxima $\int_a^b f(x)\,dx$, e a aproximação melhora à medida que $n$ (o número de
retângulos) cresce e $\Delta x$ encolhe.

$$
\int_a^b f(x)\,dx = \lim_{n\to\infty} \sum_{i=1}^n f(x_i^*)\,\Delta x, \qquad \Delta x = \frac{b-a}{n}.
$$

Quanto mais fina a partição (mais retângulos, $\Delta x$ menor), melhor a soma de retângulos
aproxima a área exata sob a curva, a mesma lógica intuitiva por trás do histograma com classes
cada vez mais estreitas se aproximando de uma curva de densidade suave (retomado no Cap. 4).

### Teorema Fundamental do Cálculo (versão prática)

Se $F$ é uma **primitiva** de $f$ (isto é, $F'(x)=f(x)$), então

$$
\int_a^b f(x)\,dx = F(b) - F(a).
$$


Table: (\#tab:tabela-integrais)Primitivas usadas nos modelos do Capítulo 4

|Função                 |Primitiva                              |
|:----------------------|:--------------------------------------|
|$f(x)=c$               |$F(x)=cx$                              |
|$f(x)=x^n$ ($n\ne -1$) |$F(x)=\dfrac{x^{n+1}}{n+1}$            |
|$f(x)=e^{\lambda x}$   |$F(x)=\dfrac{1}{\lambda}e^{\lambda x}$ |


``` r
# integral de f(x) = x^2 entre 0 e 2, pelo Teorema Fundamental
F <- function(x) x^3 / 3
F(2) - F(0)
```

```
## [1] 2.666667
```

``` r
# conferindo numericamente
integrate(function(x) x^2, lower = 0, upper = 2)
```

```
## 2.666667 with absolute error < 3e-14
```

```{=html}
<div class="caixa-r"><strong>Uso do R</strong>, <code>integrate()</code> calcula integrais
definidas numericamente, sem precisar encontrar a primitiva à mão, útil para conferir contas do
Capítulo 4, mas o exame ainda exige saber calcular as primitivas simples da tabela acima
manualmente.</div>
```

### Integrais impróprias (intervalo infinito)

Algumas distribuições contínuas (como a Normal, Capítulo 4) têm suporte em toda a reta real. A
integral correspondente é uma **integral imprópria**:

$$
\int_{-\infty}^{\infty} f(x)\,dx = \lim_{a\to-\infty}\lim_{b\to\infty} \int_a^b f(x)\,dx.
$$

Para as funções de densidade que usaremos, esse limite sempre existe e vale exatamente 1, a
versão contínua de $\sum_i p(x_i)=1$.

## Exercício de fixação

Calcule $\displaystyle\int_0^1 3x^2\,dx$ e confira com `integrate()` em R. (Resposta: a primitiva de
$3x^2$ é $x^3$, logo o valor é $1^3-0^3=1$, não por coincidência, essa é exatamente a integral que
confirma que $f(x)=3x^2$, $0\le x\le 1$, é uma densidade de probabilidade válida, um exemplo
retomado no Capítulo 4.)
