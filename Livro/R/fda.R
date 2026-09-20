# Gráfico de função de distribuição acumulada de VA discreta, com bolinhas cheias (valor assumido)
# e vazias (limite pela esquerda), no padrão das notas do Prof. Rodney.
suppressPackageStartupMessages(library(ggplot2))
fda_plot <- function(k, p, xlim = c(min(k) - 1, max(k) + 1), cor = "#1f3fbf", rotulo_y = TRUE) {
  F <- cumsum(p)
  xs <- c(xlim[1], k)
  xe <- c(k, xlim[2])
  ys <- c(0, F)
  deg <- data.frame(x = xs, xend = xe, y = ys)
  saltos <- data.frame(x = k, y0 = c(0, head(F, -1)), y1 = F)
  g <- ggplot() +
    geom_segment(data = deg, aes(x = x, xend = xend, y = y, yend = y), color = cor, linewidth = 1) +
    geom_segment(data = saltos, aes(x = x, xend = x, y = y0, yend = y1), color = cor, linetype = "dotted") +
    geom_point(data = saltos, aes(x, y0), shape = 21, fill = "white", color = cor, size = 3) +
    geom_point(data = saltos, aes(x, y1), color = cor, size = 3) +
    scale_x_continuous(breaks = seq(floor(xlim[1]), ceiling(xlim[2]), 1)) +
    scale_y_continuous(limits = c(0, 1.02), breaks = seq(0, 1, 0.25)) +
    labs(x = "x", y = "F(x)") + theme_minimal(base_size = 14)
  if (rotulo_y) g <- g + geom_text(data = saltos, aes(x + 0.08, y1, label = format(round(y1, 3), decimal.mark = ",")),
                                   hjust = 0, vjust = -0.6, size = 4)
  g
}
