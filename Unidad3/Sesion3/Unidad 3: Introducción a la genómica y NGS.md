## Unidad 3: Introducción a la genómica y secuenciación de siguiente generación

### Sesión 3.3 - Análisis de secuencias

En esta sesión aprenderemos los aspectos esenciales sobre el análisis de datos de secuenciación masiva para la detección de variantes genéticas.

Flujo de trabajo

### 1. Filtrado de lecturas

Las lecturas crudas pueden contener secuencias de adaptadores usados en la secuenciación, contaminantes y sitios con bajas calidades. Comúnmente en las técnicas NGS el extremo 3' posee una menor calidad que el extremo 5'. El procesamiento de las lecturas para eliminar las secuencias pertenecientes a adaptadores y los pares de bases con baja calidad se denomina Trimming. Para realizar un trimming adecuado de lecturas se debe hacer un análisis previo de la calidad de la secuenciación mediante el programa FastQC. Una vez realizado este análisis se realiza un trimming de lecturas usando el programa bbduk en 3 pasos:

### 1.1 Eliminación de adaptadores

Para usar en el cluster genoma:

```
module load BBMap
```

Comando:

```shell
bbduk.sh -Xmx2g threads=1 \in1=~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz \in2=~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R2.fastq.gz \out1=S7_R1_filter1.fastq.gz \out2=S7_R2_filter1.fastq.gz \ref=~/resources/bbmap/adapters.fa tpe tbo
```

La entrada in1, in2 son las lecturas crudas. Esto crea dos archivos con el sufijo "filter1.fastq.gz" correspondiente a las lecturas pareadas donde se eliminan la secuencia de adaptadores y contaminantes que alinean con las secuencias del archivo fasta "adapters.fa".

## 1.2 Eliminación de lecturas que contengan secuencia del fago phix

Comando:

```shell
bbduk.sh -Xmx2g threads=1 \in1=S7_R1_filter1.fastq.gz \in2=S7_R2_filter1.fastq.gz \out1=S7_R1_filter2.fastq.gz \out2=S7_R2_filter2.fastq.gz \ref=~/resources/bbmap/phix174_ill.ref.fa.gz
```

La entrada (in1, in2) son las lecturas filtradas en el paso anterior. Esto crea un 2 archivos "filter2.fastq.gz" correspondiente a las lecturas pareadas donde se eliminan la secuencia del fago phix que alinean con las secuencias del archivo fasta "phix174_ill.ref.fa.gz".

## 1.3 Filtrado por calidad de las lecturas

Comando:

```
bbduk.sh -Xmx2g threads=1 \
in1=S7_R1_filter2.fastq.gz \
in2=S7_R2_filter2.fastq.gz \
out1=S7_R1_filter3.fastq.gz \
out2=S7_R2_filter3.fastq.gz \
qtrim=w trimq=20 minlength=30 minavgquality=20
```

La entrada (in1, in2) son las lecturas filtradas en el paso anterior. Estas lecturas son filtradas por calidad usando una ventana deslizante con el parámetro "qtrim=w", que elimina la región de la lectura con una calidad menor a 20 en adelante "trimq=20" (hacia el extremo 3'), luego evalúa el largo resultante de la lectura, eliminandola si es menor a 30 pb "minlength=30". Como último filtro, elimina la lectura si el promedio de calidad total es <= 20 "minavgquality=20". De esta forma se obtienen las lecturas filtradas ("filter3"). Estos parámetros fueron establecidos como óptimos al analizar las lecturas crudas con el programa FastQC, pero pueden ser modificados acorde a la calidad de los datos.

## 2. Alineamiento de lecturas

## 2.1 Alinear lecturas contra el genoma de referencia

Se alinean las lecturas contra el genoma de referencia, obteniéndose un archivo SAM (Sequence alignment map).

Para usar en el cluster genoma:

```
module load bwa
```

Comando:

```shell
bwa mem -t 4 -M /datos/reference/genomes/hg19_reference/hg19.fasta \S7_R1_filter3.fastq.gz \S7_R2_filter3.fastq.gz \
> S7.sam
```

Nota 1: Revise la [documentación de bwa](http://manpages.org/bwa) e inspeccione las distintas opciones que entrega bwa y los atributos que puede modificar.

El siguiente conjunto de operaciones de preprocesamiento formatea los datos para adaptarse a los requisitos de las herramientas GATK convirtiendo los datos de asignación en un archivo BAM ordenado por posición, con el campo "Read Group" añadido.

## 2.2 Convertir archivo sam a bam (binario)

Se obtiene un bam (binary alignment map) a partir del alineamiento en formato sam.

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar SamFormatConverter -I S7.sam -O S7.bam
```

## 2.3 Ordenar lecturas alineadas por posición

Obtenemos un archivo bam con las lecturas ordenadas por posición del alineamiento a la referencia.

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar SortSam \
>   I=S7.bam \
>   O=S7_sorted.bam \
>   SORT_ORDER=coordinate \
>   CREATE_INDEX=true
```

## 2.4 Añadir el campo Readgroup al archivo bam

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar AddOrReplaceReadGroups -I S7_sorted.bam -O S7_sorted_RG.bam -ID sample -LB Paired-end -PL Illumina -PU Unknown -SM sample
```

## 2.5 Indexar alineamiento

Cargar el módulo si está usando el cluster genoma:

```
module load samtools
```

Comando:

```shell
samtools index S7_sorted_RG.bam
```

## 2.6 Generar un reporte de calidad

Qualimap es una aplicación escrita en Java y R que posee una interfaz gráfica de usuario (GUI) y una interfaz de línea de comandos para facilitar el control de calidad de los datos de alineamiento de secuencias. Este programa proporciona una vista general de los datos que ayuda a detectar sesgos en la secuenciación y / o mapeo de los datos y facilita la toma de decisiones para un análisis posterior.

Cargar el módulo si está usando el cluster genoma:

```
module load qualimap
```

Comando:

```shell
qualimap bamqc -bam S7_sorted_RG.bam -gff ~/181004_curso_calidad_datos_NGS/regiones_blanco.bed -outdir ./S7_sorted_RG
```

---

---

## Anexo

Los pasos descritos en este anexo son necesarios previo a la ejecución de los procedimiento descritos en el tutorial y ya fueron realizados para facilitar su desarrollo en nuestro servidor. Si usted realiza estos análisis en otro servidor, necesitará realizar estos pasos previamente.

## 1. Preparar la referencia

El genoma humano de la referencia usado para el procesamiento de las lecturas es hg19. Para usar este genoma en formato fasta se debe procesar para generar distintos archivos necesarios para el flujo de trabajo.

### Procesamiento 1 (necesario para usar el programa BWA):

Comando:

```shell
bwa index -a bwtsw reference.fasta
```

### Procesamiento 2 (necesario para usar el programa BWA):

Comando:

```shell
samtools faidx reference.fasta
```

Procesamiento 3 (necesario para usar el programa GATK):

Comando:

```shell
java -jar picard.jar CreateSequenceDictionary REFERENCE=reference.fasta OUTPUT=reference.dict
```

Nota 1: La preparación de la referencia se debe realizar solo una vez, para efectos prácticos del curso la referencia ya se encuentra procesada con los comandos descritos.
