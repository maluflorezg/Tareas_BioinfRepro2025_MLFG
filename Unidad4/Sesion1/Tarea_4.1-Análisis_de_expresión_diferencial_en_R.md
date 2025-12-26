# Tarea 4.1 - Análisis de expresión diferencial en R

### Martha Flórez

---

### 1. INTRODUCCION

El análisis de expresión génica mediante microarreglos permite identificar genes diferencialmente expresados en respuesta a factores genéticos, ambientales o a la interacción entre ambos. En este trabajo se analizan datos de expresión génica en tejido cardíaco de ratón con el objetivo de evaluar el efecto del **genotipo del cromosoma Y**, el **tratamiento hormonal (castración)** y su **interacción** sobre la expresión génica.

El diseño experimental incluyó dos genotipos (B y BY) y dos condiciones de tratamiento (intacto y castrado), generando un diseño factorial que permite evaluar efectos marginales e interacciones. El análisis se realizó utilizando el paquete **maanova**, incorporando permutaciones para una estimación robusta de los valores p y aplicando corrección por FDR.. El ARN se hibridizó a BeadChips Illumina MouseRef-8 v2.0 que contienen ocho microarreglos con 25,697 sondas cada uno. Solo se seleccionaron arbitrariamente 5000 sondas para este tutorial.

### 2. OBJETIVOS

1. Determinar si existe expresión diferencial entre genotipos.

2. Determinar si existe expresión diferencial entre tratamientos.

3. Evaluar las diferencias en la respuesta al tratamiento entre los dos genotipos.

---

Obtener la matriz completa de datos, disponible en el archivo `Illum_data.txt`. Asegúrese tarmbién usar el archivo de anotaciones `MouseRef-8_annot_full.txt` que contiene todas las 25697 sondas. Diseño experimental `YChrom_design.csv`. Importar la matriz en R, seleccionar aleatoriamente 5000 filas y exportar el subset de datos en un archivo plano separado por tabulaciones.

---

### 3. Control de calidad y exploración de los datos

#### 3.1 Boxplot por calidad de sonda

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/boxplot_raw_probe_qc.png?raw=true)

**Figura 1.** Muestra diagramas de caja de los valores de expresión en escala log2, coloreados según la calidad de la sonda. Las distribuciones presentan medianas y rangos intercuartílicos comparables entre microarreglos, sin evidenciar muestras con valores extremos o comportamientos anómalos. Esto indica una adecuada calidad técnica de los datos y permite continuar con el análisis sin excluir muestras completas.

---

#### 3.2 Boxplot por tratamiento

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/boxplot_raw_treatment.png?raw=true)

**Figura 2**. Se presentan diagramas de caja de los valores de expresión log2 agrupados por tratamiento. Las distribuciones son similares entre ratones intactos y castrados, lo que sugiere que no existen sesgos globales de intensidad asociados al tratamiento y que las diferencias detectadas posteriormente corresponden a cambios específicos en la expresión génica.

---

#### 3.3 Correlación entre microarreglos

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/Pairs_scatter_log2.png?raw=true)

**Figura 3.** Corresponde a gráficos de dispersión entre pares de microarreglos. Se observa una alta correlación entre muestras, reflejada en la concentración de puntos a lo largo de la diagonal. Esto confirma una buena reproducibilidad técnica y biológica de los datos.

---

### 4. Filtrado de sondas

Se aplicó un filtrado basado en las probabilidades de detección calculadas por BeadStudio. Una sonda se consideró presente cuando fue detectada (p < 0.04) en al menos el **25% de las muestras de todos los grupos experimentales**. Este criterio asegura la retención de sondas con expresión consistente en todo el diseño experimental, reduciendo ruido y aumentando la confiabilidad del análisis posterior.

```
probe_present <- Data.Raw[, detection] < 0.04  # TRUE/FALSE por sonda x muestra

# Conteo de TRUE por grupo (sondas x grupos)
detected_per_group <- t(apply(probe_present, 1, tapply, design$Group, sum))

# Tamaño de cada grupo (muestras por grupo)
n_per_group <- table(design$Group)

# Umbral 25% por grupo (redondeo hacia arriba)
thr <- ceiling(0.25 * as.numeric(n_per_group))
names(thr) <- names(n_per_group)

# Mantener sonda si cumple el umbral en TODOS los grupos
present <- apply(detected_per_group, 1, function(x) all(x >= thr[colnames(detected_per_group)]))

# Aplicar filtro
normdata <- normdata[present, , drop = FALSE]
annot    <- annot[present, , drop = FALSE]
```

