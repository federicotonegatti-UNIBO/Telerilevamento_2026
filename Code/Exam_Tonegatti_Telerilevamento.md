# Analisi geo-ecologica Nordeste Paraense

## Introduzione
Il Nordeste Paraense è una area geografica  presso lo stato brasiliano del Parà. A livello ecologico, la regione si distingue per la presenza di foresta tropicale forteente disturbata dall'attività antropica a partire dall'inizio del Novecento, prima con la costruzione della linea ferroviaria Belem-Bragança e successivamente con lo sviluppo di alcuni assi stradali che hanno accelerato il processo di deforestazione. Ne consegue che la superficie del territorio è oggi prevalentemente priva di copertura forestale, sostituita da aree agricole per la produzione di açaì e olio di palma, e da pascoli per la produzione di carne. Le aree coperte da foresta sono in uno stato di forte frammentazione e scorsa connettività, le quali aumentano la loro vulnerabilità.

## Obiettivi di progetto
L'obiettivo della ricerca è di individuare il cambiamento dei parametri geo-ecologici negli ultimi dieci anni (2016-2026) nel Nordeste Paraense.

## Metodologia e risultati
La metodologia si basa su una analisi geo-ecologica basata su immagini satellitari, elaborate tramite il software open-source R. La tipologia di dati spaziali utilizzati è prevalentemente di tipo raster.

### Fonti immagini satellitari
I dati satellitari necessari per l'analisi sono stati scaricati attraverso il portale di Copernicus. I dati satellitari corrispondono a un timespan di 6 mesi (Gennaio-Giugno) relativi al 2016 e al 2026.

Per entrambi i periodi di riferimento, sono state scaricate le seguenti bande spettrali:  B8 (vicino infrarosso, o NIR), B4 (rosso) e B3 (verde) di Landsat-2. Le immagini relative a tutte e tre le bande hanno una risoluzione pari a 30m.

I dati sono stati salvati come immagini .JPG nella cartella "TELERILEVAMENTO", con il seguente percorso: 
```
"C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO"
```

### Importazione immagini satellitari su R
Il software R è utilizzato per l'analisi delle immagini satellitari.

Innanzitutto, è necessario specificare quali librerie di R verranno utilizzate nell'analisi. In questa ricerca si utilizzeranno le funzioni `terra`, `imageRy` e `viridis`, richiamate dalle seguenti funzioni:

```r
# richiamare le librerie
library(terra)
library(imageRy)
library(viridis)
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
p2016<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/NP_2016.jpg")
p2026<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/NP_2026.jpg")
```

### Visualizzazione delle tre singole bande

Per effettuare il plottaggio delle singole bande, è necessario effettuare un subset richiamando le bande attraverso parentesi quadre `[[]]`. Inoltre, per poter visualizzare le tre immagini satellitari, ciascuna corrsipondente a una specifica banda, è necessario utilizzare la funzione `par(mfrow=c())`. In alternativa, è possibile usare la funzione `im.multiframe` di imageRy.

```r
# visualizzare le tre bande (2016)
par(mfrow=c(2,2))
plot(NPA_2016[[1]])
plot(NPA_2016[[2]])
plot(NPA_2016[[3]])

# visualizzare le tre bande (2026)
par(mfrow=c(2,2))
plot(NPA_2026[[1]])
plot(NPA_2026[[2]])
plot(NPA_2026[[3]])
```
### Visualizzazione delle bande RGB e analisi temporale (2016-2026)

Per poter visualizzare in modo sovrapposto le tre bande scelte per ciascuna immagine satellitare, serve utilizzare la funzione `plotRGB()` che permette di associare a ogni banda dell'immagine satellitare un colore RGB. In questo caso, alla B8 viene associato il colore rosso, alla B4 il verde, e alla B3 il blu.

```r
#visualizzo le immagini satellitari in colori RGB
par(mfrow=c(1,2))
rgb_2016<-plotRGB(NPA_2016, r=3, g=2, b=1, stretch="lin")
rgb_2026<-plotRGB(NPA_2026, r=3, g=2, b=1, stretch="lin")
```

### ridgeline (curve della distribuzione dei pixel per banda)


### calcolo differenza NDVI


### barplot differenza NDVI


### Creazione di una mappa di copertura del suolo attraverso la classificazione

i seed sono...
i culster sono i gruppi di pixel che intendiamo creare: nel nostro caso, ne bastano due, in modo da avere una separazione tra le aree deforestate e quelle in cui è presente foresta.

#classificazione per creare una land cover map
p2006_c<-im.classify(p2006, seed=42, num_clusters = 3) #ci nasce una land cover map



pacchetti usati in R

```library(terra) #per gestire dati spaziali``` 

importazione dei dati tramite `setwd()`

```r
setwd("CimageRysetwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")```
getwd()  #per cdefnirie la working directory
```

## Plottaggio delle singole bande
Le singole bande sono state plottate usando un multiframe con `par=mfrow`
