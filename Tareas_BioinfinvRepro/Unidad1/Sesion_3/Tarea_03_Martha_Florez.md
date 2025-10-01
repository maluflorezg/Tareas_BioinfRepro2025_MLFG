# TAREA 3 - Introducción a R con un enfoque bioinformático

## EJERCICIOS

1. **Crea una variable con el logaritmo base 10 de 50 y súmalo a otra variable cuyo valor sea igual a 5.**

Comandos en R

```
# Crear un logaritmo en base 10 de 50
x <- log10(50)
# Otra Variable
y <- 5
> x <- log10(50)
> y <- 5
> resultado <- x + y
> resultado
[1] 6.69897
```

2. **Suma el número 2 a todos los números entre 1 y 150.**

```
> v <- 1:150
> v2 <- v + 2
> v2
  [1]   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20
 [19]  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38
 [37]  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56
 [55]  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74
 [73]  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92
 [91]  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110
[109] 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
[127] 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146
[145] 147 148 149 150 151 152
```

3. **¿Cuántos números son mayores a 20 en el vector -13432:234?**

```
vec <- -13432:234
# Contar cuantos numeros son mayores a 20
> sum(vec >20)
[1] 214
```

4. **Carga en R el archivo `PracUni1Ses3/maices/meta/maizteocintle_SNP50k_meta_extended.txt` y ponlo en un objeto de R llamado meta_maiz.**

```
# Definir la ruta al archivo 
file_path <- "PracUni1Ses3/maices/meta/maizteocintle_SNP50k_meta_extended.txt"
# Cargar el archivo en R
## header=TRUE: la primera fila contiene los nombres de la columnas, 
        ## sep = "\t": Separa las columnas con tabulación, 
        ## stringsAsFactors=FALSE: Mantiene el texto como caracter y no como factor.)
meta_maiz <- read.table(file_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
# Verificar las primeras filas
head(meta_maiz)
OrderColecta NSiembra          Origen                  Raza     Estado
1            2        3  INIFAP-2009-16              Apachito  Chihuahua
2            1       68         2009-72              Chalque̱o   Tlaxcala
3            1       91         2007-33 Dulcillo del Noroeste     Sonora
4            2       39    Chis-2009-18            Dzit-Bacal    Chiapas
5            2       12 Celaya-2009-114                Celaya Guanajuato
6            2       41   Celaya-2009-2   Elotes Occidentales Guanajuato
    Num_Colecta     Nombre_comun         Raza_Primaria Raza_Secundaria
1            16    Ocho carreras              Apachito              NA
2            22 Chalque̱o Criollo              Chalque̱o              NA
3   SON2007-033   Ma\xcc_z Dulce Dulcillo del Noroeste              NA
4   Repetida 18   Olotillo crema            Dzit-Bacal              NA
5 2009-REPO-114 Ma\xcc_z Criollo                Celaya              NA
6 2009-REPO-002 Ma\xcc_z Criollo   Elotes Occidentales              NA
  A.o._de_colecta              Localidad  Municipio   Estado.1   Longitud
1            2009     Santo Tom\xcc\xc1s   Guerrero  Chihuahua -107.58300
2            2008       Ignacio Zaragoza Cuapiaxtla   Tlaxcala  -97.92944
3            2007            Agua Blanca      Y̩cora     Sonora -108.92467
4            2009 Nuevo Vicente Guerrero Villacorzo    Chiapas  -92.97972
5            2009            El Ahuacate  Uriangato Guanajuato -101.11889
6            2009              Comonfort  Comonfort Guanajuato -100.76583
   Latitud Altitud                         Ruizetal2008_grupo
1 28.68578    1975                       1A_templado540-640mm
2 19.29083    2497                                           
3 28.53703    1435                     2A_semicalido500-870mm
4 16.03225     618                     3A_muycalido990-1360mm
5 20.09111    1877 2A_semicalido500-870mm y 1B_templado>650mm
6 20.74417    1800 2C_semicalido740-855mm y 1B_templado>650mm
          Sanchezetal_grupo Categ.Altitud                 Rbiogeo
1       Sierra de Chihuahua           mid Sierra Madre Occidental
2                C\xcc_nico          high           Eje Volcanico
3                 Chapalote           mid Sierra Madre Occidental
4 Maduraci\xcc_n tard\xcc_a           low      Costa del Pacifico
5       Dentados tropicales           mid           Eje Volcanico
6              Ocho Hileras           mid           Eje Volcanico
             DivFloristic     PeralesBiog
1 Sierra Madre Occidental Ca\xe5_ones Chi
2  Serranias Meridionales     Mesa Centra
3 Sierra Madre Occidental     Sierras del
4  Serranias Transismicas         Chiapas
5            Altiplanicie    Baj\xe5\xc1o
6            Altiplanicie    Baj\xe5\xc1o
> 
```

