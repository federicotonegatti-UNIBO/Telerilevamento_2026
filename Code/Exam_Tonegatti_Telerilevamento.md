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


``` // ==============================================
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
                   .filterBounds(aoi)
                   .filterDate('2025-05-01', '2025-06-30')              // Filter by date   
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());

// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(aoi);

// ==============================================
// Visualization on the Map
// ==============================================

Map.centerObject(aoi, 10); // Zoom to the AOI

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
}, 'Median composite'); ```

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
