# Analisi geo-ecologica Nordeste Paraense

## Introduzione
Il Nordeste Paraense è una area geografica planiziale presso lo stato brasiliano del Parà. A livello ecologico, la regione si distingue per la presenza di foresta tropicale forteente disturbata dall'attività antropica a partire dagli anni XXX.
Ne consegue che la superficie del territorio è oggi prevalentemente priva di copertura forestale, sostituita da aree agricole per la produzione di açaì e olio di palma, e di pascoli per la produzione di carne. Le aree coperte da foresta sono invece suddivisione in piccole patch, scarsamente collegate fra di loro, che aumentano la loro vulnerabilità.

## Obiettivi di progetto
L'obiettivo della ricerca è di individuare il cambiamento dei parametri geo-ecologici negli ultimi venti anni nel Nordeste Paraense.
## Metodologia e risultati
La metodologia si basa su una analisi geo-ecologica basata su immagini satellitari, elaborate tramite il software open-source R. La tipologia di dati spaziali utilizzati è prevalentemente di tipo raster.

### Script per scaricare immagini satellitare (2006, 2016, 2026) da GEE
I dat satellitari necessari per l'analisi sono stati scaricati attraverso Google Earth Engine (GEE). 

### Script per caricare immagini satellitari su R


### Script par.mfrow (mettere accanto le tre immagini) con colorazioni viridis (Magma?); descrizione delle caratteristiche a seconda dei colori che si vedono


### bande RGB


### ridgeline (curve della distribuzione dei pixel per banda)


### calcolo differenza NDVI


### barplot differenza NDVI





pacchetti usati in R

```library(terra) #per gestire dati spaziali``` 

importazione dei dati tramite `setwd()`

```r
setwd("CimageRysetwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")```
getwd()  #per cdefnirie la working directory
```

## Plottaggio delle singole bande
Le singole bande sono state plottate usando un multiframe con `par=mfrow`