---

### 5. Modelo estadístico y permutaciones

El análisis de expresión diferencial se realizó mediante un modelo lineal ajustado con el paquete **maanova**, evaluando los efectos de **genotipo**, **tratamiento** y su **interacción**. Para la estimación de los valores p se utilizaron **500 permutaciones**, lo que proporciona una aproximación empírica robusta, especialmente adecuada para diseños con tamaño muestral limitado..

```
test.cmat <- matest(
  madata,
  fit.fix,
  term = "Group",
  Contrast = cmat,
  n.perm = 500,          # aquí el cambio
  test.type = "ttest",
  shuffle.method = "sample",
  verbose = TRUE
)
Doing F-test on observed data ...
Doing permutation. This may take a long time ... 
Finish permutation #  100 
Finish permutation #  200 
Finish permutation #  300 
Finish permutation #  400 
Finish permutation #  500 
There were 50 or more warnings (use warnings() to see the first 50)
```

#### 5.1 Distribución de p-values ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/P-values%20Hist.png?raw=true)

**Figura 4.** Muestra histogramas de los p-values observados y permutados para los distintos contrastes. Se observa una desviación de la distribución uniforme esperada bajo la hipótesis nula, particularmente para el efecto de interacción, lo que sugiere la presencia de señales biológicas reales.

---

### 6. Contar genes expresados diferencialmente

Aplicando un umbral de **FDR = 0.19**, se identificaron:

- **893 genes** diferencialmente expresados por efecto de **genotipo**

- **980 genes** diferencialmente expresados por efecto de **tratamiento**

- **122 genes** con efecto significativo de **interacción genotipo × tratamiento**

Estos resultados indican que tanto la variación genética del cromosoma Y como el estado hormonal influyen significativamente en la expresión génica, y que un subconjunto de genes responde de manera dependiente del contexto genético.

```
fdr_th     <- 0.19
results <- read.csv("DE_results.csv")
sum(results$FDR.Geno <= 0.19)   # Genes afectados por el genotipo
[1] 893
sum(results$FDR.Trt  <= 0.19)   # Genes afectados por el tratamiento
[1] 980
sum(results$FDR.Int  <= 0.19)   # Genes con efecto de interacción
[1] 122
```

#### 6.1 Diagramas de Venn

# ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/vennDiagram_DiffExprs.png?raw=true)

**Figura 5.** Se muestra el diagrama de Venn de los genes diferencialmente expresados por genotipo, tratamiento e interacción. Se observa un solapamiento parcial entre los conjuntos, destacando que la mayoría de los genes con interacción constituyen un grupo específico y no simplemente la intersección de efectos marginales.

---

### 7. Análisis de genes con interacción

Se analizaron en detalle los genes con **FDR de interacción ≤ 0.19**. Los resultados muestran:

```
genes_int <- results$FDR.Int <= 0.19
sum(genes_int)   # 104 genes con interacción significativa
[1] 122
```

Usando solamente sondas seleccionadas por efectos de interacción, cuente las sondas significativas para el efecto de tratamiento en ratones del genotipo B y/o del genotipo BY. 

```
> # Contrastes de genotipo dentro de cada tratamiento
> sum(results$FDR.Geno_I[genes_int] <= 0.19)   # Geno_I = Intacto
[1] 45
> sum(results$FDR.Geno_C[genes_int] <= 0.19)   # Geno_C = Castrado
[1] 86
> 
> # Contrastes de tratamiento dentro de cada genotipo
> sum(results$FDR.Trt_B[genes_int]  <= 0.19)   # Trt_B = Genes en B
[1] 39
> sum(results$FDR.Trt_BY[genes_int] <= 0.19) # Trt_B = Genes en BY
[1] 97
```

Cargue la librería `limma` para crear diagramas de Venn. Contar genes para cada combinación de efectos marginales y de interacción.

```
>  Counts.DE <- vennCounts(Genes.DE)
> print(Counts.DE)
  FDR.Geno FDR.Trt FDR.Int Counts
1        0       0       0    655
2        0       0       1     18
3        0       1       0    452
4        0       1       1     22
5        1       0       0    377
6        1       0       1     23
7        1       1       0    309
8        1       1       1     48
attr(,"class")
[1] "VennCounts"
> Counts.Int_Geno <- vennCounts(Genes.Int_Geno)
> 
>  print(Counts.Int_Geno)
  FDR.Geno_I FDR.Geno_C Counts
1          0          0      1
2          0          1     71
3          1          0     28
4          1          1     11
attr(,"class")
[1] "VennCounts"
> Counts.Int_Trt  <- vennCounts(Genes.Int_Trt) 
> 
>  print(Counts.Int_Trt)
  FDR.Trt_B FDR.Trt_BY Counts
1         0          0      0
2         0          1     75
3         1          0     22
4         1          1     14
attr(,"class")
[1] "VennCounts"
```