**5. Escribe un for loop para que divida 35 entre 1:10 e imprima el resultado en la consola.**

```
for (i in 1:10) {
+ print (35 / i)
+ }
[1] 35
[1] 17.5
[1] 11.66667
[1] 8.75
[1] 7
[1] 5.833333
[1] 5
[1] 4.375
[1] 3.888889
[1] 3.5
```

    5.1 Modifica el loop anterior para que haga las divisiones solo para los números     nones (con un comando, NO con `c(1,3,...)`). Pista: `next`. 

```
for (i in 1:10){
+   if (i %% 2 == 0) next  # salta los pares
+   print(35 / i)
+ }
[1] 35
[1] 11.66667
[1] 7
[1] 5
[1] 3.888889
```

Modifica el loop anterior para que los resultados de correr todo el loop se guarden en una df de dos columnas, la primera debe tener el texto "resultado para x" (donde x es cada uno de los elementos del loop) y la segunda el resultado correspondiente a cada elemento del loop. 

```
# Guardar resultaods en un data.frame con texto
> resultados <- data.frame(Texto = character(0), Valor = numeric(0))
> 
> for (i in 1:10){
+   if (i %% 2 == 0) next  # saltar pares
+   texto <- paste("resultado para", i)
+   valor <- 35 / i
+   resultados <- rbind(resultados, data.frame(Texto = texto, Valor = valor))
+ }
> 
> resultados
             Texto     Valor
1 resultado para 1 35.000000
2 resultado para 3 11.666667
3 resultado para 5  7.000000
4 resultado para 7  5.000000
5 resultado para 9  3.888889
```

6. **Abre en RStudio el script `PracUni1Ses3/mantel/bin/1.IBR_testing.r`. Este script realiza un análisis de aislamiento por resistencia con Fst calculadas con ddRAD en Berberis alpina.**

Lee el código del script y determina:
¿Qué hacen los dos for loops del script?

1. **Primer for loop** `for(i in c("present", "ccsm", "miroc", "flat", "1800", "2000", "2300", "2500", "2700", "3000", "3300", "3500", "4000"))`

```
### Get effective distance matrix and mean of it for each raster 

  for(i in c("present", "ccsm", "miroc", "flat", "1800", "2000", "2300", "2500", "2700", "3000", "3300", "3500", "4000")) {
    
    ## 1. define resistances.out files
    resfile <- paste0(circfolder, "/Balpina_", i, "_resistances.out")
      
    ### 2. Get effective distances
    
    eff.dist<-read.effdist(file=resfile, popNames=popNamesFP, des.order=popNames)
    
    ### 3. Estimate mean effective distance by population
    mean.effD <- apply(eff.dist, 2, mean)  
      
    ### 4. Name output data
    assign(paste0("B.", i), eff.dist)  # effective distance mat
    assign(paste0("B.mean.", i), mean.effD) # mean effective distances
  }    
```

1. Define los archivos de salida de resistencias

2. Obtiene las distancias efectivas

3. Estima la distancia efectiva media por población

4. Nombra los datos de salida



2. **Segundo for loop**

```
for(i in c("present", "ccsm", "miroc", "flat", "1800", "2000", "2300", "2500", "2700", "3000", "3300", "3500", "4000")) {
  
    print(paste("Results for", i))
    
    # 1. Mantel test 
    print("Mantel test")
    x<-mantel.rtest(as.dist(get(paste0("B.",i))), as.dist(B.FstLin), nrepet=10000)
    print(x)
    
    # 2. Plot
    DistPlot(get(paste0("B.",i)), B.FstLin, plotnames=FALSE,
            ylabel=expression("F"[ST]*"/(1 ??? "[FST]*")"), xlabel=paste("Effective distance", i))
               
    # 3. get info for df  
    MTpvalue<-round(x$pvalue, 6)
    MTr<-round(x$obs, 4)
    
    # 4. put results in dataframe
    rster<-paste(i)
    IBRresults<-rbind(IBRresults, c(rster, MTpvalue, MTr))
  } 

```

1. Prueba de Mantel

2. Grafica

3. Obtiene información para gl

4. Coloca los resultados en el marco de datos




**¿qué paquetes necesitas para correr el script?**

library(ade4)          #  para mantel.rest
library(ggplot2)    #  para gráficos
library(sp)            #  para cálculo de distancias geográficas 

