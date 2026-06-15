# Analisi geo-ecologica dell'Appennino Bolognese

## Introduzione
L'Appenino Bolognese è un'area montuosa in provincia di Bologna, caratterizzata da una ricca variabilità geologica ed ecologica. E' costituita da 11 Comuni, rappresentati dall'Unione dei Comuni dell'Appennino Bolognese. A partire dal Dopoguerra, l'area ha subito un forte spopolamento, con la perdita di attività economiche legate all'agricoltura e alla pastorizia. L'abbandono umano di tale territorio (da intendersi come mancanza di gestione), di conseguenza, ha portato a una profonda trasformazione del paesaggio, con un deciso aumento della superficie boschiva che ha occupato le superfici una volta occupate da pascoli o terre coltivate. 

<img width="1250" height="1002" alt="2026-01-02-00_00_2026-06-11-23_59_Sentinel-2_L2A_True_color" src="https://github.com/user-attachments/assets/83c49235-05ee-4728-b172-6f330055b7ef" />


## Obiettivi di progetto
L'obiettivo della ricerca è di individuare il cambiamento della copertura forestale negli ultimi dieci anni (2016-2026) nell'Appennino Bolognese. In tal senso, si intende verificare se nell'ultimo decennio vi è stato un cambiamento nella gestione del territorio, o la tendenza all'abbandono è rimasta costante.

## Metodologia e risultati
La metodologia si basa su una analisi geo-ecologica basata su immagini satellitari, elaborate tramite il software open-source R. La tipologia di dati spaziali utilizzati è prevalentemente di tipo raster.

### Fonti immagini satellitari
I dati satellitari necessari per l'analisi sono stati scaricati attraverso il portale di Copernicus. I dati satellitari corrispondono a un timespan di 6 mesi (Gennaio-Giugno) relativi al 2016 e al 2026. I confini del'immagine satellitare corrispondono al file vettoriale "Confini_app.shp" che descrive i limiti amministrativi degli 11 Comuni rappresentati.

Per entrambi i periodi di riferimento, sono state scaricate le seguenti bande spettrali:  B8 (vicino infrarosso, o NIR), B4 (rosso) e B3 (verde) di Landsat-2. Le immagini relative a tutte e tre le bande hanno una risoluzione pari a 30m.

I dati sono stati salvati come immagini .JPG nella cartella "TELERILEVAMENTO", con il seguente percorso: 
```
"C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO"
```

### Importazione immagini satellitari su R
Il software R è utilizzato per l'analisi delle immagini satellitari.

Innanzitutto, è necessario specificare quali librerie di R verranno utilizzate nell'analisi. In questa ricerca si utilizzeranno le funzioni `terra`, `imageRy`, `viridis`, `ggplot2()` e `patchwork` richiamate dalle seguenti funzioni:

```r
# richiamare le librerie
library(terra)
library(viridis)
library(imageRy)
library(ggplot2)
library(patchwork)
```
Affnchè le funzioni appartenenti a ciascuna libreria siano lette dal software, è necessario verificare che esse siano già state scaricate attraverso la funzione `install.packages()` (per scaricare i pacchetti di R dal repository CRAN) oppure la funzione `install_git()` (per scaricarle tramite Github).

Una volta aperto il software, è stata individuata una working directory attraverso la funzione `setwd()` tramite il seguente script:

```r
# definizione working directory
setwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")``` #per definire la working directory
```

In tal modo, R ha un punto di riferimento per reperire i dati da importare. Una volta assegnata la working directory, è possibile importare su R le immagini scaricate tramite la funzione  `rast()`

```r
#importare su R file raster
p2016<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/ap_2016.jpg")
p2026<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/ap_2026.jpg")
```

### Visualizzazione delle tre singole bande

Per effettuare il plottaggio delle singole bande, è necessario effettuare un subset richiamando le bande attraverso parentesi quadre `[[]]`. Inoltre, per poter visualizzare le tre immagini satellitari, ciascuna corrsipondente a una specifica banda, è necessario utilizzare la funzione `par(mfrow=c())`. In alternativa, è possibile usare la funzione `im.multiframe` di imageRy.

```r
# visualizzare le tre bande (2016)
par(mfrow=c(2,2))
plot(ap_2016[[1]])
plot(ap_2016[[2]])
plot(ap_2016[[3]])

