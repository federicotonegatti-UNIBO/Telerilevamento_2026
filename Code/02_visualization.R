#R visualization for satellite images

library(terra)
library(imageRy)

im.list()

#GitHub
install.packages("devtools") #remotes
library(devtools)
install_github("ducciorocchini/imageRy")
library(imageRy)
im.list()
hist(inquinanti)

install.packages("lidR")
install.packages("terra")     # per caricare raster/CHM
install.packages("sf")        # per esportare shapefile
library("lidR")
library("sf")
#pacchetto viridis: legende per colori x daltonici
install.packages("viridis")

rm(list=ls())

library(terra)
library(imageRy)

#listing data
im.list()
#copernicus ha un satellite landsat 2 con risulzione 10m
#usato sito tofane

#asking for importing data
?im.import()
#importing data: banda  02 di sentinel è il blu (490 nm)
b2<-im.import("sentinel.dolomites.b2.tif")

#changing colours

cl <- colorRampPalette(c("cadetblue","bisque4"))(100)
plot(b2, col=cl)

#viridis palette: il umero tra parentesi è il numero di sfumature
library(viridis)
plot(b2, col=inferno(100))
#usa la gamma colore mako (non servono le virgolette)
plot(b2, col=mako(100))

clgray <- colorRampPalette(c("black", "darkgray","dimgray"))(100)
plot(b2, col=clgray)

#plottare viridis e colori di R; dev.off è simpatico (chiude i device)
par(mfrow=c(1,2))
plot(b2, col=clgray)
plot(b2, col=inferno(100))
dev.off()

#si scrive tra parentesi il numero di righe e colonne
im.multiframe(1,2)
plot(b2, col=clgray)
plot(b2, col=inferno(100))

#importo banda 3 sentinel, verde
im.list()
b3<-im.import("sentinel.dolomites.b3.tif" )
View(b3)
plot(b3, col=plasma(100))

#importo banda 4, rossi
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=magma(100))
clgray <- colorRampPalette(c("black", "darkgray","dimgray"))(100)
plot(b4, col=clgray)

#importo b8 near-infrared
b8<-im.import("sentinel.dolomites.b8.tif")
plot(b4, col=magma(100))

#esercizio: multiframe with 4 band, and legends in line with the wave lenght

im.multiframe(2,2)
cl_blue <- colorRampPalette(c("royalblue4", "royalblue2","royalblue"))(100)
cl_green <- colorRampPalette(c("green4", "green2","green"))(100)
cl_red <- colorRampPalette(c("firebrick4", "firebrick2","firebrick1"))(100)
cl_near <- colorRampPalette(c("gold4", "gold2","gold"))(100)


plot(b2, col=cl_blue)
plot(b3, col=cl_green)
plot(b4, col=cl_red)
plot(b8, col=cl_near)

#stack: comporre assieme l'immagine satellitare
sentinel<-c(b2,b3,b4,b8)
plot(sentinel, col=inferno(100))

#estraggo un layer dai 4 di sentinel (b2,b3,b4,b8), uso il $
names(sentinel)
plot(sentinel$file12ec6316315e)

#subset: uso le doppie parentesi quadre per le matrici (raster)
plot(sentinel[[4]])
plot(sentinel[[2]])


#ROCCHINI
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()
b2<-im.import("sentinel.dolomites.b2.tif")
b3<-im.import("sentinel.dolomites.b3.tif")
b4<-im.import("sentinel.dolomites.b4.tif")
b8<-im.import("sentinel.dolomites.b8.tif")

#stack: ognuna delle bande è elemento di un vettore
sentinel<-c(b2,b3,b4,b8)

#layer1=b2 blue
#l2=b3 green
#l3=b4 red
#l4=b8 near infrared  NIR
plot(sentinel)

#abbiamo creato una immagine impilata, con 4 bande una sopra l'altra
#lo stack è simile al multiframe

plot(sentinel[[4]]) #permette di vedere solo un layer, il quale si chiama [4]

#installiamo patchwork: permette di fare i grafici con ggplot
#patchwork funziona solo con ggplot
# possiamo mettere grafici accanto, uno sopra l'altro etc
install.packages("patchwork")

#ggplot2 permette di fare grafici in R
#faccio grafico banda 8 con ggplot

p1<-im.ggplot(b8)
p2<-im.ggplot(b4)
p1+p2

#4 possibilità per multiframe 1) parfrow, 2)im.multiframe, 3) stack, 4) im.ggplot

#RGB plotting. ho le 4 bande. metto per ogni colore la banda di riferimento (il livello del layer!)
im.plotRGB(sentinel, r=3, g=2, b=1) # è una immagine a colori naturali, natural colours!

