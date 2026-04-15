
library(terra)
library(imageRy)
library(viridis)

setwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")
getwd()

list.files()

sat<-rast("sentinel2_median_2020.tif")

plot(sat[[3]])

par(mfrow=c(2,1))
plot(sat[[1]])
plot(sat[[2]])

par(mfrow=c(1,2))
hist(values(sat[[1]]), main="istogramma 1", col="blue")
hist(values(sat[[2]]), main="istogramma 1", col="red")
