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

faccio degli istogrammi

```r
par(mfrow=c(2,1))
hist(values(sat[[1]]), main="istogramma 1", col="blue")
hist(values(sat[[2]]), main="istogramma 1", col="red")
```

<img width="1898" height="1024" alt="image" src="https://github.com/user-attachments/assets/5f9c639a-ec0e-4f47-bdc4-d40492ae3d78" />
