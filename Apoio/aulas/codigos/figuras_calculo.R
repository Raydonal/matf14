
# área sob curva

# Função da curva
f <- function(x){
  0.15*(x-1)^3 + 2
}

# Intervalo
a <- 1
b <- 5

# Sequência de pontos
x <- seq(a, b, length = 500)
y <- f(x)

# Limites do gráfico
ylim <- c(0, max(y) + 1)

png(file="area_sob_funcao.png", 
    width=600, height=500, res = 100)
# Criando o gráfico vazio
plot(0, 0,
     type = "n",
     xlim = c(-0.5, 6),
     ylim = ylim,
     xlab = "x",
     ylab = "y",
     axes = FALSE)
# Eixos
arrows(-0.3, 0, 5.8, 0, length = 0.08)
arrows(0, -0.2, 0, ylim[2], length = 0.08)
# Área sombreada
polygon(c(a, x, b),
        c(0, y, 0),
        col = "#d8bfd8",
        border = NA)
# Curva
lines(x, y, col = "purple4", lwd = 2)
# Linhas verticais em a e b
segments(a, 0, a, f(a), lwd = 1.5, col = "gray30")
segments(b, 0, b, f(b), lwd = 1.5, col = "gray30")
# Marcações no eixo x
text(a, -0.2, "a")
text(b, -0.2, "b")
# Nome da função
text(b + 0.2, f(b), "f(x)", col = "black")
# Letras dos eixos
text(5.9, -0.1, "x")
text(-0.1, ylim[2], "y")
# Letra dentro da área
text((a+b)/2, 1.8, "A")
#
dev.off()

##########################

# Função constante

# Parâmetros
a <- 1
b <- 5
k <- 4

png(file="area_funcao_constante.png", 
    width=600, height=500, res = 100)
# Criando gráfico vazio
plot(0, 0,
     type = "n",
     xlim = c(-0.5, 6),
     ylim = c(-0.5, 5.5),
     xlab = "",
     ylab = "",
     axes = FALSE)
# Eixos com setas
arrows(-0.3, 0, 5.8, 0, length = 0.08)
arrows(0, -0.2, 0, 5.3, length = 0.08)
# Retângulo sombreado
polygon(c(a, a, b, b),
        c(0, k, k, 0),
        col = "#d8bfd8",
        border = NA)
# Linhas verticais em a e b
segments(a, 0, a, 5.1, lwd = 1.2)
segments(b, 0, b, 5.1, lwd = 1.2)
# Linha horizontal y = k
segments(0, k, b, k,
         lty = 2,
         col = "gray40")
# Topo da função constante
segments(a, k, b, k,
         col = "purple4",
         lwd = 2)
# Textos
text(a, -0.2, "a")
text(b, -0.2, "b")
text(-0.15, k, "k")
text(5.35, k + 0.1, "f(x)")
text(5.9, -0.05, "x")
text(-0.1, 5.35, "y")
# Letra dentro da área
text((a+b)/2, k/2, "A", cex = 1.3)
#
dev.off()

##########################

# Soma de Rieman

# Função
f <- function(x){
  0.06*x^2 + 1.5
}

# Intervalo
a <- 1
b <- 10

# Número de subintervalos
n <- 12

# Pontos da partição
x <- seq(a, b, length.out = n + 1)

# Alturas dos retângulos (extremo esquerdo)
h <- f(x[-(n+1)])

# Curva suave
xc <- seq(a, b, length = 500)
yc <- f(xc)

png(file="soma_rieman.png", 
    width=600, height=500, res = 100)
# Criando gráfico vazio
plot(0, 0,
     type = "n",
     xlim = c(-0.8, 11),
     ylim = c(-0.5, max(yc) + 2),
     xlab = "",
     ylab = "",
     axes = FALSE)

# Eixos com setas
arrows(0, 0, 10.8, 0, length = 0.08)
arrows(0, 0, 0, max(yc)+1.7, length = 0.08)
# Curva
lines(xc, yc,
      col = "purple4",
      lwd = 2)
# Retângulos da soma de Riemann
for(i in 1:n){
  # Retângulo
  rect(x[i], 0, x[i+1], h[i],
       border = "gray30",
       col = rgb(0.85, 0.75, 0.85, 0.35))
  
  # Linha tracejada vertical
  segments(x[i+1], 0, x[i+1], h[i],
           lty = 2,
           col = "gray50")
  
  # Segmento horizontal superior
  segments(x[i], h[i], x[i+1], h[i],
           lwd = 1.2)
}
# Marcas especiais no eixo x
text(a, -0.25, expression(x[0] == a), cex = 0.9)
text(x[2], -0.25, expression(x[1]), cex = 0.9)
text(x[3], -0.25, expression(x[2]), cex = 0.9)
text(x[5], -0.25,
     expression(x[i-1]~~x[i]),
     cex = 0.9)
text(x[n]-.1, -0.25,
     expression(x[n-1]),
     cex = 0.9)
text(b+.1, -0.25,
     expression(x[n] == b),
     cex = 0.9)
# Linha horizontal tracejada em f(x_i)
xi <- x[5]
yi <- f(xi)
segments(0, yi, xi, yi,
         lty = 2,
         col = "gray40")
text(-0.4, yi,
     expression(f(x[i])),
     cex = 0.9)
# Texto da função
text(9.2, f(9.2)+0.6,
     "f(x)",
     cex = 1)
# Letras dos eixos
text(10.9, -0.05, "x")
text(-0.1, max(yc)+1.8, "y")
#
dev.off()


