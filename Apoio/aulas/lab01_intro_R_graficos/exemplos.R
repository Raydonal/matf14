
data("chickwts")

?chickwts

names(chickwts)

chickwts$feed
chickwts$weight

tab_alimento <- table(chickwts$feed)

barplot(tab_alimento)

barplot(tab_alimento, main = "Número de galinhas segundo o tipo de alimento recebido")

barplot(tab_alimento, horiz = TRUE)
pie(tab_alimento)

hist(chickwts$weight)

hist(chickwts$weight, main = "Peso das galinhas após seis semanas", 
     ylab = "Frequência absoluta",
     xlab = "Frequência relativa")


data("AirPassengers")
AirPassengers

data("discoveries")
?discoveries
which.max(discoveries)

plot(discoveries)


data("LakeHuron")
LakeHuron
plot(LakeHuron)

#####

df_lattes <- read.csv('../../../Dados/dados_base_lattes/multidisciplinar_ufba_lattes.csv',
                      header = TRUE, fileEncoding = "UTF-8")
head(df_lattes)

# Respostas dos exercícios

class(df_lattes$.Área..Atuação.)
df_lattes$.Área..Atuação.[6]

df_lattes$.Área..Atuação.[10] != df_lattes$.Área..Atuação.[11]

class(df_lattes)

View(df_lattes)

df_lattes$.Setor.de.Atividade..Atuação.

# Exemplo de gráfico de barras
tb_raca <- table(df_lattes$.Cor.ou.Raça)
tb_raca
barplot(tb_raca)

tb_sexo <- table(df_lattes$.Sexo)
tb_sexo
pie(tb_sexo)

pie(tb_sexo, col = c('yellow', 'red'), labels = "")
legend("topright", legend = names(tb_sexo), fill = c('yellow', 'red'))

# exemplo variável quantitativa

df_cafe <- read.csv('ipeadata_producao_cafe_ton.csv', header = TRUE)
View(df_cafe)

df_cafe$X2022

hist(df_cafe$X2022)

# consumo de energia (MWh)

# Energia elétrica - consumo final energia - residência - quantidade
# Fonte: Ministério de Minas e Energia, Balanço Energético Nacional (MME)
# Frequência: Anual de 1961 até 2023
# Unidade: MWh

df_energia <- read.csv('ipeadata_consumo_energia.csv', header = TRUE, dec = ',')
View(df_energia)

df_energia$consumo_energia_2023

hist(df_energia$consumo_energia_2023)
hist(log(df_energia$consumo_energia_2023))

# USA Arrest

data("USArrests")
?USArrests
View(USArrests)
USArrests$Murder

hist(USArrests$Murder)
