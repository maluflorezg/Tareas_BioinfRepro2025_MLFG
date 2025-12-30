# Tarea 4.3 Tutorial ‘Análisis de Expresión Diferencial a partir de Secuencias de RNA

## Martha Flórez

---

## 1. INTRODUCCIÓN

---

Los datos utilizados en este tutorial corresponden a cuatro librerías de lecturas pertenecientes a la arqueobacteria *Sulfolobus acidocaldarius.* Sobre este organismo, se introdujo una mutación knockdown en el gen Lrs14-like, del cual se conoce su rol en la formación de biopelículas, con el objetivo de estudiar los genes preponderantes en este fenotipo ya sea dependientes o independientes del gen previamente mutado. Para el desarrollo de este análisis, la arqueobacteria fue cultivada en un medio Plantónico y, por otro lado, en una Biopelícula, tanto con su genotipo Wildtype como con la mutación ya descrita en muestras independientes. En consecuencia, las cuatro librerías corresponden a los siguientes grupos experimentales:

1. Organismo Wildtype en medio plantónico, el cual se denominará “WildType_P”.

2. Wildtype cultivado en biopelícula, denominado “Wildtype_B”.

3. Organismo mutado en medio plantónico, se denominará Mutant_P.

4. Organismo mutado y cultivado en biopelícula, denominado Mutant_B.

---

## 2. METODOLOGÍA

---

### 2.1 Preliminar y entorno computacional

El análisis de RNA-seq se realizó utilizando herramientas de código abierto previamente instaladas en el servidor de cómputo, entre las que se incluyen **NGSQC Toolkit**, **HTSeq** y **edgeR**. Estas herramientas permiten llevar a cabo las etapas de control de calidad, filtrado de lecturas, alineamiento al genoma de referencia, cuantificación de expresión génica y análisis de expresión diferencial.

Los análisis se ejecutaron en un entorno Linux de alto rendimiento, lo que permitió paralelizar ciertos procesos y optimizar los tiempos de ejecución. Para organizar el flujo de trabajo y asegurar la reproducibilidad, se creó una carpeta de trabajo específica desde donde se ejecutaron los comandos y scripts correspondientes:

```shell
cd <mi usuario>
mkdir -p RNA_seq/code
cd RNA_seq/code
```

### 2.2 Uso de carpetas preexistentes y acceso a los datos

Los datos correspondientes a los pasos preliminares del análisis (control de calidad, filtrado, alineamiento y conteo) se encontraban previamente procesados y disponibles en la carpeta del servidor `RNA_seq`. Con el fin de preservar la integridad de los datos originales, estos no fueron modificados ni copiados a la carpeta personal del usuario. En su lugar, los archivos fueron leídos directamente desde su ubicación original, ajustando las rutas de entrada en los scripts utilizados posteriormente.

Las rutas a los datos originales y archivos de referencia se definieron mediante las siguientes variables de entorno:

```shell
RAW=/home/bioinfo1/Tutorial_RNAseq/common/raw_data/
ANN=/home/bioinfo1/Tutorial_RNAseq/common/annot/
REF=/home/bioinfo1/Tutorial_RNAseq/common/ref_genome/Crear tres nuevas variables, las cuales contendrán la ubicación de las tres carpetas contenidas en ‘common’.
```

## 2.3 Definición de carpetas de salida

Para organizar los resultados generados en las distintas etapas del análisis, se definieron variables que contienen las rutas a las carpetas de salida correspondientes a cada paso del flujo de trabajo:

```
QC=../qc
FIL=../filtered
ALN=../alignment
CNT=../count
```

## 2.4 Control de calidad de las lecturas

El control de calidad de las lecturas se realizó utilizando el programa **IlluQC_PRLL.pl**, perteneciente al paquete **NGSQC Toolkit**, el cual genera reportes detallados sobre la calidad de las secuencias, incluyendo métricas como la distribución de puntajes PHRED, contenido GC y longitud de las lecturas.

Se creó una carpeta principal para el control de calidad y subcarpetas específicas para cada librería analizada:

```shell
mkdir $QC
mkdir "$QC/wild_planctonic" "$QC/wild_biofilm" \
      "$QC/mut_planctonic" "$QC/mut_biofilm"
```

Posteriormente, se ejecutó el análisis de calidad para cada librería de lecturas:

```shell
illuqc -se "$RAW/MW001_P.fastq" 5 A -onlystat -t 2 -o "$QC/wild_planctonic" -c 10 &
illuqc -se "$RAW/MW001_B3.fastq" 5 A -onlystat -t 2 -o "$QC/wild_biofilm" -c 10 &
illuqc -se "$RAW/0446_P.fastq" 5 A -onlystat -t 2 -o "$QC/mut_planctonic" -c 10 &
illuqc -se "$RAW/0446_B3.fastq" 5 A -onlystat -t 2 -o "$QC/mut_biofilm" -c 10 &
```

