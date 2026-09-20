# Diagramas de Venn simples para os slides (ggplot2 + ggforce).
# venn(regiao, circulos, rotulos): `regiao` é uma função(inA, inB, inC) -> lógico que define a área
# pintada; `circulos` um data.frame com x0, y0, r, nome; `pontos` rótulos opcionais (x, y, lab).
suppressPackageStartupMessages({library(ggplot2); library(ggforce)})
venn <- function(regiao, circulos, pontos = NULL, titulo = NULL, cor = "#f4e04d") {
  g <- expand.grid(x = seq(0, 10, length.out = 400), y = seq(0, 6, length.out = 240))
  dentro <- lapply(seq_len(nrow(circulos)), function(i)
    (g$x - circulos$x0[i])^2 + (g$y - circulos$y0[i])^2 <= circulos$r[i]^2)
  while (length(dentro) < 3) dentro[[length(dentro) + 1]] <- rep(FALSE, nrow(g))
  g$pinta <- regiao(dentro[[1]], dentro[[2]], dentro[[3]])
  p <- ggplot() +
    geom_raster(data = g[g$pinta, ], aes(x, y), fill = cor) +
    annotate("rect", xmin = 0, xmax = 10, ymin = 0, ymax = 6, fill = NA, color = "#2a7fb8", linewidth = 1) +
    geom_circle(data = circulos, aes(x0 = x0, y0 = y0, r = r), color = "#2a7fb8", linewidth = 0.9, inherit.aes = FALSE) +
    geom_text(data = circulos, aes(x = x0 + c(-1, 1, 0)[seq_len(nrow(circulos))] * r * 0.75,
                                   y = y0 + r + 0.3, label = nome), size = 6, fontface = "italic") +
    annotate("text", x = 9.6, y = 5.6, label = "S", size = 6, fontface = "italic") +
    coord_fixed(xlim = c(0, 10), ylim = c(0, 6), expand = FALSE) + theme_void()
  if (!is.null(pontos)) p <- p + geom_text(data = pontos, aes(x, y, label = lab), size = 6)
  if (!is.null(titulo)) p <- p + ggtitle(titulo) + theme(plot.title = element_text(hjust = 0.5, size = 18))
  p
}
dois <- data.frame(x0 = c(3.9, 6.1), y0 = c(2.9, 2.9), r = c(1.8, 1.8), nome = c("A", "B"))
