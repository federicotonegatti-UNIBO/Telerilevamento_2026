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

// ==============================================
// Sentinel-2 Surface Reflectance - Cloud Masking and Visualization
// https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR_HARMONIZED
// ==============================================

// ==============================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Load and Prepare the Image Collection
// ==============================================

// Load Sentinel-2 SR Harmonized collection (atmospherical correction already done)
var collection = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
                   .filterBounds(geometry)
                   .filterDate('2025-05-01', '2025-06-30')              // Filter by date   
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());

// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(geometry);

// ==============================================
// Visualization on the Map
// ==============================================

Map.centerObject(geometry, 10); // Zoom to the AOI

// Display the first image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B8', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'First image of collection');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['B4', 'B8', 'B2'],
  min: 0,
  max: 0.3
}, 'Median composite');

// ==============================================
// Export to Google Drive
// ==============================================

// Export the median composite
Export.image.toDrive({
  image: composite.select(['B4', 'B3', 'B2']),  // Select RGB bands
  description: 'Sentinel2_Median_Composite',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'sentinel2_median_2020',
  region: geometry,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});
```

Tramite questo script, è stato possibile scaricare le bande B2, B3 e B4 di Landsat, le quali corrispondono rispettivamente alle seguenti bande dello spettro elettromagnetico: 
+ Banda 2 - Blu --> INVCE NO VOGLIO LA BANDA 5 NIR COSI VEDO IL SUOLO NUDO
+ banda 3 - Verde
+ Banda 4 - Rosso

Tutte e tre le bande hanno una risoluzione pari a 30m.

I dati sono stati salvati nella cartella "TELERILEVAMENTO", con il seguente percorso: 
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
Affnchè le funzioni siano lette dal software, è necessario verificare che esse siano già state scaricate attraverso la funzione DOWNLOAD LIBRARY (per scaricarle dal repository CRAN) oppure la funzione GITHUB (per scaricarle tramite Github).

Una volta aperto il software, è stata individuata una working directory attraverso la funzione `setwd()` tramite il seguente script:

```r
# definizione working directory
setwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")``` #per definire la working directory
```

In tal modo, R ha un punto di riferimento per reperire i dati da importare. Una volta assegnata la working directory, è possibile importare su R le immagini scaricate tramite la funzione  `rast()`

```r
#importare su R file raster
p2006<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2006.tif")
p2016<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2016.tif")
p2026<-rast("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO/landsat_2026.tif")
```

### Visualizzazione bande RGB e confronto fra le immagini

Per poter visualizzare contemporaneamente le tre bande scelte per ciascuna immagine satellitare, serve utilizzare la funzione `plotRGB()` che permette di associare a ogni banda dell'immagine satellitare un colore RGB. In questo caso, alla B4 viene associato il colore rosso, alle B2 il verde, e alla B2 il blu.

```r
#visualizzo le immagini satellitari in colori RGB
rgb_2006<-plotRGB(p2006, r=3, g=2, b=1, stretch="lin")
rgb_2016<-plotRGB(p2016, r=3, g=2, b=1, stretch="lin")
rgb_2026<-plotRGB(p2026, r=3, g=2, b=1, stretch="lin")
```


### Script par.mfrow (mettere accanto le tre immagini) con colorazioni viridis (Magma?); descrizione delle caratteristiche a seconda dei colori che si vedono

plottaggio delle singole bande 

```r
# visualizzo le tre bande per entrambe le immagini satellitari
par(mfrow=c(2,2))
plot(p2006[[1]])
plot(p2006[[2]])
plot(p2006[[3]])
```


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
