# Baixa dados oficiais (IBGE e BCB) para os exemplos de contas nacionais do livro e dos slides.
# Extraído em 17/09/2026. Saída: CSVs em ./saida/
suppressPackageStartupMessages({library(jsonlite); library(readxl); library(dplyr); library(tidyr)})
dir.create("saida", showWarnings = FALSE)
ibge <- function(tabela, periodos, variaveis, localidades = "N1[all]", classificacao = NULL) {
  url <- paste0("https://servicodados.ibge.gov.br/api/v3/agregados/", tabela, "/periodos/", periodos,
                "/variaveis/", variaveis, "?localidades=", localidades,
                if (!is.null(classificacao)) paste0("&classificacao=", classificacao) else "")
  url <- utils::URLencode(url)
  x <- fromJSON(url, simplifyVector = FALSE)
  out <- list()
  for (v in x) for (r in v$resultados) {
    cat_nome <- if (length(r$classificacoes)) unlist(r$classificacoes[[1]]$categoria)[[1]] else NA
    for (s in r$series) for (p in names(s$serie))
      out[[length(out) + 1]] <- data.frame(variavel_id = v$id, variavel = v$variavel, unidade = v$unidade,
                                           categoria = cat_nome, localidade = s$localidade$nome,
                                           periodo = p, valor = suppressWarnings(as.numeric(s$serie[[p]])))
  }
  bind_rows(out)
}
trims <- function(a1, a2) paste(as.vector(t(outer(a1:a2, sprintf("%02d", 1:4), paste0))), collapse = "|")

# 1. PIB trimestral a preços correntes (tabela 1846), 2019T1–2026T2
t1846 <- ibge(1846, trims(2019, 2026), 585, classificacao = "11255[all]") |> filter(!is.na(valor))
write.csv(transmute(t1846, trimestre = periodo, componente = categoria, valor_milhoes = valor),
          "saida/pib_trimestral_correntes.csv", row.names = FALSE)

# 2. Taxas de variação do PIB e componentes (tabela 5932), 1996T1–2026T2
t5932 <- ibge(5932, trims(1996, 2026), "6561|6562|6563|6564",
              classificacao = "11255[90707,90687,90691,90696,93404,93405,93406,93407,93408]") |> filter(!is.na(valor))
write.csv(transmute(t5932, trimestre = periodo, componente = categoria, taxa = variavel, valor_pct = valor),
          "saida/pib_trimestral_taxas.csv", row.names = FALSE)

# 3. Índice de volume com ajuste sazonal (tabela 1621), PIB
t1621 <- ibge(1621, trims(1996, 2026), 584, classificacao = "11255[90707]") |> filter(!is.na(valor))
write.csv(transmute(t1621, trimestre = periodo, indice = valor), "saida/pib_indice_dessaz.csv", row.names = FALSE)

# 4. Contas econômicas trimestrais (tabela 2072), 2000T1–2026T2
t2072 <- ibge(2072, trims(2000, 2026), "933|934|935|936|937|938|939|940|941|6596|942|943") |> filter(!is.na(valor))
write.csv(transmute(t2072, trimestre = periodo, conta = variavel, valor_milhoes = valor),
          "saida/contas_economicas_trimestrais.csv", row.names = FALSE)

# 5. PIB por UF (tabela 5938), 2021 e 2023, e população estimada 2021 (tabela 6579)
t5938 <- ibge(5938, "2021|2023", "37|498|543|513|517|6575|525", localidades = "N3[all]")
uf <- t5938 |> transmute(ano = periodo, uf = localidade,
                         var = recode(variavel_id, `37` = "pib", `498` = "va_total", `543` = "impostos",
                                      `513` = "va_agro", `517` = "va_industria", `6575` = "va_servicos",
                                      `525` = "va_adm_publica"), valor_mil = valor) |>
  pivot_wider(names_from = var, values_from = valor_mil)