Los reportes generados permitieron evaluar la calidad general de las lecturas y definir criterios adecuados para el filtrado posterior.

### 2.5 Filtrado de secuencias

Basándose en los resultados del control de calidad, las lecturas fueron filtradas para eliminar aquellas con baja calidad. El criterio aplicado consistió en descartar lecturas con un puntaje PHRED menor a 20 en al menos el 80 % de su longitud total.

Para ello, se crearon las carpetas destinadas a almacenar las lecturas filtradas:

```shell
mkdir $FIL
mkdir "$FIL/wild_planctonic" "$FIL/wild_biofilm" "$FIL/mut_planctonic" "$FIL/mut_biofilm"
```

El filtrado se realizó utilizando nuevamente **IlluQC**, aplicando los parámetros definidos:

```shell
illuqc -se "$RAW/MW001_P.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/wild_planctonic" -c 1 &
illuqc -se "$RAW/MW001_B3.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/wild_biofilm" -c 1 &
illuqc -se "$RAW/0446_P.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/mut_planctonic" -c 1 &
illuqc -se "$RAW/0446_B3.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/mut_biofilm" -c 1 &
```

Como resultado, se obtuvieron nuevas librerías en formato *fastq* con lecturas de mayor calidad, las cuales fueron utilizadas en los análisis posteriores.

---

### 2.6 Alineamiento al genoma de referencia

Las lecturas filtradas fueron alineadas contra el genoma de referencia de *Sulfolobus acidocaldarius* utilizando el algoritmo **BWA-MEM**, adecuado para lecturas cortas y medianas.

Se creó una carpeta para almacenar los archivos de alineamiento:

```shell
mkdir $ALN
```

Luego se ejecuta el alineamiento con ‘bwa mem’.

```shell
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/wild_planctonic/MW001_P.fastq_filtered" > "$ALN/MW001_P_aligned.sam" &
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/wild_biofilm/MW001_B3.fastq_filtered" > "$ALN/MW001_B3_aligned.sam" &
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/mut_planctonic/0446_P.fastq_filtered" > "$ALN/0446_P_aligned.sam" & bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/mut_biofilm/0446_B3.fastq_filtered" > "$ALN/0446_B3_aligned.sam" &
```

Los archivos SAM resultantes contienen la información de mapeo necesaria para cuantificar la expresión génica.

### 2.7 Estimación de Abundancia

La cuantificación de la expresión génica se realizó utilizando **HTSeq-count** (versión 0.6.1), el cual permite contar el número de lecturas alineadas a cada gen anotado en el genoma de referencia, según la información contenida en el archivo GFF3.

Se creó una carpeta específica para almacenar los archivos de conteo:

```shell
mkdir $CNT
```

Posteriormente, se ejecutó HTSeq-count para cada librería:

```shell
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/MW001_P_aligned.sam" "$ANN/saci.gff3" > "$CNT/MW001_P.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/MW001_B3_aligned.sam" "$ANN/saci.gff3" > "$CNT/MW001_B3.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/0446_P_aligned.sam" "$ANN/saci.gff3" > "$CNT/0446_P.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/0446_B3_aligned.sam" "$ANN/saci.gff3" > "$CNT/0446_B3.count" &
```

Los resultados obtenidos a través de este proceso, se utilizan como entrada para el siguiente paso, que es probar expresión diferencial.

---

### 3. PRUEBA DE EXPRESIÓN DIFERENCIAL

---

El análisis de expresión diferencial se realizó utilizando el paquete **edgeR**, considerando dos comparaciones principales: (i) diferencias asociadas al **medio de cultivo** (planctónico vs biopelícula) y (ii) diferencias asociadas al **genotipo** (wildtype vs mutante), excluyendo previamente los genes influenciados por el medio de cultivo.

Tras el filtrado inicial, se conservaron únicamente aquellos genes con niveles de expresión suficientes (CPM > 1 en al menos tres de las cuatro librerías), excluyendo además categorías técnicas como lecturas no alineadas o ambiguas. Este paso permitió reducir el ruido técnico y enfocarse en genes biológicamente informativos.

Obtener pseudoconteos y transformarlos a escala logarítmica. Estos valores corresponden a los conteos normalizados por el tamaño de cada librería y fueron calculados en la etapa donde se aplicó la función ‘exactTest’

### 3.1 Pasos preliminares

En primer lugar, se define el directorio con los archivos de entrada y aquellos donde se almacenarán los resultados.

```r
input_dir  <- file.path("..","count")
output_pseudo <- file.path("..","diff_expr", "pseudocounts") 
output_histogram <- file.path("..","diff_expr", "histograms") 
output_pvalue_fdr <- file.path("..","diff_expr", "pvalue_fdr") 
output_table <- file.path("..","diff_expr", "tables")
```

