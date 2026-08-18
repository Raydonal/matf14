# Variáveis Aleatórias Discretas {#variaveis-aleatorias-discretas}



Os Capítulos 1 e 2 trataram de dados observados e de probabilidades de eventos. Este capítulo
introduz o conceito que une os dois: a **variável aleatória**, uma função que associa um número a
cada resultado de um experimento aleatório, permitindo calcular médias e variâncias de quantidades
*ainda incertas*, exatamente como fizemos no Capítulo 1 para dados já observados. A diferença é
sutil e importante: no Capítulo 1, $\bar x$ e $\mathrm{Var}(X)$ resumiam uma amostra já coletada;
aqui, $E(X)$ e $\mathrm{Var}(X)$ descrevem um **modelo probabilístico**, o que se espera *antes* de
observar o resultado.

```{=html}
<div class="caixa-discussao"><strong>Para discutir: antes de qualquer fórmula</strong>

<p><strong>1.</strong> Uma seguradora conhece a distribuição histórica do número de sinistros por
apólice ao longo de um ano. Ela sabe, hoje, quantos sinistros uma apólice específica vai gerar este
ano? O que ela sabe, então, e por que isso ainda é útil para fixar o valor do prêmio?</p>

<p><strong>2.</strong> Pense em três variáveis aleatórias discretas do seu interesse (finanças,
mercado de trabalho, política pública). Para cada uma, diga rapidamente qual seria um valor
"esperado" plausível, mesmo sem calcular nada ainda, essa intuição será formalizada ao longo do
capítulo.</p>
</div>
```

## Conceituação de variável aleatória discreta {#va-discreta-conceito}

Uma **variável aleatória (VA)** $X$ é uma função que associa um número real a cada resultado
$\omega$ de um espaço amostral $\Omega$. É **discreta** quando assume valores em um conjunto finito
ou enumerável $\{x_1, x_2, x_3, \ldots\}$.

A **função de probabilidade** (ou função de massa de probabilidade) de $X$ é

$$
p(x_i) = P(X = x_i),
$$

satisfazendo $p(x_i) \ge 0$ para todo $i$ e $\sum_i p(x_i) = 1$, o análogo, para um modelo
probabilístico, da propriedade de frequências relativas somarem 1 (Capítulo 1).

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação: número de sinistros em uma apólice</strong>: uma
seguradora de automóveis modela $X=$ "número de sinistros registrados por uma apólice em um ano",
com histórico sugerindo a distribuição:</div>
```


``` r
sinistros <- tibble(x = 0:4, p = c(0.60, 0.25, 0.10, 0.04, 0.01))
sum(sinistros$p)   # deve ser 1
```

```
## [1] 1
```

``` r
sinistros |> kbl(col.names = c("x (nº de sinistros)", "p(x)")) |> kable_styling(full_width = FALSE)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> x (nº de sinistros) </th>
   <th style="text-align:right;"> p(x) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.60 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

<img src="03-va-discretas_files/figure-html/grafico-fmp-1.png" alt="" width="672" style="display: block; margin: auto;" />

```{=html}
<div class="caixa-discussao"><strong>Para discutir</strong>

<p><strong>1.</strong> Verifique, sem olhar a soma já calculada, que os cinco valores de $p(x)$
somam 1. O que aconteceria se um analista, ao construir essa tabela a partir de dados históricos,
esquecesse uma categoria rara (por exemplo, "5 ou mais sinistros")? A tabela ainda seria uma função
de probabilidade válida?</p>

<p><strong>2.</strong> A tabela mostra $P(X=0)=0{,}60$: 60% das apólices não registram nenhum
sinistro no ano. Isso significa que 60% dos segurados "não precisavam" do seguro? Que erro de
raciocínio (relevante para precificação de seguros) essa conclusão cometeria?</p>
</div>
```

## Esperança e variância {#va-discreta-esperanca-variancia}

### Definição

A **esperança** (ou valor esperado, ou média) de uma VA discreta $X$ é

$$
E(X) = \mu = \sum_{i} x_i\, p(x_i),
$$

uma **média ponderada** dos valores possíveis de $X$, com pesos dados pelas próprias
probabilidades, o análogo probabilístico da média aritmética do Capítulo 1, mas ponderada por
$p(x_i)$ em vez de por frequência relativa observada $f_i/n$.