**¿qué archivos necesitas para correr el script?**

read.fst_summary_fix.R

read.effdist.R

surveyed_mountains.tsv

BerSS.sumstats.tsv

BerSS.fst_summary.tsv

Balpina_", i, "_resistances.out

Balpina_focalpoints.txt

DistPlot.R



7. **Escribe una función llamada `calc.tetha` que te permita calcular tetha dados Ne y u como argumentos. Recuerda que tetha =4Neu.**

calc.tetha <- function(Ne, u){

theta <- 4 * Ne * u

return(theta)

}

calc.tetha(1000, 1e-8)

[1] 4e-05



8. **Escribe un script que debe estar guardado en `PracUni1Ses3/maices/bin` y llamarse `ExplorandoMaiz.R`**
1) Cargue en R el archivo `PracUni1Ses3maices/meta/maizteocintle_SNP50k_meta_extended.txt` 
2. Responda lo siguiente.



(averigua cada punto con comandos de R. Recuerda comentar o tendrás 7 años de mala suerte en el lab)

1. ¿Qué tipo de objeto creamos al cargar la base?

```
class(meta_maiz)
[1] "data.frame"
```

¿Cómo se ven las primeras 6 líneas del archivo?

```
# Muestra las primeras 6 líneas
head(meta_maiz)
     Nombre_comun         Raza_Primaria Raza_Secundaria A.o._de_colecta
1    Ocho carreras              Apachito              NA            2009
2 Chalque̱o Criollo              Chalque̱o              NA            2008
3   Ma\xcc_z Dulce Dulcillo del Noroeste              NA            2007
4   Olotillo crema            Dzit-Bacal              NA            2009
5 Ma\xcc_z Criollo                Celaya              NA            2009
6 Ma\xcc_z Criollo   Elotes Occidentales              NA            2009
               Localidad  Municipio   Estado.1   Longitud  Latitud Altitud
1     Santo Tom\xcc\xc1s   Guerrero  Chihuahua -107.58300 28.68578    1975
2       Ignacio Zaragoza Cuapiaxtla   Tlaxcala  -97.92944 19.29083    2497
3            Agua Blanca      Y̩cora     Sonora -108.92467 28.53703    1435
4 Nuevo Vicente Guerrero Villacorzo    Chiapas  -92.97972 16.03225     618
5            El Ahuacate  Uriangato Guanajuato -101.11889 20.09111    1877
6              Comonfort  Comonfort Guanajuato -100.76583 20.74417    1800
                          Ruizetal2008_grupo         Sanchezetal_grupo Categ.Altitud
1                       1A_templado540-640mm       Sierra de Chihuahua           mid
2                                                           C\xcc_nico          high
3                     2A_semicalido500-870mm                 Chapalote           mid
4                     3A_muycalido990-1360mm Maduraci\xcc_n tard\xcc_a           low
5 2A_semicalido500-870mm y 1B_templado>650mm       Dentados tropicales           mid
6 2C_semicalido740-855mm y 1B_templado>650mm              Ocho Hileras           mid
                  Rbiogeo            DivFloristic     PeralesBiog
1 Sierra Madre Occidental Sierra Madre Occidental Ca\xe5_ones Chi
2           Eje Volcanico  Serranias Meridionales     Mesa Centra
3 Sierra Madre Occidental Sierra Madre Occidental     Sierras del
4      Costa del Pacifico  Serranias Transismicas         Chiapas
5           Eje Volcanico            Altiplanicie    Baj\xe5\xc1o
6           Eje Volcanico            Altiplanicie    Baj\xe5\xc1o
```




¿Cuántas muestras hay?


```
Número de muestras
nrow(meta_maiz)
[1] 165
```



¿De cuántos estados se tienen muestras?


```
# Número de estados con muestras
length(unique(meta_maiz$Estado))
[1] 19
```



¿Cuántas muestras fueron colectadas antes de 1980?


```
# Muestras colectadas antes de 1980
sum(meta_maiz$Año._de_colecta < 1980, na.rm = TRUE)
[1] 0
```



¿Cuántas muestras hay de cada raza?