Luego, se comprueba si el directorio de entrada existe y se crean las carpetas de salidas.

```r
if(!file.exists(input_dir)){  stop("Data directory doesn't exist: ", input_dir)}
if(!file.exists(output_pseudo)){  dir.create(output_pseudo, mode = "0755", recursive=T)}
if(!file.exists(output_histogram)){  dir.create(output_histogram, mode = "0755", recursive=T)}
if(!file.exists(output_pvalue_fdr)){  dir.create(output_pvalue_fdr, mode = "0755", recursive=T)}
if(!file.exists(output_table)){  dir.create(output_table, mode = "0755", recursive=T)}
```

Cargar librería ‘edgeR’ ([Bioconductor - edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html)), la cual proporciona la funciones que serán necesarias para ejecutar la prueba estadística de expresión diferencial.

### 3.2 Carga y procesamiento de archivos de entrada

Leer archivos de entrada y asignarles nombres a sus columnas.

```r
library(edgeR)

wild_p <- read.delim(file=file.path(input_dir, "MW001_P.count"), sep="\t", header = F, check=F); colnames(wild_p) <- c("Gen_ID", "Count")
wild_b <- read.delim(file=file.path(input_dir, "MW001_B3.count"), sep="\t", header = F, check=F); colnames(wild_b) <- c("Gen_ID", "Count")
mut_p <- read.delim(file=file.path(input_dir, "0446_P.count"), sep="\t", header = F, check=F); colnames(mut_p) <- c("Gen_ID", "Count")
mut_b <- read.delim(file=file.path(input_dir, "0446_B3.count"), sep="\t", header = F, check=F); colnames(mut_b) <- c("Gen_ID", "Count")
```

Juntar los cuatro set de datos.

```r
rawcounts <- data.frame(wild_p$Gen_ID, WildType_P = wild_p$Count, WildType_B = wild_b$Count, Mutant_P = mut_p$Count, Mutant_B = mut_b$Count, row.names = 1)
```

Calcular RPKM

```r
 rpkm <- cpm(rawcounts)
```

Remover filas que no serán utilizadas y aquellos genes con un valor de RPKM menor a 1, en tres de las cuatro librerías.

```r
to_remove <- rownames(rawcounts) %in% c("__no_feature","__ambiguous","__too_low_aQual","__not_aligned","__alignment_not_unique")
keep <- rowSums(rpkm > 1) >= 3 & !to_remove
rawcounts <- rawcounts[keep,]
```

### 3.3 Expresión Diferencial para Medios de Cultivo

```
logFC    logCPM    PValue    FDR
Saci_1717    3.70387337466806    11.0360749319927    7.90501972943391e-24    7.84968459132788e-21
Saci_1078    3.36113268294571    12.0654248826909    1.57324622528499e-19    7.81116750853998e-17
Saci_2035    -2.89892577072479    9.37404054998175    4.46154202708226e-13    1.47677041096423e-10
Saci_1952    2.39302262010868    9.19171106911304    1.16556326777548e-10    2.43218343031541e-08
Saci_1953    2.15473544789581    11.0675158716528    1.22466436571773e-10    2.43218343031541e-08
Saci_1226    2.37857812604933    11.1335066555032    4.02667597667512e-10    6.66414874139732e-08
```

La comparación entre condiciones planctónicas y de biopelícula identificó un conjunto reducido pero altamente significativo de genes diferencialmente expresados (FDR < 0,1). Entre ellos, destacan genes con valores elevados de cambio de expresión (|logFC| > 2) y valores de FDR extremadamente bajos, lo que indica una fuerte asociación entre el estado de crecimiento en biopelícula y la regulación transcripcional.

Por ejemplo, genes como **Saci_1717** y **Saci_1078** mostraron una marcada sobreexpresión en biopelícula, mientras que **Saci_2035** presentó una regulación negativa significativa. Estos resultados sugieren que la transición desde un crecimiento planctónico hacia la formación de biopelículas implica una reorganización sustancial del transcriptoma, probablemente relacionada con procesos de adhesión celular, metabolismo y respuesta al ambiente.



### 3.4 Expresión Diferencial para Genotipos

```
logFC    logCPM    PValue    FDR
Saci_2195    2.20684995776688    11.0927705997396    1.02927302872814e-10    8.54296613844358e-08
Saci_2207    1.36932788985513    9.89460418433025    0.000261715122759092    0.108611775945023
Saci_2057    -1.14348689628657    8.87241522355152    0.000541628664096618    0.149850597066731
Saci_1180    1.48797210844368    8.17850098334313    0.00113928773391529    0.236402204787424
Saci_1894    -1.09947562618601    12.1524959095419    0.00202471619652092    0.336102888622473
Saci_0317    -1.24536685851964    7.65395217154354    0.0047115034094569    0.577439426649283
```

