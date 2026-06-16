# Codice R per analisi geo-ecologica dell'Appennino Bolognese (2016-2026)

library(terra)
library(viridis)
library(imageRy)
library(ggplot2)
library(patchwork)

# definizione working directory
setwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO") #per definire la working directory

# importare su R file rastertiff
ap_2016<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/ap_2016.tiff")
ap_2026<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/ap_2026.tiff")

# visualizzare le singole bande (2016)
par(mfrow=c(2,2))
B3_2016<-plot(ap_2016[[1]])
B4_2016<-plot(ap_2016[[2]])
B8_2016<-plot(ap_2016[[3]])

# visualizzare le singole bande (2016)
par(mfrow=c(2,2))
B3_2026<-plot(ap_2026[[1]])
B4_2026<-plot(ap_2026[[2]])
B8_2026<-plot(ap_2026[[3]])

# visualizzare le immagini satellitari in colori RGB
par(mfrow=c(1,2))
rgb_2016<-plotRGB(ap_2016, r=1, g=2, b=3, stretch="lin", main="2016")
rgb_2026<-plotRGB(ap_2026, r=1, g=2, b=3, stretch="lin", main="2026")

# calcolare NDVI: NDVI-> (NIR-red)/(nir+red)

ndvi2016<-(ap_2016[[3]]-ap_2016[[2]])/(ap_2016[[3]]+ap_2016[[2]])
ndvi2026<-(ap_2026[[3]]-ap_2026[[2]])/(ap_2026[[3]]+ap_2026[[2]])

# visualizzare NDVI
par(mfrow=c(1,2))
plot(ndvi2016, col=inferno(100), main="2016")
plot(ndvi2026, col=inferno(100), main="2026")


# Classificare le immagini satellitari 
c_2016<-im.classify(ap_2016, num_clusters = 2, seed=3)
c_2026<-im.classify(ap_2026, num_clusters = 2, seed=3)

# assegnare dele label: 1) creare una tabella dataframe 2) inserire una label
levels(c_2016) <- data.frame(
  value = c(1, 2),
  label = c("Human", "Forest")
)

levels(c_2026) <- data.frame(
  value = c(1, 2),
  label = c("Human", "Forest")
)

# plottare i grafici classificati con le labels
par(mfrow=c(1,2))
plot(c_2016, main="2016")
plot(c_2026, main="2026")

barplot(c_2016)
barplot(c_2026)

#creare un istogramma:
# 1. calcolare le frequenze dalle immagini, per ogni classe (frequenze dei pixel per classe)
f2016<-freq(c_2016)
f2026<-freq(c_2026)

# 2. calcolare proporzione, e poi moltiplico * 100 per ottenere la percentuale
prop2016<-f2016$count / sum(f2016$count)
perc2016<-prop2016*100

prop2026<-f2026$count / sum(f2026$count)
perc2026<-prop2026*100


# creazione di un dataframe per fare degli istorgammi
tab<-data.frame(
  class=c("Forest", "Human"),
  perc2016=c(34,66),
  perc2026=c(32,67)
)

# rappresentare gli istogrammi tramite la funzione ggplot2()
par(mfrow=c(1,2))

ggplot(tab, aes(x=class, y=perc2016, color=class)) +
  geom_bar(stat="identity", fill="white") +
  ylim(c(0,100))
  
ggplot(tab, aes(x=class, y=perc2026, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))
