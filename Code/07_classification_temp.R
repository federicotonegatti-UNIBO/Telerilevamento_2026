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

#mato grosso example
im.list()
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
m1999<-im.import("matogrosso_l5_1992219_lrg.jpg")

par(mfrow=c(1,2))
plot(m1999)
plot(m2006) 

m1992c<-im.classify(m1999, seed=42, num_clusters = 2) #ci nasce una land cove map

#metto dele label: creo una tabella dataframe e una label. viene usata la funzione levels
levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("Forest", "Human")
)
m1992c
plot(m1992c)

#img 20006
m2006c<-im.classify(m2006, seed=42, num_clusters = 2)
levels(m2006c) <- data.frame(
  value = c(1, 2),
  label = c("Forest", "Human")
)
m2006c
plot(m2006c)

par(mfrow=c(1,2))
plot(m1992c)
plot(m2006c)

#procedo con un istogramma, con la funzione di imageRy
#si chiama im.barplot: proviamo a scaricare lo scipt della funzione dal repo di imageRy
#la richiamo con la funzione source()

source("im.barplot.R")

#oppure copio e incollolo script che trovo sul repo e lo faccio andare su R, così si salva!

par(mfrow=c(2,1))
im.barplot(m1992c)
im.barplot(m2006c)

#in alternativa, ci calcoliamo le frequenze dalle immagini, per ogni classe (frequenze dei pixel per classe)
#dato che le freq sono sotto la colonna count, devo considerare solo quella con il $
f1992<-freq(m1992c)
#calcolo proporzione, e poi moltiplico * 100 per la percentuale
prop1992<-f1992$count / ncell(m1992c)
perc1992<-prop1992*100

#faccio lo stesso pr il 2006
f2006<-freq(m2006c)
prop2006<-f2006$count / ncell(m2006c)
perc2006<-prop2006*100
perc2006 # la componente human è aumentata dal 17 al 45%

#ora creo un dataframe per fare degli istorgammi
tab<-data.frame(
  class=c("Forest","Human"),
  perc1992=c(83,17),
  perc2006=c(45,55)
)



#ho creato una tabella con 3 colonne: la classe, % foresta o umano nel1992, e % nel 2006
library(ggplot2)
library(patchwork)
tab

#uso ggplot per fare grafico
#funzione aes= estetiche, ovvero colore grafico, x e y del grafico)
#voglio fare un istrogramma con classi sulla x, e % sulla y!
#colori distinti per classe color=class.. ora abbiamo definito il grafico, ma non il TIPO di grafico che vogliamo
#gli chiedo il tipo di grafico che voglio, ovvero barplot
#funzione geom_bar definisce per barre (bar charts)
# metto il + perchè ggplot è una somma di funzioni
#in geom_bar devo definire la statistica (in questo caso idenity), e il riempimento delle barre

#uso una funzione per mettere la y sulla stessa scala
p1 <- ggplot(tab, aes(x=class, y=perc1992, color=class)) +  #structure
  geom_bar(stat="identity", fill="white") + #bar plot
  ylim(c(0,100))+ #limite asse y
  theme(legend.position="none") + #tema: mi fa togliere in questo caso la legenda
  theme_dark() #theme minimal(): sfondo bianco; theme_dark(): sfondo scuro
  

p2 <- ggplot(tab, aes(x=class, y=perc2006, color=class)) + 
  geom_bar(stat="identity", fill="white") + #bar plot
  ylim(c(0,100))

#pacchetto patchwork, dialoga con ggplot: mi fa sommare gli oggetti..basta che sommo i due oggetti p1 e p2

p1+p2 #i due grafici a barre sono paralleli

