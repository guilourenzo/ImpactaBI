setwd("C:\\Users\\guilo\\Google Drive\\IMPACTA\\AULAS\\ANÁLISE EXPLORATÓRIA DE DADOS\\TRABALHOS\\Population")
population_key <- read.table("POPULATION_KEY_INDICATORS.csv", header = TRUE, sep = ";")
library("taRifx")


#RESPOSTA A: 
#Subset based on TIME
pop1990_to_2014 <- subset((population_key[which(population_key$Time >= 1990 & population_key$Time <= 2014),]))

View(pop1990_to_2014)

#Subset based on Country, Time and Birth Rate
popCountry_and_BirthRate <- subset(pop1990_to_2014[,c("Country.Name","Time","Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.")],!is.na(pop1990_to_2014$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.))

View(popCountry_and_BirthRate)

#Calculate Mean
popMean_by_Country_and_BirthRate <- aggregate(popCountry_and_BirthRate$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN. ~ popCountry_and_BirthRate$Country.Name, popCountry_and_BirthRate, mean )
names(popMean_by_Country_and_BirthRate) <- c("Country","Mean")
View(popMean_by_Country_and_BirthRate)

#Subset the top 20 Medians
RankTOP20Means <- popMean_by_Country_and_BirthRate[order(popMean_by_Country_and_BirthRate$Mean, decreasing = TRUE),]
RankTOP20Means <- subset(RankTOP20Means[1:20,])
View(RankTOP20Means)

#RESPOSTA B:
RankBOTTON20Means <- popMean_by_Country_and_BirthRate[order(popMean_by_Country_and_BirthRate$Mean, decreasing = FALSE),]
RankBOTTON20Means <- subset(RankBOTTON20Means[1:20,])
View(RankBOTTON20Means)

#RESPOSTA C: RANKING DE 50 PAÍSES
#Subsets; Population & Order Population
Rank50paises <- subset((population[which(population$Time == 2014),c(1,5)]))
Rank50paises <- Rank50paises[order(Rank50paises$Population..total..SP.POP.TOTL., decreasing = TRUE),]
Rank50paises <- subset(Rank50paises[1:50,])
#Rename Fields
names(Rank50paises) <- c("Paises", "Populacao Total")
View(Rank50paises)

#RESPOSTA D:

#RESPOSTA E:

