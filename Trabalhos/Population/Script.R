setwd("C:\\Users\\guilo\\Google Drive\\IMPACTA\\AULAS\\ANÁLISE EXPLORATÓRIA DE DADOS\\TRABALHOS\\Population")
population_key <- read.table("POPULATION_KEY_INDICATORS.csv", header = TRUE, sep = ";")
continents <- read.table("CONTINENTS.csv", header = TRUE, sep = ";")
View(population_key)

#OPTIONS
#SCIENTIFIC NUMBER
options(scipen=0)

#Cleaning NA
population_key$Population.ages.0.14....of.total...SP.POP.0014.TO.ZS.[population_key$Population.ages.0.14....of.total...SP.POP.0014.TO.ZS. == ""] <- NA
population_key$Population.ages.15.64....of.total...SP.POP.1564.TO.ZS.[population_key$Population.ages.15.64....of.total...SP.POP.1564.TO.ZS. == ""] <- NA
population_key$Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS.[population_key$Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS. == ""] <- NA
population_key$Age.dependency.ratio..young....of.working.age.population...SP.POP.DPND.YG.[population_key$Age.dependency.ratio..young....of.working.age.population...SP.POP.DPND.YG. == ""] <- NA
population_key$Age.dependency.ratio..old....of.working.age.population...SP.POP.DPND.OL.[population_key$Age.dependency.ratio..old....of.working.age.population...SP.POP.DPND.OL. == ""] <- NA
population_key$Death.rate..crude..per.1.000.people...SP.DYN.CDRT.IN.[population_key$Death.rate..crude..per.1.000.people...SP.DYN.CDRT.IN. == ""] <- NA
population_key$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN.[population_key$Birth.rate..crude..per.1.000.people...SP.DYN.CBRT.IN. == ""] <- NA

#SETTING NAMES
names(continents) <- c("Country", "Continents")

#Libraries
library(ggplot2)

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
RankTOP20BirthMeans <- popMean_by_Country_and_BirthRate[order(popMean_by_Country_and_BirthRate$Mean, decreasing = TRUE),]
RankTOP20BirthMeans <- subset(RankTOP20BirthMeans[1:20,])
View(RankTOP20BirthMeans)

#RESPOSTA B:
RankBOTTOM20BirthMeans <- popMean_by_Country_and_BirthRate[order(popMean_by_Country_and_BirthRate$Mean, decreasing = FALSE),]
RankBOTTOM20BirthMeans <- subset(RankBOTTOM20BirthMeans[1:20,])
View(RankBOTTOM20BirthMeans)

#RESPOSTA C: RANKING DE 50 PAÍSES
#Subsets; Population & Order Population
Rank50paises <- subset((population_key[which(population_key$Time == 2014),c(1,5)]))
Rank50paises <- Rank50paises[order(Rank50paises$Population..total..SP.POP.TOTL., decreasing = TRUE),]
Rank50paises <- subset(Rank50paises[1:50,])
#Rename Fields
names(Rank50paises) <- c("Paises", "Populacao Total")
View(Rank50paises)

#RESPOSTA D:
popCountry_Variation <- subset(pop1990_to_2014[,c("Country.Name","Time","Population..total..SP.POP.TOTL.")])
View(popCountry_Variation)

#Calculate Variation
popVar_by_Country_and_Population <- aggregate(popCountry_Variation$Population..total..SP.POP.TOTL. ~ popCountry_Variation$Country.Name, popCountry_Variation, var )
names(popVar_by_Country_and_Population) <- c("Country","Variation")
View(popVar_by_Country_and_Population)

#Subset the top 20 Medians
RankTOP20PopVar <- popVar_by_Country_and_Population[order(popVar_by_Country_and_Population$Variation, decreasing = TRUE),]
RankTOP20PopVar <- subset(RankTOP20PopVar[1:20,])
View(RankTOP20PopVar)

#RESPOSTA E:
top10Birth <- popMean_by_Country_and_BirthRate[order(popMean_by_Country_and_BirthRate$Mean, decreasing = TRUE),]
top10Birth <- subset(top10Birth[1:10,])
names(top10Birth) <- c("Country", "MeanBirth Rate")
View(top10Birth)

top10Variability <- popVar_by_Country_and_Population[order(popVar_by_Country_and_Population$Variation, decreasing = TRUE),]
top10Variability <- popVar_by_Country_and_Population[1:10,]
View(top10Variability)

plot(top10Birth$`MeanBirth Rate`, top10Variability$Variation)





#RESPOSTA F:
#Subset based on Country, Time and 65 Age
popCountry_and_65Age <- subset(pop1990_to_2014[,c("Country.Name","Time","Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS.")],!is.na(pop1990_to_2014$Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS.))
View(popCountry_and_65Age)

#Calculate Mean
popMean_by_Country_and_65Age <- aggregate(popCountry_and_65Age$Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS. ~ popCountry_and_65Age$Country.Name, popCountry_and_65Age, mean )
names(popMean_by_Country_and_65Age) <- c("Country","Mean")
View(popMean_by_Country_and_65Age)

#Subset the top 20 Medians
RankTOP20AgeMeans <- popMean_by_Country_and_65Age[order(popMean_by_Country_and_65Age$Mean, decreasing = TRUE),]
RankTOP20AgeMeans <- subset(RankTOP20AgeMeans[1:20,])
View(RankTOP20AgeMeans)

#RESPOSTA G:
RankBOTTOM20AgeMeans <- popMean_by_Country_and_65Age[order(popMean_by_Country_and_65Age$Mean, decreasing = FALSE),]
RankBOTTOM20AgeMeans <- subset(RankBOTTOM20AgeMeans[1:20,])
View(RankBOTTOM20AgeMeans)

#RESPOSTA H:

names(continents) <- c("Country", "Continents")

ContTOP20AgeMeans <- merge(RankTOP20AgeMeans, continents, by.x = "Country", by.y = "Country")

ContBOTTOM20AgeMeans <- merge(RankBOTTOM20AgeMeans, continents, by.x = "Country", by.y = "Country")


findMode <- function(x){ 
  ta = table(x)
  tam = max(ta)
  if (all(ta == tam))
    mod = NA
  else
    if(is.numeric(x))
      mod = as.numeric(names(ta)[ta == tam])
  else
    mod = names(ta)[ta == tam]
  return(mod)
}

findMode(ContBOTTOM20AgeMeans$Continents)
findMode(ContTOP20AgeMeans$Continents)

#RESPOSTA I:
popDeathRate_by_Country <- subset(pop1990_to_2014[which(pop1990_to_2014$Country.Code == "BRA" | pop1990_to_2014$Country.Code == "USA" | pop1990_to_2014$Country.Code == "CHN"),c("Country.Name","Time","Death.rate..crude..per.1.000.people...SP.DYN.CDRT.IN.")])
popDeathRate_by_Country <- na.omit(popDeathRate_by_Country)
names(popDeathRate_by_Country) <- c("Country", "Time", "Death Rate")
View(popDeathRate_by_Country)

DeathRate <- ggplot(data = popDeathRate_by_Country, aes(x = Time, y = `Death Rate`, group = Country))+
            geom_line(aes(color=Country)) +
            geom_point(aes(color=Country))
  
DeathRate
DeathRate + theme(legend.position="bottom") + scale_color_manual(values=c("#00cc00", "#ff3300", "#3333cc"))


#RESPOSTA J:
pop65Perc_by_Country <- subset(pop1990_to_2014[which(pop1990_to_2014$Country.Code == "FRA" | pop1990_to_2014$Country.Code == "ARG" | pop1990_to_2014$Country.Code == "ZAF"),c("Country.Name","Time","Population.ages.65.and.above....of.total...SP.POP.65UP.TO.ZS.")])
pop65Perc_by_Country <- na.omit(pop65Perc_by_Country)
names(pop65Perc_by_Country) <- c("Country", "Time", "% 65 Years")
View(pop65Perc_by_Country)


g65Perce <- ggplot(data = pop65Perc_by_Country, aes(x = Time, y = `% 65 Years`, group = Country))+
           geom_line(aes(color=Country)) +
           geom_point(aes(color = Country))

g65Perce
g65Perce + theme(legend.position="bottom") + scale_color_manual(values=c("#3399ff", "#ff3300", "#ffcc00"))
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