```
# Número de muestras por raza
table(meta_maiz$Raza)
Ancho                    Apachito                   Arrocillo 
                          3                           2                           4 
                       Azul            Blando de Sonora                        Bofo 
                          2                           1                           1 
                 C\xcc_nico           C\xcc_nico Norte̱o               Cacahuacintle 
                         16                           3                           5 
                     Celaya                    Chalque̱o                   Chapalote 
                          3                           7                           2 
                   Comiteco Complejo Serrano de Jalisco                      Conejo 
                          5                           2                           4 
               Coscomatepec     Cristalino de Chihuahua                       Dulce 
                          3                           2                           1 
      Dulcillo del Noroeste                  Dzit-Bacal          Elotero de Sinaloa 
                          2                           3                           5 
         Elotes C\xcc_nicos         Elotes Occidentales                       Gordo 
                         14                           4                           2 
                       Jala                     Mushito           Nal-tel de Altura 
                          4                           3                           5 
                 Olot\xcc_n                    Olotillo                      Onave̱o 
                          4                           6                           2 
      Palomero de Chihuahua           Palomero Toluque̱o                   Pepitilla 
                          1                           1                           4 
                  Rat\xcc_n                  Reventador            Tablilla de Ocho 
                          3                           2                           2 
                Tabloncillo           Tabloncillo Perla                       Tehua 
                          4                           3                           2 
                 Tepecintle                      Tuxpe̱o               Tuxpe̱o Norte̱o 
                          4                           4                           2 
                     Vande̱o           Zamorano Amarillo              Zapalote Chico 
                          4                           3                           1 
            Zapalote Grande             Zea m. mexicana          Zea m. parviglumis 
                          1                           2                           2
```

En promedio ¿a qué altitud fueron colectadas las muestras?


```
Altitud promedio, máxima y mínima
> mean(meta_maiz$Altitud, na.rm = TRUE)
[1] 1519.242
```



¿Y a qué altitud máxima y mínima fueron colectadas?


```
> max(meta_maiz$Altitud, na.rm = TRUE)
[1] 2769
> min(meta_maiz$Altitud, na.rm = TRUE)
[1] 5
```



Crea una nueva df de datos sólo con las muestras de la raza OlotilloCrea una nueva df de datos sólo con las muestras de la raza Reventador, Jala y Ancho


```
# Nueva df con razas Reventador, Jala y Ancho
sub_raza <- subset(meta_maiz, Raza %in% c("Reventador", "Jala", "Ancho"))
```



Escribe la matriz anterior a un archivo llamado "submat.cvs" en /meta.

