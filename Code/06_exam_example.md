# titolo del progetto: "Esame"


<img width="256" height="256" alt="ciao" src="https://github.com/user-attachments/assets/131de394-847d-4c9a-b056-5c95cc173d8a" />

pacchetti usati in R

```library(terra) #per gestire dati spaziali``` 

importazione dei dati tramite `setwd()`

```r
setwd("CimageRysetwd("C:/Users/utente/Desktop/Assegno UNIBO/corsi e schools/TELERILEVAMENTO")```
getwd()  #per cdefnirie la working directory
```

## Plottaggio delle singole bande
Le singole bande sono state plottate usando un multiframe con `par=mfrow`

```r
par(mfrow=c(2,1))
plot(sat[[1]])
plot(sat[[2]])
```

<img width="613" height="484" alt="image" src="https://github.com/user-attachments/assets/03628fd2-839f-4ec3-b62b-02d3badf2169" />

> ## Nota ##
> l'immagine è fatta così
>
> se vogliamo inserire un elenco puntato si usa il +
> + nota uno
> + nota due
> + nota tre
>
> 