A **variância** mede a dispersão de $X$ em torno de $E(X)$:

$$
\mathrm{Var}(X) = \sigma^2 = E\big[(X-\mu)^2\big] = \sum_i (x_i-\mu)^2\, p(x_i).
$$

O **desvio padrão** é $\sigma = \sqrt{\mathrm{Var}(X)}$.


``` r
mu <- sum(sinistros$x * sinistros$p)
var_x <- sum((sinistros$x - mu)^2 * sinistros$p)
c(E_X = mu, Var_X = var_x, dp_X = sqrt(var_x))
```

```
##       E_X     Var_X      dp_X 
## 0.6100000 0.7979000 0.8932525
```

```{=html}
<div class="caixa-economia"><strong>Leitura econômica</strong>, $E(X)\approx
0.61$ sinistros por apólice ao ano é exatamente o número que a seguradora usa para
precificar o prêmio puro (antes de margens e custos administrativos): se ela cobrar um prêmio
proporcional a esse valor, no agregado de milhares de apólices semelhantes, as mensalidades cobrem,
em média, o custo dos sinistros pagos, a lógica de precificação atuarial inteira nasce dessa
conta.</div>
```

### Propriedades da esperança e da variância

Para constantes $a, b$ e variáveis aleatórias $X, Y$:

$$
E(aX+b) = aE(X)+b \qquad\qquad \mathrm{Var}(aX+b) = a^2\,\mathrm{Var}(X).
$$

$$
E(X+Y) = E(X)+E(Y) \quad\text{(sempre)} \qquad\qquad
\mathrm{Var}(X+Y) = \mathrm{Var}(X)+\mathrm{Var}(Y) \quad\text{(se $X,Y$ independentes)}.
$$

Note que $\mathrm{Var}(aX+b)=a^2\mathrm{Var}(X)$, o deslocamento $b$ não afeta a dispersão (faz
sentido: somar uma constante desloca todos os valores igualmente, sem mudar o espalhamento), mas o
fator de escala $a$ afeta a variância ao quadrado, um eco direto da propriedade de invariância de
escala que já vimos para o coeficiente de variação no Capítulo 1.

```{=html}
<div class="caixa-discussao"><strong>Para discutir: o bloco mais denso do capítulo</strong>

<p><strong>1.</strong> $E(X+Y)=E(X)+E(Y)$ vale \emph{sempre}, mesmo se $X$ e $Y$ forem
dependentes; já a fórmula da variância da soma só vale sob independência (o caso geral inclui um
termo de covariância, fora do escopo deste curso). Por que faz sentido que a esperança "não
perceba" dependência, mas a variância sim? Pense no que a covariância mede intuitivamente, ela
aparece quando $X$ e $Y$ tendem a se mover juntos.</p>

<p><strong>2.</strong> Uma seguradora com 10.000 apólices semelhantes usa $E(X_1+\cdots+X_{10000})
=\sum_i E(X_i)$ para obter o número esperado total de sinistros da carteira, mesmo sem assumir que
as apólices são independentes entre si. Por que essa soma de esperanças continua válida mesmo se,
digamos, todas as apólices tendessem a sofrer mais sinistros num ano de crise econômica (evento que
as tornaria dependentes entre si)?</p>

<p><strong>3.</strong> Se a mesma seguradora quisesse calcular a \emph{variância} do número total
de sinistros da carteira, a fórmula $\mathrm{Var}(X_1+\cdots+X_{10000})=\sum_i\mathrm{Var}(X_i)$
continuaria válida no cenário de dependência do item anterior? O que isso implica sobre o risco
real da carteira em anos de crise, comparado ao que a fórmula simplificada (assumindo
independência) prediria?</p>
</div>
```

## Função de distribuição acumulada {#va-discreta-fda}

A **função de distribuição acumulada (FDA)** de $X$ é

$$
F(x) = P(X \le x) = \sum_{x_i \le x} p(x_i).
$$

Para uma VA discreta, $F$ é uma função **em escada**: constante entre os valores possíveis de $X$,
com um salto de tamanho $p(x_i)$ em cada $x_i$.