# visualizzare le tre bande (2026)
par(mfrow=c(2,2))
plot(ap_2026[[1]])
plot(ap_2026[[2]])
plot(ap_2026[[3]])
```
### Visualizzazione delle bande RGB e analisi temporale (2016-2026)

Per poter visualizzare in modo sovrapposto le tre bande scelte per ciascuna immagine satellitare, serve utilizzare la funzione `plotRGB()` che permette di associare a ogni banda dell'immagine satellitare un colore RGB. In questo caso, alla B8 viene associato il colore rosso, alla B4 il verde, e alla B3 il blu.

```r
# visualizzare le immagini satellitari in colori RGB
par(mfrow=c(1,2))
rgb_2016<-plotRGB(ap_2016, r=1, g=2, b=3, stretch="lin")
rgb_2026<-plotRGB(ap_2026, r=1, g=2, b=3, stretch="lin")
```

### Calcolo della differenza NDVI
Il NDVI è un indice di vegetazione è particolarmente utile per monitorare variazioni nella copertura vegetale nel tempo. Tale indice permette di normalizzare le differenze tra immagini acquisite in tempi o condizioni diverse. Si calcola come: NDVI = (NIR − Red) / (NIR + Red)  

I valori ottenuti variano tra -1 e +1: valori vicini a +1 indicano vegetazione densa e sana, mentre valori prossimi a 0 o negativi indicano suolo nudo, rocce o acqua.

```r
# calcolare NDVI: ricorda che NIR [[3]], rosso [[2]]
ndvi2016<-(ap_2016[[3]]-ap_2016[[2]])/(ap_2016[[3]]+ap_2016[[2]])
ndvi2026<-(ap_2026[[3]]-ap_2026[[2]])/(ap_2026[[3]]+ap_2026[[2]])

# visualizzare
par(mfrow=c(2,1))
plot(ndvi2016, col=inferno(100))
plot(ndvi2026, col=inferno(100))
```

### Creazione di una mappa di copertura del suolo attraverso la classificazione

Per ottenere una mappa di copertura del suolo (Land Use Land Cover map - LULC), viene adottata la funzione di imageRy `im.classify()`. Tale funzione permette di individuare gruppi di pixel aventi valori simile di riflettanza, detti cluster. Nel nostro caso, vogliamo distinguere tra aree coperte da foresta e aree prive di copertura, quindi adotteremo due cluster.

```r
# classificareo le immagini satellitari 
c_2016<-im.classify(ndvi2016, num_clusters = 2, seed=3)
c_2026<-im.classify(ndvi2026, num_clusters = 2, seed=3)
```

Per rappresentare visualizzare le distribuzioni dei due cluster, associamo delle etichette (label) a ciascun cluster attraverso la funzione `levels()` 

```r
# mettere delle label attraverso una tabella dataframe. le label assegnate sono "Human" per le superfici urbanizzate e agricole, e "Forest" per le superici coperte da bosco.
levels(c_2016) <- data.frame(
  value = c(1, 2),
  label = c("Human", "Forest")
)

levels(c_2026) <- data.frame(
  value = c(1, 2),
  label = c("Human", "Forest")
)

# visualizzare le due immagini satellitari classificate
par(mfrow=c(2,1))
plot(c_2016)
plot(c_2026)
```

Per visualizzare le distribuzioni dei due cluster per entrambe le immagini in due istogrammi, calcoliamo le frequenze relative di ciascuno di esso per entrambe le immagini. Le frequenze corrispndono alle frequenze dei pixel per classe. Grazie alle funizoni `ggplot2()` e `patchwork`, infine, possiamo rappresentare gli istogrammi in modo più dettagliato, inserendo il limite all'asse y pari a 100.

```r
# calcolare le frequenze dalle immagini, per ogni classe
f2016<-freq(c_2016)
f2026<-freq(c_2026)

# calcolare la proporzione, e poi moltiplicare * 100 per la percentuale
prop2016<-f2016$count / sum(f2016$count)
perc2016<-prop2016*100

prop2026<-f2026$count / sum(f2026$count)
perc2026<-prop2026*100

# visualizzo il valore delle frequenze di entrambe le immagini
perc2016
perc2026

# creazione di un dataframe per rappresentare gli istogrammi
tab<-data.frame(
  class=c("Forest", "Human"),
  perc2016=c(34,66),
  perc2026=c(32,68)
)

# rappresentare gli istogrammi tramite la funzione ggplot2()
par(mfrow=c(2,1))

ggplot(tab, aes(x=class, y=perc2016, color=class)) +
  geom_bar(stat="identity", fill="white") +
  ylim(c(0,100))
  
ggplot(tab, aes(x=class, y=perc2026, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))
```

# Conclusione
Dall'analisi emerge che la frequenza relativa di copertura forestale dal 2016 al 2026 è scesa di due punti percentuali, a favore delle superifici antropizzate. Da ciò consegue che la rinaturalizzazione del territorio ha subito una leggera battuta di arresto. Ulteirori ricerche potranno individuare se tale risultato sarà da attribuire al recupero di aree "abbandonate" per fini agricoli (fenomeno che potrebbe associarsi ad un lento ripopolamento dell'Appennino grazie al fenomeno dei cosiddetti "neo-rurali") o ad un aumento del consumo di suolo.

