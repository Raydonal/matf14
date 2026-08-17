# Fórmulário e tabelas de referência {#formulario}



Este apêndice reúne, por capítulo, todas as fórmulas do curso, o mesmo material que acompanha as
provas oficiais, para consulta e revisão. Não traz explicação ou contexto (isso está nos capítulos
correspondentes); é só referência rápida.

## Capítulo 1: Estatística Descritiva

**Frequências.** Para $f_i$ casos na categoria $i$, $n=\sum_i f_i$:
$$
p_i = \frac{f_i}{n} \qquad \%_i = 100\times\frac{f_i}{n}\,\%
$$

**Tendência central.**
$$
\bar x = \frac1n\sum_{i=1}^n x_i \qquad
\text{Mediana} = \begin{cases} x_{((n+1)/2)}, & n \text{ ímpar} \\
\dfrac{x_{(n/2)}+x_{(n/2+1)}}{2}, & n \text{ par}\end{cases}
$$

**Dispersão.**
$$
AT = x_{\max}-x_{\min} \qquad IQR = Q_3-Q_1 \qquad
\mathrm{Var}(X) = \frac1n\sum_{i=1}^n (x_i-\bar x)^2 \qquad dp(X)=\sqrt{\mathrm{Var}(X)}
$$
$$
CV(X) = \frac{dp(X)}{\bar x} \qquad \text{outlier (boxplot): } x < Q_1-1{,}5\,IQR \text{ ou } x>Q_3+1{,}5\,IQR
$$

**Correlação, assimetria, curtose.**
$$
r = \frac{\sum_i (x_i-\bar x)(y_i-\bar y)}{\sqrt{\sum_i(x_i-\bar x)^2}\sqrt{\sum_i(y_i-\bar y)^2}}
\qquad
\text{Assimetria} = \frac{\frac1n\sum_i(x_i-\bar x)^3}{\mathrm{Var}(X)^{3/2}}
\qquad
\text{Curtose} = \frac{\frac1n\sum_i(x_i-\bar x)^4}{\mathrm{Var}(X)^2}
$$

## Capítulo 2: Probabilidade

$$
P(A^c)=1-P(A) \qquad P(A\cup B) = P(A)+P(B)-P(A\cap B)
$$
$$
P(A) = \frac{\#A}{\#\Omega}\ \text{(equiprovável)} \qquad
\binom{n}{k} = \frac{n!}{k!(n-k)!}
$$
$$
P(A\mid B) = \frac{P(A\cap B)}{P(B)} \qquad P(A\cap B)=P(A)P(B)\mid_{\text{indep.}}
$$
$$
P(A) = \sum_{i=1}^k P(A\mid B_i)P(B_i) \qquad
P(B_i\mid A) = \frac{P(A\mid B_i)P(B_i)}{\sum_{j=1}^k P(A\mid B_j)P(B_j)}
$$

## Capítulo 3: Variáveis Aleatórias Discretas

$$
E(X)=\sum_i x_i p(x_i) \qquad \mathrm{Var}(X)=\sum_i(x_i-\mu)^2p(x_i) \qquad F(x)=\sum_{x_i\le x}p(x_i)
$$
$$
E(aX+b)=aE(X)+b \qquad \mathrm{Var}(aX+b)=a^2\mathrm{Var}(X)
$$
$$
E(X+Y)=E(X)+E(Y) \qquad \mathrm{Var}(X+Y)=\mathrm{Var}(X)+\mathrm{Var}(Y)\mid_{\text{indep.}}
$$


Table: (\#tab:tabela-discretas)Modelos discretos

|Distribuição       |p(x)                            |E(X)      |Var(X)    |
|:------------------|:-------------------------------|:---------|:---------|
|Bernoulli(p)       |$p^x(1-p)^{1-x}$, $x\in\{0,1\}$ |$p$       |$p(1-p)$  |
|Binomial(n,p)      |$\binom{n}{x}p^x(1-p)^{n-x}$    |$np$      |$np(1-p)$ |
|Poisson($\lambda$) |$e^{-\lambda}\lambda^x/x!$      |$\lambda$ |$\lambda$ |

## Capítulo 4: Variáveis Aleatórias Contínuas

$$
P(a\le X\le b)=\int_a^b f(x)dx \qquad \int_{-\infty}^\infty f(x)dx=1
$$
$$
E(X)=\int_{-\infty}^\infty x f(x)dx \qquad \mathrm{Var}(X)=\int_{-\infty}^\infty(x-\mu)^2f(x)dx
$$
$$
F(x) = \int_{-\infty}^x f(t)dt \qquad F'(x)=f(x) \qquad Z=\frac{X-\mu}{\sigma}\sim N(0,1)
$$


Table: (\#tab:tabela-continuas)Modelos contínuos

|Distribuição           |f(x)                                                  |E(X)      |Var(X)       |
|:----------------------|:-----------------------------------------------------|:---------|:------------|
|Uniforme(a,b)          |$1/(b-a)$, $a\le x\le b$                              |$(a+b)/2$ |$(b-a)^2/12$ |
|Normal($\mu,\sigma^2$) |$\frac{1}{\sigma\sqrt{2\pi}}e^{-(x-\mu)^2/2\sigma^2}$ |$\mu$     |$\sigma^2$   |

**Regra empírica (Normal):** $P(\mu\pm\sigma)\approx68{,}3\%$;
$P(\mu\pm2\sigma)\approx95{,}4\%$; $P(\mu\pm3\sigma)\approx99{,}7\%$.

## Apêndice A: Cálculo (resumo)

$$
\frac{d}{dx}c=0 \quad \frac{d}{dx}x^n=nx^{n-1} \quad \frac{d}{dx}e^x=e^x
$$
$$
\int c\,dx=cx+k \quad \int x^n dx=\frac{x^{n+1}}{n+1}+k\ (n\ne-1) \quad \int e^{\lambda x}dx=\frac{1}{\lambda}e^{\lambda x}+k
$$

## Tabela: valores selecionados da Normal padrão


Table: (\#tab:tabela-normal)Valores de referência da FDA da Normal padrão

|     z| P(Z ≤ z)| P(Z > z)|
|-----:|--------:|--------:|
| 0.500|   0.6915|   0.3085|
| 0.674|   0.7498|   0.2502|
| 1.000|   0.8413|   0.1587|
| 1.282|   0.9001|   0.0999|
| 1.645|   0.9500|   0.0500|
| 1.960|   0.9750|   0.0250|
| 2.000|   0.9772|   0.0228|
| 2.326|   0.9900|   0.0100|
| 2.576|   0.9950|   0.0050|
| 3.000|   0.9987|   0.0013|

Para qualquer outro valor de $z$, use `pnorm(z)` em R, esta tabela cobre apenas os percentis mais
cobrados em prova (mediana, quartis, 90º/95º/99º percentis e a regra empírica).