``` r
sinistros <- sinistros |> mutate(F = cumsum(p))
sinistros |> kbl(col.names = c("x", "p(x)", "F(x)")) |> kable_styling(full_width = FALSE)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> x </th>
   <th style="text-align:right;"> p(x) </th>
   <th style="text-align:right;"> F(x) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.60 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.85 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.99 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 1.00 </td>
  </tr>
</tbody>
</table>

<img src="03-va-discretas_files/figure-html/grafico-fda-1.png" alt="" width="672" style="display: block; margin: auto;" />

A FDA permite responder perguntas de intervalo diretamente: $P(X \le 2) = F(2) = 0{,}95$;
$P(X > 2) = 1 - F(2) = 0{,}05$; $P(X \ge 2) = 1 - F(1) = 1-0{,}85=0{,}15$ (atenção ao "$\ge$" vs.
"$>$" em variáveis discretas, a diferença de um ponto importa, ao contrário do caso contínuo do
Capítulo 4).

<div class="figure" style="text-align: center">
<img src="images/fda_lancamento_dado.png" alt="FDA do resultado do lançamento de um dado honesto: seis saltos de tamanho 1/6, uma escada perfeitamente regular." width="65%" />
<p class="caption">(\#fig:fig-fda-dado)FDA do resultado do lançamento de um dado honesto: seis saltos de tamanho 1/6, uma escada perfeitamente regular.</p>
</div>

O caso mais simples de FDA em escada é o de um dado honesto: seis saltos, todos do mesmo tamanho
$1/6$, refletindo a distribuição uniforme discreta $p(x)=1/6$ para $x\in\{1,\ldots,6\}$. Compare
com a FDA dos sinistros acima: lá, os saltos têm tamanhos diferentes (proporcionais a cada
$p(x_i)$), porque a distribuição não é uniforme.

```{=html}
<div class="caixa-discussao"><strong>Para discutir</strong>

<p><strong>1.</strong> Explique, em palavras, por que $P(X\ge2)$ usa $F(1)$ e não $F(2)$ na
fórmula acima. Em que ponto exatamente $1-F(2)$ e $1-F(1)$ diferem, e o que cada expressão
representa?</p>

<p><strong>2.</strong> Se você só tivesse a FDA $F(x)$ (não a tabela $p(x)$), como recuperaria
$p(x_i)$ a partir dela? Escreva a fórmula geral.</p>
</div>
```

## Alguns modelos probabilísticos {#modelos-discretos}

### Distribuição de Bernoulli

Modela um experimento com exatamente dois resultados: "sucesso" ($X=1$, probabilidade $p$) ou
"fracasso" ($X=0$, probabilidade $1-p$). É a VA discreta mais simples e o bloco de construção da
Binomial.

$$
p(x) = p^x(1-p)^{1-x}, \quad x\in\{0,1\} \qquad E(X)=p \qquad \mathrm{Var}(X)=p(1-p).
$$

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação</strong>, "um cliente aprovado para crédito
inadimple no primeiro ano" é uma Bernoulli com $p=$ taxa de inadimplência histórica daquele
segmento.</div>
```

