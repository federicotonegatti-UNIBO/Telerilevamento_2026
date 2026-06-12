# Analisi geo-ecologica Nordeste Paraense

## Introduzione
Il Nordeste Paraense è una area geografica planiziale presso lo stato brasiliano del Parà. A livello ecologico, la regione si distingue per la presenza di foresta tropicale forteente disturbata dall'attività antropica a partire dagli anni XXX.
Ne consegue che la superficie del territorio è oggi prevalentemente priva di copertura forestale, sostituita da aree agricole per la produzione di açaì e olio di palma, e di pascoli per la produzione di carne. Le aree coperte da foresta sono invece suddivisione in piccole patch, scarsamente collegate fra di loro, che aumentano la loro vulnerabilità.

## Obiettivi di progetto
L'obiettivo della ricerca è di individuare il cambiamento dei parametri geo-ecologici negli ultimi venti anni nel Nordeste Paraense.

## Metodologia e risultati
La metodologia si basa su una analisi geo-ecologica basata su immagini satellitari, elaborate tramite il software open-source R. La tipologia di dati spaziali utilizzati è prevalentemente di tipo raster.

### Fonti immagini satellitari
I dat satellitari necessari per l'analisi sono stati scaricati attraverso Google Earth Engine (GEE). Per l'esportazione delle immagini satellitari in formato raster (.TIFF), è stato utilizzato il codice in JavaScript presentato a lezione, modificato grazie all'aiuto dell'AI MS Copilot per replicare l'esportazione dell'immagine per gli anni 2006, 2016 e 2026.

Segue lo script adottato per scaricare le immagini satellitari (2006, 2016, 2026) da GEE.
``` 
function getComposite(collection, startDate, endDate) {
  return collection
    .filterBounds(geometry)
    .filterDate(startDate, endDate)
    .filter(ee.Filter.lt('CLOUD_COVER', 20))
    .median()
    .clip(geometry);
}
// 2006
var img2006 = getComposite(
  ee.ImageCollection('LANDSAT/LT05/C02/T1_L2'),
  '2006-01-01', '2006-12-31'
);

// 2016
var img2016 = getComposite(
  ee.ImageCollection('LANDSAT/LC08/C02/T1_L2'),
  '2016-01-01', '2016-12-31'
);

// 2026
var img2026 = getComposite(
  ee.ImageCollection('LANDSAT/LC09/C02/T1_L2'),
  '2026-01-01', '2026-12-31'
);

Export.image.toDrive({
  image: img2006.select(['SR_B4', 'SR_B3', 'SR_B2']),
  description: 'Landsat_2006',
  folder: 'GEE_exports',
  fileNamePrefix: 'landsat_2006',
  region: geometry,
  scale: 30,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

Export.image.toDrive({
  image: img2016.select(['SR_B4', 'SR_B3', 'SR_B2']),
  description: 'Landsat_2016',
  folder: 'GEE_exports',
  fileNamePrefix: 'landsat_2016',
  region: geometry,
  scale: 30,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

Export.image.toDrive({
  image: img2026.select(['SR_B4', 'SR_B3', 'SR_B2']),
  description: 'Landsat_2026',
  folder: 'GEE_exports',
  fileNamePrefix: 'landsat_2026',
  region: geometry,
  scale: 30,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});
```

Tramite questo script, è stato possibile scaricare le bande B2, B3 e B4 di Landsat, le quali corrispondono rispettivamente alle seguenti bande dello spettro elettromagnetico: 
+ Banda 2 - Blu
+ banda 3 - Verde
+ Banda 4 - Rosso

Tutte e tre le bande hanno una risoluzione pari a 30m.

I dati sono stati salvati nella cartella "TELERILEVAMENTO", con il seguente percorso: 
```
"C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO"
```

### Software R: working directory e librerie
Il software R è utilizzato per l'analisi delle immagini satellitari.

Innanzitutto, è necessario specificare quali librerie di R verranno utilizzate nell'analisi. In questa ricerca si utilizzeranno le funzioni `terra`, `imageRy` e `viridis`, richiamate dalle seguenti funzioni:

```r
library(terra)
library(imageRy)
library(viridis)
```
Affnchè le funzioni siano lette dal software, è necessario verificare che esse siano già state scaricate attraverso la funzione DOWNLOAD LIBRARY (per scaricarle dal repository CRAN) oppure la funzione GITHUB (per scaricarle tramite Github).


Una volta aperto il software, è stata individuata una workin directory attraverso la funzione `setwd()` tramite il seguente script:

```r
setwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")``` #per definire la working directory
```

In tal modo, R ha un punto di riferimento per reperire i dati da importare.

### Script per caricare immagini satellitari su R
Una volta assegnata la working directory, è possibile importare su R le immagini scaricate tramite la funzione  `rast()`

```r
p2006<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2006.tif")
p2016<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2016.tif")
p2026<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2026.tif")
```

### bande RGB

Per poter visualizzare contemporaneamente le tre bande scelte per ciascuna immagine satellitare, serve utilizzare la funzione `plotRGB()` che permette di associare a ogni banda dell'immagine satellitare un colore RGB. In questo caso, alla B4 viene associato il colore rosso, alle B2 il verde, e alla B2 il blu.

```r
rgb_2006<-plotRGB(p2006, r=3, g=2, b=1, stretch="lin")
rgb_2016<-plotRGB(p2016, r=3, g=2, b=1, stretch="lin")
rgb_2026<-plotRGB(p2026, r=3, g=2, b=1, stretch="lin")
```



### Script par.mfrow (mettere accanto le tre immagini) con colorazioni viridis (Magma?); descrizione delle caratteristiche a seconda dei colori che si vedono

par(mfrow=c(2,1))
rgb_2006
rgb_2016
rgb_2026

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
