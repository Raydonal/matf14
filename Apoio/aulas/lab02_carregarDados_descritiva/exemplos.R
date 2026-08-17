
install.packages("readxls")

library(readxl)
require(readxl)

empresas <- readxl::read_xls('empresa.xls', header = TRUE)

empresas <- read.csv('empresa.csv', header = TRUE)
View(empresas)
class(empresas)

table(empresas$Porte.da.Empresa)


hist(empresas$faturamento_anual_1998, ylim = c(0, 45),
     main = 'Faturamento das empresas',
     ylab = 'Frequência', xlab = 'Faturamento', col='blue')
hist(empresas$faturamento_anual_1999, col=rgb(1, 0, 0, 0.5), add = TRUE)
legend('topright', title = 'Anos', legend = c('1998', '1999'), 
       fill = c('blue', rgb(1, 0, 0, 0.5)))

boxplot(empresas$tempo_existencia, xlim = c(0.7, 1.2), ylim=c(0,50))
text(0.75, quantile(empresas$tempo_existencia, 0.25), 'Q1')
text(0.75, quantile(empresas$tempo_existencia, 0.5), 'Q2')
text(0.75, quantile(empresas$tempo_existencia, 0.75), 'Q3')
dif_interquartil <- quantile(empresas$tempo_existencia, 0.75) - quantile(empresas$tempo_existencia, 0.25)
#text(0.75, quantile(empresas$tempo_existencia, 0.75) + 1.5*dif_interquartil, 'LS')
#text(0.75, quantile(empresas$tempo_existencia, 0.25) - 1.5*dif_interquartil, 'LS')
text(0.75, max(empresas$tempo_existencia), 'LS')
text(0.75, min(empresas$tempo_existencia), 'LI')


x = c(2, 43, 30, 32, 45, 50, 38, 58, 49, 52, 66,  70)
boxplot(x, xlim = c(0.7, 1.2), range = 1.5, ylim=c(0,90))
text(0.75, quantile(x, 0.25), 'Q1')
text(0.75, quantile(x, 0.5), 'Q2')
text(0.75, quantile(x, 0.75), 'Q3')
dif_interquartil <- quantile(x, 0.75) - quantile(x, 0.25)
text(0.75, as.numeric(quantile(x, 0.75) + 1.5*dif_interquartil), 'LS')
text(0.75, quantile(x, 0.25) - 1.5*dif_interquartil, 'LI')
text(0.75, max(x), 'LS')
text(0.75, min(x), 'LI')

boxplot(empresas$faturamento_anual_1998, 
        empresas$faturamento_anual_1999,
        names = c('1998', '1999'), ylab="Faturamento")

