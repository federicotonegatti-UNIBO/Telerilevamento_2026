library(terra)
library(imageRy)
library(viridis)

#listing files
im.list()

#importare dati
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plot(sun)
#abbiamo 3 livelli energetici del sole dall'imagine: quindi classifico l'immagine
#decido di creare tre cluster
#classify
sunc<-im.classify(sun, num_clusters = 3)


#seed: delle migliaia di interazionio per classificare, selezioni la terza
#selezioni 3 classi, con seed= 3 (a caso)
sunc<-im.classify(sun, num_clusters = 3, seed=3)

#selezioni 3 classi, con seed= 42 (a caso)
sunc<-im.classify(sun, num_clusters = 3, seed=42) #cambia solo qualche pixel

#ora uso una img con 4 classi, usando img del grand canyon
canyon<-im.import("dolansprings_oli_2013088_canyon_lrg.jpg")
plot(canyon)
canyonc<-im.classify(canyon, num_clusters = 4)

#esiste la classificazione fuzzy, presente in imageRy

#uso n cell per capire il numero di pixel della img
ncell(canyon)

list()
list.files()
ciao<-rast("dantersac_drone.jpg")
plot(ciao)
ciaoc<-im.classify(ciao, num_clusters = 3)