#abbiamo infatti inserito solo le bande del visibile: in questo caso è una img poco chiara ( nostri occhi vedono poco)
#cerco di mettere anche il NIR in modo da vedere meglio
im.plotRGB(sentinel, r=4, g=2, b=1) #NIR permette di vedere le parti vegetate
b<-im.plotRGB(sentinel, r=4, g=3, b=2) #così si spostano tutti i layer di una posizione
#abbiamo creato una immagine di falsi colori
a<-im.plotRGB(sentinel, r=3, g=4, b=2)
#in realtà quello che importa in questa immagine è dove metto il NIR, gli altri rgb sono simili
#le bande del visibile sono molto correlate fra loro!

a<-im.plotRGB(sentinel, r=3, g=4, b=2)
b<-im.plotRGB(sentinel, r=4, g=3, b=2)
mar<-c(a,b)
plot(mar)

im.multiframe(1,2)
im.plotRGB(sentinel, r=3, g=4, b=2)
im.plotRGB(sentinel, r=4, g=3, b=2)

#vedere le correlazioni
pairs(sentinel)

im.plotRGB(sentinel, r=2, g=3, b=1)
im.plotRGB(sentinel, r=2, g=3, b=4)

#plotting RGB via terra: si usa lo stretch
plotRGB(sentinel, r=4, g=3, b=2, stretch="lin") #stretch lineare: più bella e chiara
plotRGB(sentinel, r=4, g=3, b=2, stretch="hist") #stretch istogramma: utile per discriminare molto tra vari elementi nel paesaggio

im.multiframe (1,2)
plotRGB(sentinel, r=4, g=3, b=2, stretch="lin") 
plotRGB(sentinel, r=4, g=3, b=2, stretch="hist")


library(terra)
library(imageRy)
library(viridis)
im.list()

mato1992<- im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992<-flip(mato1992) #per ribaltare img, che a volt in R il nord è capovolto a sud!
mato1992 #ha tre bande:l1=NIR, l2=red, l3=green
im.plotRGB(mato1992,r=1, g=2, b=3) #metto NIR nel rosso
im.plotRGB(mato1992,r=2, g=1, b=3) #metto il NIR nel verde
mato1992_plot<-im.plotRGB(mato1992,r=2, g=3, b=1)  #faccio diventare giallo il suolo nudo

mato2006<- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006<-flip(mato2006)
mato2006_plot<-im.plotRGB(mato2006, r=1, g=2, b=3)

#multiframe
mato1992_plot<-im.plotRGB(mato1992,r=2, g=3, b=1)
mato2006_plot<-im.plotRGB(mato2006, r=1, g=2, b=3)
im.multiframe(mato1992_plot, mato2006_plot)
im.multiframe(1,2)
mato1992_plot<-im.plotRGB(mato1992,r=1, g=2, b=3)
mato2006_plot<-im.plotRGB(mato2006, r=1, g=2, b=3)

#DVI 0-100 NIR-red
#NIR= 100 red=0
#dvi_t0=NIR-red=100-0=100 pianta in salute
#dvi_t1=NIR-red=40-10=30 pianta in sofferenza

dvi1992<-mato1992[[1]]-mato1992[[2]]   #faccio subset sulla prima banda [1]
dvi2006<-mato2006[[1]]-mato2006[[2]] 

#plotto la dvi
plot(dvi1992)
plot(dvi2006) #nel 2006 maggior eintervento umano, vedo meno verde e più blu (suolo nudo)

plot(dvi1992, col=inferno(100))

#DVI with different radiometric resolution
#8bit , range da 0 a 255
#dvi max=nir-red= 255-0=255
#dvi min= 0 - 255=-255
#con una immagine a 8 bit, ovvero 256 valori, ho un range da -255 a 255

#2bit= 2^2 --> variazione da 0 a 3
# dvi max con 2 bit= 3, mente minimo -3

#non posso comparare dvi di immagini a 2bit e  8bit! devo riscalare
#possiamo utilizzare NDVI: per ovviare al problema della risoluzione radiometrica, si fa una standardizzazione delle variabili (normalizzaizone, ma a rocchini sta sulle palle sta roba)

#NDVI-> (NIR-red)/(nir+red) standardizzo sulla somma
# ndvi max=(255-0)/(255-0)=1
#ndvi min= (0-255)/(0+255= = -1

ndvi1992<- dvi1992/(mato1992[[1]]+mato1992[[2]])
ndvi2006<- dvi2006/(mato2006[[1]]+mato2006[[2]])

im.multiframe(2,2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))


a<-plot(ndvi1992, col=inferno(100))
b<-plot(ndvi2006, col=inferno(100))
c<-stack(a,b)
plot(c)

im.ggplot(sentinel)
plot(b2)
plot(b8)
