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

#importo banda 3 sentinel, verde
im.list()
b3<-im.import("sentinel.dolomites.b3.tif" )
View(b3)
plot(b3, col=plasma(100))

#importo banda 4, rossi
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=magma(100))
clgray <- colorRampPalette(c("black", "darkgray","dimgray"))(100)
plot(b4, col=clgray)

#importo b8 near-infrared
b8<-im.import("sentinel.dolomites.b8.tif")
plot(b4, col=magma(100))

#esercizio: multiframe with 4 band, and legends in line with the wave lenght

im.multiframe(2,2)
cl_blue <- colorRampPalette(c("royalblue4", "royalblue2","royalblue"))(100)
cl_green <- colorRampPalette(c("green4", "green2","green"))(100)
cl_red <- colorRampPalette(c("firebrick4", "firebrick2","firebrick1"))(100)
cl_near <- colorRampPalette(c("gold4", "gold2","gold"))(100)


plot(b2, col=cl_blue)
plot(b3, col=cl_green)
plot(b4, col=cl_red)
plot(b8, col=cl_near)

#stack: comporre assieme l'immagine satellitare
sentinel<-c(b2,b3,b4,b8)
plot(sentinel, col=inferno(100))

#estraggo un layer dai 4 di sentinel (b2,b3,b4,b8), uso il $
names(sentinel)
plot(sentinel$file12ec6316315e)

#subset: uso le doppie parentesi quadre per le matrici (raster)
plot(sentinel[[4]])
plot(sentinel[[2]])
