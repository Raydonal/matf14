
# Valores possíveis da variável aleatória
x <- 1:6

# Probabilidade de cada valor (distribuição uniforme discreta)
p <- rep(1/6, 6)

# Função de distribuição acumulada
Fx <- cumsum(p)

# Plot da função de distribuição acumulada (FDA)
png(file="fda_lancamento_dado.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
plot(c(0, x, 7), c(0, Fx, 1), type = "s", lwd = 2, col = "blue",
     xlab = "x", ylab = expression(F(x)),
     main = "Função de Distribuição Acumulada",
     ylim = c(0, 1), cex.lab=2, cex.main=1.5)

# Linhas horizontais pontilhadas para facilitar visualização
abline(h = Fx, v = x, col = "gray80", lty = 3)

# Adicionar pontos nos degraus
points(x, Fx, pch = 19, col = "blue", cex=2)
points(x, c(0, Fx[1:5]), pch = 19, col = "white", cex=2)
points(x, c(0, Fx[1:5]), pch = 1, col = "blue", cex=2)
dev.off()  




###############################################################################


# Valores possíveis da variável aleatória
x <- 1:4

# Probabilidade de cada valor (distribuição uniforme discreta)
p <- c(.25, .5, .125, .125)

# Função de distribuição acumulada
Fx <- cumsum(p)

# Plot da função de distribuição acumulada (FDA)
png(file="fda_exercicio.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
plot(c(0, x, 5), c(0, Fx, 1), type = "s", lwd = 2, col = "blue",
     xlab = "x", ylab = expression(F(x)),
     main = "Função de Distribuição Acumulada",
     ylim = c(0, 1), cex.lab=2, cex.main=1.5)

# Linhas horizontais pontilhadas para facilitar visualização
abline(h = Fx, v = x, col = "gray80", lty = 3)

# Adicionar pontos nos degraus
points(x, Fx, pch = 19, col = "blue", cex=2)
points(x, c(0, Fx[1:3]), pch = 19, col = "white", cex=2)
points(x, c(0, Fx[1:3]), pch = 1, col = "blue", cex=2)
dev.off()  



###############################################################################

y = rbeta(1000, 2, 1)

png(file="hist_fdp_beta_2_1.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
hist(y, xlim=c(-0.2, 1.2), probability = TRUE, 
     main = "Histograma de uma amostra de X",
     ylab = "Densidade", xlab = "x", cex.lab=1.5, cex.main=1.5)
x = seq(-0.2, 1.2,length=1000)
lines(x, dbeta(x, 2, 1), col='red', lwd=2)
# legend("topleft", legend = "densidade f(x)=2x", fill = 'red', bty='n', cex=1.5)
dev.off() 


png(file="fda_beta_2_1.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
plot(x, pbeta(x, 2, 1), type='l', col='red', lwd=3,
     main = "f.d.a. de X",
     ylab = "F(x)", xlab = "x", cex.lab=1.5, cex.main=1.5)
dev.off() 


png(file="fda_beta_1_2.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
plot(x, pbeta(x, 1, 2), type='l', col='red', lwd=3,
     main = "f.d.a. de X",
     ylab = "F(x)", xlab = "x", cex.lab=1.5, cex.main=1.5)
dev.off() 





###############################################################################

y = runif(1000, 0, 1)

png(file="hist_fdp_unif01.png", 
    width=600, height=500, res = 100)
par(mar = c(5,5,3,1), mgp = c(2.5, 1, 0))
hist(y, xlim=c(-0.2, 1.2), ylim=c(0, 1.4), probability = TRUE, 
     main = "Amostra com 1000 valores de Unif(0,1)",
     ylab = "Densidade", xlab = "x", cex.lab=1.5, cex.main=1.5)
x = seq(-0.2, 1.2,length=1000)
lines(x, dunif(x, 0, 1), col='red', lwd=3)
abline(v=0.5, col="blue", lwd=3)
legend("topright", legend=c('densidade', 'média'), 
       fill=c('red', 'blue'), bty='n', cex=1.5)
dev.off()


###############################################################################

alpha <- 2
beta  <- 7

x <- seq(alpha - 1, beta + 1, length = 1000)

# fdp da Uniforme
fdp <- dunif(x, min = alpha, max = beta)

png(file="fdp_unif27.png", 
    width=600, height=500, res = 100)
plot(x, fdp, type = "l", lwd = 3, ylim=c(0,0.3),
     main = "Função Densidade de prob. Unif(2, 7)",
     xlab = "x", ylab = "f(x)", cex.lab=1.5, cex.main=1.5)
abline(h = c(0, 0.2), col = "gray", lty=3)
dev.off()

# fda da Uniforme
fda <- punif(x, min = alpha, max = beta)

png(file="fda_unif27.png", 
    width=600, height=500, res = 100)
plot(x, fda, type = "l", lwd = 3,
     main = "Função de distribuição acumulada Unif(2, 7)",
     xlab = "x", ylab = "F(x)", cex.lab=1.5, cex.main=1.5)
abline(h = c(0,1), col = "gray", lty = 3)
dev.off()