<div class="figure" style="text-align: center">
<img src="images/pesquisa_celular.jpg" alt="86% dos brasileiros apoiam restrição de celular nas escolas, segundo pesquisa Datafolha/Agência Brasil." width="70%" />
<p class="caption">(\#fig:fig-pesquisa-celular)86% dos brasileiros apoiam restrição de celular nas escolas, segundo pesquisa Datafolha/Agência Brasil.</p>
</div>

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação: de pesquisa de opinião a Binomial</strong>. Se
86% da população realmente apoia a medida ($p=0{,}86$), e uma nova amostra de 20 pessoas for
entrevistada, o número $X$ de entrevistados favoráveis segue $X\sim\text{Bin}(20;\,0{,}86)$: soma
de 20 Bernoullis independentes, uma por entrevistado, cada uma valendo 1 se a pessoa apoia e 0 caso
contrário. É exatamente essa Binomial que, mais adiante em disciplinas de inferência, permite
calcular a margem de erro de uma pesquisa de opinião a partir do tamanho da amostra.</div>
```

### Distribuição Binomial

Se $X_1,\ldots,X_n$ são Bernoulli($p$) **independentes** (mesma probabilidade $p$ em cada
tentativa), então $X=\sum_{i=1}^n X_i$ (número total de sucessos em $n$ tentativas) segue uma
**distribuição Binomial** com parâmetros $n$ e $p$, notação $X\sim \text{Bin}(n,p)$:

$$
p(x) = \binom{n}{x} p^x (1-p)^{n-x}, \quad x=0,1,\ldots,n
\qquad E(X)=np \qquad \mathrm{Var}(X)=np(1-p).
$$

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação: inadimplência em uma carteira pequena</strong>:
um microcrédito tem 20 tomadores independentes, cada um com probabilidade de inadimplência
$p=0{,}08$. $X=$ número de inadimplentes na carteira segue $\text{Bin}(20; 0{,}08)$.</div>
```


``` r
n <- 20; p <- 0.08
x <- 0:n
fmp <- dbinom(x, size = n, prob = p)

E_X <- n*p; Var_X <- n*p*(1-p)
c(E_X = E_X, Var_X = Var_X)
```

```
##   E_X Var_X 
## 1.600 1.472
```

``` r
# probabilidade de mais de 3 inadimplentes
1 - pbinom(3, size = n, prob = p)
```

```
## [1] 0.07061518
```

<img src="03-va-discretas_files/figure-html/grafico-binomial-1.png" alt="" width="672" style="display: block; margin: auto;" />

`dbinom()` calcula $p(x)$; `pbinom()` calcula $F(x)=P(X\le x)$, funções análogas existem para
todas as distribuições nativas do R (prefixo `d` para densidade/massa, `p` para acumulada, `q` para
quantil, `r` para gerar valores aleatórios).

```{=html}
<div class="caixa-discussao"><strong>Para discutir</strong>

<p><strong>1.</strong> A Binomial exige quatro condições: número de tentativas $n$ fixo, apenas
dois resultados por tentativa, probabilidade $p$ constante, e tentativas independentes. Para
"número de clientes que cancelam um plano de assinatura este mês, entre 1.000 clientes", qual
dessas quatro condições é mais provável de ser violada na prática (por exemplo, se um concorrente
lançar uma promoção agressiva no meio do mês)? O que aconteceria com a variância real da carteira
se essa condição falhasse, comparado com o que a fórmula $\mathrm{Var}(X)=np(1-p)$ prevê?</p>

<p><strong>2.</strong> $E(X)=np$: dobrar $n$ dobra o número esperado de sucessos; dobrar $p$
também dobra $E(X)$. O efeito sobre $\mathrm{Var}(X)=np(1-p)$ é o mesmo nos dois casos? Calcule
para confirmar.</p>
</div>
```

### Distribuição de Poisson

Modela o número de ocorrências de um evento raro em um intervalo fixo de tempo ou espaço, quando
os eventos ocorrem de forma independente a uma taxa média constante $\lambda$:

$$
p(x) = \frac{e^{-\lambda}\lambda^x}{x!}, \quad x=0,1,2,\ldots
\qquad E(X)=\lambda \qquad \mathrm{Var}(X)=\lambda.
$$

Uma propriedade notável: **média e variância são iguais**, se a variância observada de uma
contagem for muito maior que a média (fenômeno chamado de *superdispersão*), o modelo Poisson puro
tende a ser inadequado, um diagnóstico rápido muito usado em modelagem de contagens econômicas.

```{=html}
<div class="caixa-economia"><strong>Leitura econômica</strong>, a Poisson é o modelo padrão para
"número de transações fraudulentas detectadas por dia", "número de aberturas de empresas por mês em
um município pequeno", ou "número de chamadas a uma central de atendimento por hora", contagens
raras e aproximadamente independentes ao longo do tempo. É também a base de modelos de
sinistralidade em seguros (número de sinistros por apólice, retomando o exemplo da Seção
\@ref(va-discreta-conceito)) e de modelos de contagem em econometria aplicada
(@wooldridge2016introducao).</div>
```

A Poisson também aproxima bem a Binomial quando $n$ é grande, $p$ é pequeno, e $np=\lambda$ é
moderado, útil quando se conhece a taxa média de um evento raro, mas não o "$n$" e o "$p$"
separadamente que o gerariam.

<div class="figure" style="text-align: center">
<img src="images/noticia_acidentes.jpg" alt="PRF registra 165 mortes em rodovias federais na semana do Natal de 2024, ante 90 mortes no mesmo período de 2023." width="65%" />
<p class="caption">(\#fig:fig-noticia-acidentes)PRF registra 165 mortes em rodovias federais na semana do Natal de 2024, ante 90 mortes no mesmo período de 2023.</p>
</div>

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação: mortes no trânsito como contagem Poisson</strong>.
O número de mortes em rodovias federais durante uma semana específica é uma contagem de eventos
raros ocorrendo de forma aproximadamente independente ao longo do tempo, exatamente o retrato de
uma Poisson. A notícia contrasta 165 mortes na semana do Natal de 2024 com 90 no mesmo período de
2023, quase o dobro: sob um modelo Poisson com taxa $\lambda$ estimada pelo histórico da própria
semana em anos anteriores, esse salto exige perguntar se $\lambda$ de fato mudou (mais tráfego,
menos fiscalização) ou se é apenas variação natural em torno de uma mesma taxa média, a mesma
lógica de diagnóstico de superdispersão discutida acima.</div>
```

<div class="figure" style="text-align: center">
<img src="images/noticia_gols.jpg" alt="PSG 5 x 4 Bayern: recorde de gols em uma partida de ida de semifinal da Champions League (abril de 2026)." width="65%" />
<p class="caption">(\#fig:fig-noticia-gols)PSG 5 x 4 Bayern: recorde de gols em uma partida de ida de semifinal da Champions League (abril de 2026).</p>
</div>

```{=html}
<div class="caixa-aplicacao"><strong>Aplicação: gols em uma partida</strong>. O número de gols de
um time em uma partida é outro exemplo clássico de contagem Poisson: muitas chances raras de gol ao
longo de 90 minutos, cada uma com probabilidade pequena de se concretizar, somando-se numa taxa
média $\lambda$ (gols esperados) que depende da qualidade ofensiva dos times. Uma partida com 9
gols somados é um evento na cauda direita dessa distribuição, raro, mas não surpreendente o
suficiente para descartar o modelo: é justamente esse tipo de evento extremo que os modelos de "gols
esperados" (xG), usados por clubes e casas de apostas, tentam calibrar a partir de $\lambda$.</div>
```


``` r
lambda <- 3.2   # nº médio de chamadas por minuto numa central
x <- 0:12
fmp_pois <- dpois(x, lambda)

# probabilidade de receber mais de 6 chamadas em um minuto
1 - ppois(6, lambda)
```

```
## [1] 0.0446191
```

<img src="03-va-discretas_files/figure-html/grafico-poisson-1.png" alt="" width="672" style="display: block; margin: auto;" />

```{=html}
<div class="caixa-r"><strong>Uso do R</strong>, para as três distribuições desta seção, o R segue
o mesmo padrão de nomes: <code>dbinom/pbinom/qbinom/rbinom</code> e
<code>dpois/ppois/qpois/rpois</code> (e, para Bernoulli, basta usar
<code>dbinom(x, size=1, prob=p)</code>, não há função dedicada, pois Bernoulli é só a Binomial com
$n=1$).</div>
```

```{=html}
<div class="caixa-discussao"><strong>Para discutir: síntese do capítulo</strong>

<p><strong>1.</strong> Compare as condições de aplicabilidade de Bernoulli, Binomial e Poisson.
Para "número de sinistros de apólices de uma seguradora em um ano" (o exemplo de abertura do
capítulo), qual dos três modelos parece mais adequado, e por quê?</p>

<p><strong>2.</strong> Se a variância observada de uma contagem real for muito maior que a sua
média (superdispersão), isso invalida o uso de $E(X)$ como estimativa útil do "valor esperado", ou
só invalida o uso da fórmula $\mathrm{Var}(X)=\lambda$ da Poisson para a dispersão? A distinção
importa para decisões de precificação de seguro?</p>

<p><strong>3.</strong> Retome a Discussão de abertura do capítulo (pergunta 1, sobre a seguradora
"saber" quantos sinistros uma apólice específica vai gerar). Depois de todo o capítulo, reformule
sua resposta com o vocabulário formal agora disponível: esperança, variância, FDA.</p>
</div>
```

## Fechando o capítulo

Este capítulo tratou de contagens: sucessos discretos, sinistros, inadimplências, chamadas. O
Capítulo \@ref(variaveis-aleatorias-continuas) estende os mesmos conceitos, esperança, variância,
FDA, para variáveis que podem assumir qualquer valor real em um intervalo, como tempo, renda ou
taxa de retorno, exigindo a ferramenta do cálculo integral revisada no Apêndice
\@ref(revisao-de-calculo).
