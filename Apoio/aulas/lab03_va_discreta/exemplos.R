
#############################################
# REVISÃO DE VETORES E MATRIZES

# vetor em R
x = c(1,4,3, -2)
x
# acessando elemento do vetor
x[2]
# operações com o vetor
2*x
x^2
# aplicando funções no vetor
sum(x)



#############################################
# Exemplo com Bernoulli

p = 0.3
sample(c(0,1), 10, replace = TRUE, prob = c(1-p, p))

n = 100
x = sample(c(0,1), n, replace = TRUE, prob = c(1-p, p))
table(x)

mean(x)
p

var(x)
p*(1-p)

hist(x, prob=TRUE, breaks = 2)

#############################################
# LOOPS/LAÇO

for (i in 1:5) {
  print(i)
}

x = 0
for (i in 1:10) {
  x = x + 1
}
x

x = rep(0, 8)
for (i in 1:10) {
  x[i] = sample(c(1:20), size = 1)
}
x

#############################################
# Exemplo com Binomial

n = 5
p = 0.7
x = c(0:n)
prob_x = rep(0,n+1)
for (i in 1:(n+1)) {
  k = x[i]
  prob_x[i] = choose(n, k)*(p^k)*((1-p)^(n-k))
}
prob_x

dbinom(x, n, p)

sum(prob_x)

pbinom(x, n, p)

y = rbinom(20, n, p)
table(y)


rep = 1000
y = rbinom(rep, n, p)
table(y)/rep
dbinom(x, n, p)

mean(y)
n*p

var(y)
n*p*(1-p)


hist(y, prob=TRUE, breaks = n+1)

x = seq(0,n+1, length=100)
fda = pbinom(x, n, p)
plot(x, fda, type='l')



#############################################
# Exemplo com Poisson

exp(1)
exp(5)

factorial(4)
4*3*2*1
factorial(10)


l = 5
x = c(0:10)

prob_x = rep(0,11)
for (i in 1:11){
  k = x[i]
  prob_x[i] = exp(-l)*(l^k)/factorial(k)
}
prob_x
round(prob_x, 4)
dpois(x, l)

sum(prob_x)

ppois(x, l)
plot(x, ppois(x, l))

x = seq(0,10, length=100)
fda = ppois(x, l)
plot(x, fda, type='l')


rep = 10
y = rpois(rep, l)
table(y)


rep = 1000
y = rpois(rep, l)
table(y)/rep
round(dpois(0:12, l), 3)

hist(y, prob=TRUE)

mean(y)
var(y)

# aproximação da binomial pela Poisson

n = 100
p = 0.05

lambda = n*p

round(dbinom(0:10, n, p), 4)
round(dpois(0:10, lambda), 4)

x = c(0:30)
plot(x, dbinom(x, n, p), pch=19)
points(x, dpois(x, lambda), pch=8, col='red')

########
# geração de variáveis aleatórias com sample

rep = 100
y = sample(c(1,2,3,4), rep, c(.1, .4, .3, .2), replace=TRUE)
mean(y)
var(y)

mean(y+10)
mean(y*10)

var(y+10)
var(y*10)


