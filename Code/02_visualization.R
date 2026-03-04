#R visualization for satellite images

library(terra)
library(imageRy)

im.list()

#GitHub
install.packages("devtools") #remotes
library(devtools)
install_github("ducciorocchini/imageRy")
library(imageRy)
im.list()
hist(inquinanti)

install.packages("lidR")
install.packages("terra")     # per caricare raster/CHM
install.packages("sf")        # per esportare shapefile
library("lidR")
library("sf")
#pacchetto viridis: legende per colori x daltonici
install.packages("viridis")

rm(list=ls())

library(terra)
library(imageRy)

#listing data
im.list()
#copernicus ha un satellite landsat 2 con risulzione 10m
#usato sito tofane

#asking for importing data
?im.import()
#importing data: banda  02 di sentinel è il blu (490 nm)
b2<-im.import("sentinel.dolomites.b2.tif")

#changing colours

cl <- colorRampPalette(c("cadetblue","bisque4"))(100)
plot(b2, col=cl)

#viridis palette: il umero tra parentesi è il numero di sfumature
library(viridis)
plot(b2, col=inferno(100))
#usa la gamma colore mako (non servono le virgolette)
plot(b2, col=mako(100))

clgray <- colorRampPalette(c("black", "darkgray","dimgray"))(100)
plot(b2, col=clgray)

#plottare viridis e colori di R; dev.off è simpatico (chiude i device)
par(mfrow=c(1,2))
plot(b2, col=clgray)
plot(b2, col=inferno(100))
dev.off()

#si scrive tra parentesi il numero di righe e colonne
im.multiframe(1,2)
plot(b2, col=clgray)
plot(b2, col=inferno(100))