Una vez removidos los genes diferencialmente expresados por el medio de cultivo, se evaluó el efecto del genotipo. En esta comparación, se identificó un número considerablemente menor de genes con expresión diferencial significativa. El gen **Saci_2195** fue el único que alcanzó un nivel de significancia robusto tras corrección por múltiples pruebas (FDR < 0,1), mostrando una mayor expresión en el genotipo mutante.

Otros genes presentaron cambios en la expresión con valores de *p* bajos, pero no superaron el umbral de FDR, lo que indica que el efecto del *knockdown* del gen **Lrs14-like** sobre el transcriptoma global es más sutil en comparación con el impacto del medio de cultivo.

Los gráficos de pseudoconteos y los histogramas de valores *p* apoyan esta observación, mostrando una menor separación entre muestras wildtype y mutantes que entre condiciones de cultivo.

---

### 3.5 Pseudoconteos para cada gen

Se remarcando de un color diferente aquellos diferencialmente expresados.



![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion3/Figure/pair_expression_culture.png?raw=true)

**Figura 1.** El *knockdown* del gen **Lrs14-like** genera cambios limitados en el transcriptoma global, sugiriendo un efecto regulador específico o dependiente del contexto, en lugar de una alteración masiva de la expresión génica.



---

### 3.6 Expresión diferencial asociada al genotipo

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion3/Figure/pair_expression_genotype.png?raw=true)

**Figura 2.** La presencia consistente de genes diferencialmente expresados en ambos genotipos refuerza la idea de que el efecto del medio de cultivo es dominante y en gran medida independiente del estado del gen **Lrs14-like**.

---

### 3.7 Graficar un histograma de Valores P.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion3/Figure/histograms_pvalue.png?raw=true)

**Figura 3.** El medio de cultivo tiene un impacto global mucho más fuerte sobre la expresión génica que el genotipo, evidenciando que la transición a biopelícula induce cambios transcriptómicos robustos.

---

### 3.8 Graficar Valores P vs FDR.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad4/Sesion3/Figure/pvalue_fdr.png?raw=true)

**Figura 4.** Estos resultados confirman que, tras corregir por pruebas múltiples, solo el análisis por medio de cultivo identifica genes diferencialmente expresados de forma robusta, mientras que las diferencias asociadas al genotipo son débiles o no significativas a nivel global.

---

## 4. DISCUSIÓN

---

Los resultados obtenidos indican que el **medio de cultivo** constituye el principal factor que modula la expresión génica en *Sulfolobus acidocaldarius* bajo las condiciones estudiadas. La identificación de genes con cambios de expresión pronunciados y altamente significativos en la comparación planctónico vs biopelícula sugiere que la formación de biopelículas implica un programa transcripcional específico, consistente con la adaptación a un estilo de vida sésil y cooperativo.

En contraste, el efecto del *knockdown* del gen **Lrs14-like** sobre la expresión génica global fue limitado. Si bien se detectaron genes diferencialmente expresados asociados al genotipo, la magnitud y el número de estos cambios fueron menores. Esto podría indicar que **Lrs14-like** cumple un rol regulador más específico o indirecto, afectando un subconjunto reducido de genes o actuando en combinación con otros factores regulatorios.

Otra posibilidad es que la ausencia de réplicas biológicas limite el poder estadístico para detectar diferencias más sutiles asociadas al genotipo. En este contexto, los resultados sugieren que la respuesta transcripcional a la formación de biopelículas puede enmascarar parcialmente los efectos del *knockdown*, resaltando la importancia de considerar interacciones entre factores experimentales en estudios de expresión diferencial.

En conjunto, estos hallazgos refuerzan la utilidad del enfoque RNA-seq para identificar patrones globales de regulación génica y destacan la relevancia del diseño experimental para interpretar correctamente los efectos observados.

---

## 5. CONCLUSIÓN

El análisis de expresión diferencial permitió identificar cambios transcripcionales asociados tanto al medio de cultivo como al genotipo en *Sulfolobus acidocaldarius*. Los resultados muestran que el crecimiento en biopelícula induce cambios significativos y robustos en la expresión génica, mientras que el efecto del *knockdown* del gen **Lrs14-like** es más limitado y específico.

Estos hallazgos sugieren que la formación de biopelículas constituye un proceso biológico complejo que involucra una reprogramación transcripcional amplia, en tanto que el rol de **Lrs14-like** podría estar asociado a la regulación de un conjunto acotado de genes. Estudios futuros que incorporen réplicas biológicas y análisis funcionales permitirían profundizar en los mecanismos moleculares subyacentes y validar el rol de los genes identificados.