- Un mayor número de genes con efecto de genotipo en animales **castrados** respecto a intactos.

- Un mayor número de genes con efecto de tratamiento en el genotipo **BY** en comparación con B.

Esto sugiere que la respuesta transcripcional al tratamiento hormonal está modulada por la variación genética del cromosoma Y.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion1/DE_tutorial/output/vennDiagram_Int.png?raw=true)

**Figura 6.** Diagramas de Venn específicos para los contrastes dentro de cada genotipo y tratamiento, evidenciando efectos dependientes del contexto experimental.Análisis de los genes con interacción.

---

### 8. Análisis funcional (Gene Ontology)

En vez de seleccionar un gen si cualquier sonda asPara el análisis funcional se aplicó un criterio conservador, seleccionando genes solo cuando **todas las sondas asociadas al gen** fueron significativas.

```
genes.int <- tapply(probes.int, results$EntrezID, all)
```

```
        GO.ID                                        Term Annotated Significant
1  GO:0000122 negative regulation of transcription by ...        53          10
2  GO:0035914        skeletal muscle cell differentiation         8           3
3  GO:0006935                                  chemotaxis        26           5
4  GO:0042886                             amide transport        26           5
5  GO:0048584 positive regulation of response to stimu...       128          12
6  GO:0045944 positive regulation of transcription by ...        83           9
7  GO:0070372         regulation of ERK1 and ERK2 cascade        19           4
8  GO:0042752              regulation of circadian rhythm        10           3
9  GO:0016477                              cell migration       101          10
10 GO:0032268 regulation of cellular protein metabolic...       190          15
11 GO:0043502             regulation of muscle adaptation        11           3
12 GO:0007517                    muscle organ development        20           6
13 GO:0030032                      lamellipodium assembly        12           3
14 GO:2000145                 regulation of cell motility        77           8
15 GO:0043065    positive regulation of apoptotic process        48           6
16 GO:0043068 positive regulation of programmed cell d...        48           6
17 GO:0015833                           peptide transport        23           4
18 GO:0040012                    regulation of locomotion        79           8
19 GO:0006915                           apoptotic process       165          13
20 GO:0008219                                  cell death       184          14
   Expected Rank in Fisher.classic Fisher.classic Fisher.elim
1      2.16                      6        3.2e-05     3.2e-05
2      0.33                     23         0.0031      0.0031
3      1.06                     25         0.0033      0.0033
4      1.06                     26         0.0033      0.0033
5      5.22                     29         0.0045      0.0045
6      3.38                     34         0.0054      0.0054
7      0.77                     39         0.0062      0.0062
8      0.41                     41         0.0063      0.0063
9      4.12                     42         0.0065      0.0065
10     7.74                     51         0.0077      0.0077
11     0.45                     54         0.0085      0.0085
12     0.81                     10        9.2e-05      0.0099
13     0.49                     58         0.0110      0.0110
14     3.14                     59         0.0113      0.0113
15     1.96                     60         0.0117      0.0117
16     1.96                     61         0.0117      0.0117
17     0.94                     64         0.0125      0.0125
18     3.22                     66         0.0131      0.0131
19     6.72                     67         0.0135      0.0135
20     7.50                     71         0.0139      0.0139
```

El análisis GO (Biological Process) reveló enriquecimiento en procesos relacionados con:

- Desarrollo y adaptación muscular

- Migración y motilidad celular

- Regulación de la transcripción

- Apoptosis y muerte celular

- Respuesta a estímulos y señalización ERK

---

### 9. Conclusión

En este trabajo se realizó un análisis de expresión diferencial en tejido cardíaco de ratón considerando efectos de genotipo, tratamiento hormonal y su interacción. Los resultados muestran que ambos factores influyen significativamente en la expresión génica y que existe un conjunto relevante de genes cuya respuesta depende del contexto genético del cromosoma Y.

El uso de filtrado estricto, permutaciones y un umbral conservador de FDR permitió obtener resultados robustos y biológicamente interpretables. El análisis funcional identificó procesos clave relacionados con la función muscular, señalización celular y apoptosis, reforzando la relevancia biológica de los genes identificados. En conjunto, este estudio destaca la importancia de incorporar efectos de interacción en el análisis de datos de expresión génica.