pop <- ibge(6579, "2021", 9324, localidades = "N3[all]") |> transmute(ano = periodo, uf = localidade, populacao = valor)
regiao_de <- c("Rondônia" = "Norte", "Acre" = "Norte", "Amazonas" = "Norte", "Roraima" = "Norte", "Pará" = "Norte",
  "Amapá" = "Norte", "Tocantins" = "Norte", "Maranhão" = "Nordeste", "Piauí" = "Nordeste", "Ceará" = "Nordeste",
  "Rio Grande do Norte" = "Nordeste", "Paraíba" = "Nordeste", "Pernambuco" = "Nordeste", "Alagoas" = "Nordeste",
  "Sergipe" = "Nordeste", "Bahia" = "Nordeste", "Minas Gerais" = "Sudeste", "Espírito Santo" = "Sudeste",
  "Rio de Janeiro" = "Sudeste", "São Paulo" = "Sudeste", "Paraná" = "Sul", "Santa Catarina" = "Sul",
  "Rio Grande do Sul" = "Sul", "Mato Grosso do Sul" = "Centro-Oeste", "Mato Grosso" = "Centro-Oeste",
  "Goiás" = "Centro-Oeste", "Distrito Federal" = "Centro-Oeste")
uf <- uf |> left_join(pop, by = c("ano", "uf")) |> mutate(regiao = regiao_de[uf]) |> relocate(regiao, .after = uf)
write.csv(uf, "saida/pib_uf.csv", row.names = FALSE)

# 6. PIB anual sob as três óticas (tabela sinótica 5 do SCN 2023), 2019–2023
x <- read_excel("cn/tab05.xls"  # baixe de ftp.ibge.gov.br/Contas_Nacionais/Sistema_de_Contas_Nacionais/2023/tabelas_xls/sinoticas/, col_names = FALSE, .name_repair = "minimal")
hdr <- gsub("\n", " ", unlist(x[5, ]))
item <- trimws(gsub("\n\\s*", " ", x[[1]]))
otica <- NA; linhas <- list()
for (i in 6:nrow(x)) {
  if (is.na(item[i])) next
  if (grepl("^A - ", item[i])) { otica <- "produção"; next }
  if (grepl("^B - ", item[i])) { otica <- "despesa"; next }
  if (grepl("^C - ", item[i])) { otica <- "renda"; next }
  if (grepl("^Fonte|^\\(1\\)", item[i])) break
  for (a in 2019:2023) {
    j <- which(hdr == paste(a, "valor corrente"))
    linhas[[length(linhas) + 1]] <- data.frame(otica = otica, item = item[i], ano = a,
                                               valor_milhoes = suppressWarnings(as.numeric(x[[j]][i])))
  }
}
write.csv(bind_rows(linhas), "saida/pib_oticas_anual.csv", row.names = FALSE)

# 7. Matriz de insumo-produto 2015, nível 12: coeficientes técnicos (tab. 14) e Leontief (tab. 15)
le_matriz <- function(aba) {
  m <- read_excel("cn/Matriz_de_Insumo_Produto_2015_Nivel_12.xls"  # ftp.ibge.gov.br/Contas_Nacionais/Matriz_de_Insumo_Produto/2015/, sheet = aba, col_names = FALSE, .name_repair = "minimal")
  lin <- which(m[[1]] %in% sprintf("%02d", 1:12))
  setor <- m[[2]][lin]
  vals <- as.data.frame(lapply(m[lin, 3:14], as.numeric))
  names(vals) <- setor
  data.frame(setor = setor, vals, check.names = FALSE)
}
write.csv(le_matriz("14"), "saida/mip2015_coeficientes_tecnicos.csv", row.names = FALSE)
write.csv(le_matriz("15"), "saida/mip2015_leontief.csv", row.names = FALSE)

# 8. Agregados monetários (BCB/SGS), mensal, R$ mil, saldo em final de período
bcb <- function(codigo, nome, inicio = "01/01/2010") {
  d <- fromJSON(paste0("https://api.bcb.gov.br/dados/serie/bcdata.sgs.", codigo, "/dados?formato=json&dataInicial=", inicio))
  data.frame(data = as.Date(d$data, "%d/%m/%Y"), serie = nome, codigo = codigo, valor = as.numeric(d$valor))
}
mon <- bind_rows(bcb(1788, "base_monetaria"), bcb(27789, "papel_moeda_publico"), bcb(27790, "depositos_vista"),
                 bcb(27791, "M1"), bcb(27810, "M2"), bcb(27813, "M3"), bcb(27815, "M4"))
write.csv(mon, "saida/agregados_monetarios.csv", row.names = FALSE)

# 9. IPCA, variação mensal (BCB/SGS 433), desde 2000
ipca <- bcb(433, "ipca_mensal", "01/01/2000")
write.csv(transmute(ipca, data, ipca_mensal_pct = valor), "saida/ipca_mensal.csv", row.names = FALSE)

cat("ok\n")
for (f in list.files("saida", full.names = TRUE)) cat(f, nrow(read.csv(f)), "linhas\n")
