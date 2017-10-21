setwd("C:\\Users\\guilo\\Google Drive\\IMPACTA\\AULAS\\ANÁLISE EXPLORATÓRIA DE DADOS\\TRABALHOS\\Population")
population <- read.table("POPULATION_KEY_INDICATORS.csv", header = TRUE, sep = ";")

#RESPOSTA A: 
Rank20MANat <- subset((population[which(population$Time >= 1990 & population$Time <= 2014),]))
Rank20MANat <- cbind(mean(Rank20MANat$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.))

mean(Rank20MANat$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN., na.rm = TRUE)

typeof(Rank20MANat$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.)

is.numeric(Rank20MANat$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.)


Rank20MANat <- Rank20MANat[order(mean(Rank20MANat$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.), decreasing = TRUE),]
Rank20MANat <- subset(Rank20MANat[1:50,])

View(Rank20MANat)


#RESPOSTA B:




#RESPOSTA C: RANKING DE 50 PAÍSES
#Subsets; Population & Order Population
Rank50paises <- subset((population[which(population$Time == 2014),c(1,5)]))
Rank50paises <- Rank50paises[order(Rank50paises$Population..total..SP.POP.TOTL., decreasing = TRUE),]
Rank50paises <- subset(Rank50paises[1:50,])

#Renomeia os campos
names(Rank50paises) <- c("Paises", "Populacao Total")

#Visualiza a Tabela
View(Rank50paises)