```
write.csv(sub_raza, "~/Documents/meta/submat.csv", row.names = FALSE)
> exists("sub_raza")         # ¿existe el objeto?
[1] TRUE
> is.data.frame(sub_raza)    # ¿es data.frame?
[1] TRUE
> nrow(sub_raza); ncol(sub_raza)  # tamaño
[1] 9
[1] 22
> head(sub_raza)             # vistazo rápido
    OrderColecta NSiembra      Origen       Raza          Estado
16             1       27    2009-232      Ancho Estado de M̩xico
30             2       47 Ig-2010-294       Jala         Nayarit
37             1       30    2009-236      Ancho Estado de M̩xico
43             2       46 Ig-2010-201       Jala         Nayarit
57             1       29    2009-235      Ancho Estado de M̩xico
103            1      114     2007-09 Reventador          Sonora
    Num_Colecta   Nombre_comun Raza_Primaria Raza_Secundaria
16     2009-232          Ancho         Ancho              NA
30       2003-2        Criollo          Jala              NA
37     2009-236          Ancho         Ancho              NA
43      NAY-129        Criollo          Jala              NA
57     2009-235 Ancho Amarillo         Ancho              NA
103 SON2007-009     Reventador    Reventador              NA
    A.o._de_colecta                     Localidad Municipio        Estado.1
16             2009 Carretera San Juan Tepeoculco  Atlautla Estado de M̩xico
30             2003                       Jomulco      Jala         Nayarit
37             2009            San Andr̩s Tlalamac  Atlautla Estado de M̩xico
43             1951                          Jala      Jala         Nayarit
57             2009 Carretera San Juan Tepeoculco  Atlautla Estado de M̩xico
103            2007                     La Isleta     ́lamos          Sonora
      Longitud  Latitud Altitud              Ruizetal2008_grupo
16   -98.77861 18.99750    2226                          4_Jala
30  -104.42869 21.10167    1153 2A_semicalido500-870mm y 4_Jala
37   -98.80944 18.96806    2073                          4_Jala
43  -104.44056 21.10000    1060 2A_semicalido500-870mm y 4_Jala
57   -98.77861 18.99750    2226                          4_Jala
103 -108.91194 26.84361     204          2A_semicalido500-870mm
    Sanchezetal_grupo Categ.Altitud            Rbiogeo
16       Ocho Hileras          high      Eje Volcanico
30       Ocho Hileras           mid Costa del Pacifico
37       Ocho Hileras          high      Eje Volcanico
43       Ocho Hileras           mid Costa del Pacifico
57       Ocho Hileras          high      Eje Volcanico
103         Chapalote           low Costa del Pacifico
              DivFloristic PeralesBiog
16  Serranias Meridionales Mesa Centra
30  Serranias Meridionales Sierras del
37  Serranias Meridionales Mesa Centra
43  Serranias Meridionales Sierras del
57  Serranias Meridionales Mesa Centra
103         Costa Pacifica Sierras del
> carpeta_meta <- file.path("~", "Documents", "meta")
> archivo_csv  <- file.path(carpeta_meta, "submat.csv")
> archivo_csv
[1] "~/Documents/meta/submat.csv"
> if (!dir.exists(carpeta_meta)) {
+   dir.create(carpeta_meta, recursive = TRUE)
+ }
> dir.exists(carpeta_meta)   # debería devolver TRUE
[1] TRUE
> write.csv(sub_raza, archivo_csv, row.names = FALSE)
> file.exists(archivo_csv)   # TRUE si el archivo está allí
[1] TRUE
> file.info(archivo_csv)     # información del archivo (tamaño, fecha, etc.)
                            size isdir mode               mtime
~/Documents/meta/submat.csv 2492 FALSE  644 2025-09-09 00:13:18
                                          ctime               atime uid gid
~/Documents/meta/submat.csv 2025-09-09 00:13:18 2025-09-09 00:13:18 501  20
                                 uname grname
~/Documents/meta/submat.csv macbookair  staff
> 
> head(check)
Error in head(check) : object 'check' not found
> dim(check)
Error: object 'check' not found
> check <- read.csv(archivo_csv, stringsAsFactors = FALSE)
> head(check)
  OrderColecta NSiembra      Origen       Raza          Estado Num_Colecta
1            1       27    2009-232      Ancho Estado de M̩xico    2009-232
2            2       47 Ig-2010-294       Jala         Nayarit      2003-2
3            1       30    2009-236      Ancho Estado de M̩xico    2009-236
4            2       46 Ig-2010-201       Jala         Nayarit     NAY-129
5            1       29    2009-235      Ancho Estado de M̩xico    2009-235
6            1      114     2007-09 Reventador          Sonora SON2007-009
    Nombre_comun Raza_Primaria Raza_Secundaria A.o._de_colecta
1          Ancho         Ancho              NA            2009
2        Criollo          Jala              NA            2003
3          Ancho         Ancho              NA            2009
4        Criollo          Jala              NA            1951
5 Ancho Amarillo         Ancho              NA            2009
6     Reventador    Reventador              NA            2007
                      Localidad Municipio        Estado.1   Longitud
1 Carretera San Juan Tepeoculco  Atlautla Estado de M̩xico  -98.77861
2                       Jomulco      Jala         Nayarit -104.42869
3            San Andr̩s Tlalamac  Atlautla Estado de M̩xico  -98.80944
4                          Jala      Jala         Nayarit -104.44056
5 Carretera San Juan Tepeoculco  Atlautla Estado de M̩xico  -98.77861
6                     La Isleta     ́lamos          Sonora -108.91194
   Latitud Altitud              Ruizetal2008_grupo Sanchezetal_grupo
1 18.99750    2226                          4_Jala      Ocho Hileras
2 21.10167    1153 2A_semicalido500-870mm y 4_Jala      Ocho Hileras
3 18.96806    2073                          4_Jala      Ocho Hileras
4 21.10000    1060 2A_semicalido500-870mm y 4_Jala      Ocho Hileras
5 18.99750    2226                          4_Jala      Ocho Hileras
6 26.84361     204          2A_semicalido500-870mm         Chapalote
  Categ.Altitud            Rbiogeo           DivFloristic PeralesBiog
1          high      Eje Volcanico Serranias Meridionales Mesa Centra
2           mid Costa del Pacifico Serranias Meridionales Sierras del
3          high      Eje Volcanico Serranias Meridionales Mesa Centra
4           mid Costa del Pacifico Serranias Meridionales Sierras del
5          high      Eje Volcanico Serranias Meridionales Mesa Centra
6           low Costa del Pacifico         Costa Pacifica Sierras del
> dim(check)
[1]  9 22
> system(paste("open", carpeta_meta))
> write.csv2(sub_raza, archivo_csv, row.names = FALSE)  # separador ; y decimal ,
> # Nueva df con razas Reventador, Jala y Ancho
> sub_raza <- subset(meta_maiz, Raza %in% c("Reventador", "Jala", "Ancho"))
> 
```


