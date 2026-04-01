

#importing data: setting a working directory

library(terra)
library(viridis)
library (imageRy)
#spiegare a R la cartella usata per caricare o esportare dati
setwd("C:/Users/utente/Desktop/TELERILEVAMENTO/drone")

#mostra wd
getwd()

#lista file dentro la wd
list.files()

#importare dati raster: creato uno SpatRaster
rgb<-rast("DJI_20260331174728_0001_D.jpg")
plot(rgb)

nir<-rast("DJI_20260331174728_0001_MS_NIR.tiff")
plot(nir)

red<-rast("DJI_20260331174728_0001_MS_R.tiff")
plot(red)

green<-rast("DJI_20260331174728_0001_MS_G.tiff")
plot(green)

#plotto in rgb attraverso uno stack
stack<-c(red, green, nir)
plot(stack)

#vedo come cambia lo stretch e i valori di rgb
plotRGB(stack, r=3,g=2, b=1, stretch="lin") 
plotRGB(stack, r=3,g=2, b=1, stretch="hist")

plotRGB(stack, r=2,g=3,b=1, stretch="lin") #se metto nir nel verde si vede bene il suolo nudo

plotRGB(stack, r=2,g=1,b=3, stretch="lin")

#analizziamo NDVI=(nir-red)/(nir+red)
ndvi<-im.ndvi(stack, 3, 1) #funzione di iaery che permette di calcolare ndvi
ndvi
plot(ndvi, col=magma(100)) # si vede molto bene le zone con più alto ndvi

ndvi1<-(stack[[3]]-stack[[1]])/(stack[[3]]+stack[[1]]) # se no si fa alla vecchia a mano
plot(ndvi1, col=magma(100))

#save the data: funzione writeRaster()
writeRaster(ndvi, "ndvi.tiff")

#reimporting files
ndvi2<-rast("ndvi.tiff")
plot(ndvi2)

#esportare un plot
par(mfrow=c(2,2))
plot(ndvi)
plot(nir)
plot(red)
plot(green)

png("figura_corso") #crea un png vuoto nella cartella

png("figura_corso")
par(mfrow=c(2,2))
plot(ndvi)
plot(ndvi)
plot(nir)
plot(red)
dev.off()
plot(green)

# funzione patchwork() per ggplot
p1<-im.ggplot(ndvi)
p2<-im.ridgeline(stack, scale=1, palette="viridis")
p1+p2

#da github
"link/del/corso.xxxx"
nomedelfile
