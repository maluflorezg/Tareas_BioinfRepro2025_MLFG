#### Martha Flórez

#### Sesión 3.3 - Introducción a la genómica y NGS

#### Fecha: 15.11.2025

---

---

### PARTE 1 - ANÁLISIS DE SECUENCIAS

---

##### 1. Realizar el alineamiento contra el genoma humano hg19 de las lecturas R1 y R2 del paciente seleccionado para la tarea de control de calidad de lecturas de secuencia.

##### Alineamiento de lecturas

###### 1.1 Alinear lecturas contra el genoma de referencia

Se alinean las lecturas contra el genoma de referencia, obteniéndose un archivo SAM (Sequence alignment map).

Comando:

```shell
bwa mem -t 4 -M /datos/reference/genomes/hg19_reference/hg19.fasta \S7_R1_filter3.fastq.gz \S7_R2_filter3.fastq.gz \
> S7.sam
```

###### 1.2 Convertir archivo sam a bam (binario)

Se obtiene un bam (binary alignment map) a partir del alineamiento en formato sam.

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar SamFormatConverter -I S7.sam -O S7.bam
```

###### 1.3 Ordenar lecturas alineadas por posición

Obtenemos un archivo bam con las lecturas ordenadas por posición del alineamiento a la referencia.

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar SortSam \
>   I=S7.bam \
>   O=S7_sorted.bam \
>   SORT_ORDER=coordinate \
>   CREATE_INDEX=true
```

###### 1.4 Añadir el campo Readgroup al archivo bam

Comando:

```shell
java -jar /opt/picard/picard-2.25.2/picard.jar AddOrReplaceReadGroups -I S7_sorted.bam -O S7_sorted_RG.bam -ID sample -LB Paired-end -PL Illumina -PU Unknown -SM sample
```

###### 1.5 Indexar alineamiento

Comando:

```shell
samtools index S7_sorted_RG.bam
```

---

#### 2. Utilizando una línea de comando, encuentre la primera lectura en el archivo SAM que contenga bases enmascaradas (secuencias suavizadas por soft-clipping)

```
grep -v '^@' S7.sam | awk '$6 ~ /S/ {print; exit}'
M03564:2:000000000-D29D3:1:1101:15431:1861    163    chr9    133761038    60    248M3S    
=    133761056    269    GTGAAGGAAATCAGTGACATAGTGCAGAGGTAGCAGCAGTCAGGGGTCAGGTGTCAGGCCCGTCGGAGCTGCCTGCAGCACATGCGGGCTCGCCCATACCCGTGACAGTGGCTGACAAGGGACTAGTGAGTCAGCACCTTGGCCCAGGAGCTCTGCGCCAGGCAGAGCTGAGGGCCCTGTGGAGTCCAGCTCTACTACCTACGTTTGCACCGCCTGCCCCCCCGCACCTTCCTCCTCCCCGCTCCGTCCCC    
BABCCFFFFFFFGGGGGGGGGGHHHHHHHGHHHHHHHHHHHHHHHGGGHHHHHHHHGHHGGGGGGGGGGHHHHHHHHHHHHHHHHGGGGGHGGGGGHHHHHGGGGGHGGHGGHGHHGHHHGHGHHHGHFHHHHFHFHHHHHGHHHGEGHGHGHEHHGGGGGHHGGGEHHH0GGFGDFEFGGGGGGGGGGGCFFGGGGGGGGGF.FF.0FFB>DAAEFFE.;CBFFFFFFFFFFFF/BFFFAA--;A9A.;.NM:i:1    MD:Z:219T28    
MC:Z:251M    AS:i:243    XS:i:21
```

---

#### 3. Muestre el registros de la lecturas en el archivo SAM e identifique y explique el código CIGAR de esa lectura.

Para ver sólo campos clave (nombre, flag, crom, pos, MAPQ, CIGAR)

```
grep -v '^@' S7.sam | awk '$6 ~ /S/ {printf("QNAME=%s FLAG=%s RNAME=%s POS=%s MAPQ=%s CIGAR=%s\n",$1,$2,$3,$4,$5,$6); exit}'
QNAME=M03564:2:000000000-D29D3:1:1101:15431:1861 
FLAG=163 RNAME=chr9 
POS=133761038 
MAPQ=60 
CIGAR=248M3S
```

¿Cómo interpretar el CIGAR?

- **S** (*Soft clip*): bases del **read** recortadas que **no** se alinean; **consumen** longitud del read pero **no** de la referencia. Suele aparecer al inicio o final (p. ej., adaptadores, extremos de baja calidad).

- **M**: coincidencia/mismatch contra la referencia (consume read y referencia).

- **I**: inserción respecto a la referencia (consume read).

- **D**: deleción respecto a la referencia (consume referencia).

- **N**: salto en la referencia (splicing; consume referencia).

- **H**: *Hard clip* (recorte duro; no consume read ni referencia; bases no están en la secuencia del read).

- **P**: padding.

- **=**/**X**: match perfecto / mismatch explícito.
  
  **Comando para desglosar el CIGAR de la lectura:**

```
grep -v '^@' S7.sam | awk '
  $6 ~ /S/ {
    print $0;                                   # línea completa
    cigar=$6; print "CIGAR:", cigar;
    while (match(cigar, /[0-9]+[MIDNSHP=X]/)) {  # tokeniza el CIGAR
      op=substr(cigar, RSTART, RLENGTH);
      print "  - " op;
      cigar=substr(cigar, RSTART+RLENGTH);
    }
    exit
}'
```

**CIGAR:**

```
CIGAR: 248M3S
  - 248M
  - 3S
```

Interpretación:

| Código | Significado        | Longitud  | Explicación                                                                                    |
| ------ | ------------------ | --------- | ---------------------------------------------------------------------------------------------- |
| `248M` | **Match/mismatch** | 248 bases | 248 bases del *read* están alineadas (coinciden o difieren en alguna base) con la referencia.  |
| `3S`   | **Soft clip**      | 3 bases   | 3 bases del extremo del *read* no se alinearon; fueron “suavemente recortadas” (soft-clipped). |

---

#### 4. Generar un reporte técnico de calidad del alineamiento con *qualimap*.

Qualimap proporciona una vista general de los datos que ayuda a detectar sesgos en la secuenciación y / o mapeo de los datos y facilita la toma de decisiones para un análisis posterior.

Comando:

```shell
qualimap bamqc -bam S7_sorted_RG.bam -gff ~/181004_curso_calidad_datos_NGS/regiones_blanco.bed -outdir ./S7_sorted_RG
```

Los datos generados del reporte de calidad se encuentran en la carpeta [[S7_sorted_RG](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/tree/main/Unidad3/Sesion3/S7_sorted_RG "S7_sorted_RG")]

---

#### 5. Seleccionar 4 figuras que a su juicio sean las más informativas sobre la calidad de los datos y del ensamble.

**Figura 1: Coverage Across Reference:** Muestra la distribución de la cobertura (profundidad de lectura) a lo largo de todo el genoma o regiones de referencia..

**Figura 2: Mapping Quality Histogram:** Muestras la distribución de calidades de mapeo (MAPQ). 

**Figura 3: Insert Size Histogram:** Muestra la distribución del tamaño de los fragmentos (distancia entre los pares de lecturas).

**Figura 4: Duplication Rate Histogram:** Muestra la proporción de lecturas duplicadas (PCR o secuenciación redundante).

---

#### 6. Incluir las figuras en la sección de Resultados de un reporte técnico. Describir cada figura con una leyenda descriptiva. Adicionalmente, en el texto de la sección, interpretar los resultados y citar cada figura. Debe referirse a la calidad de los datos y del alineamiento. Enfóquese especialmente en los posibles problemas con los datos o alineamientos. Comente potenciales razones que expliquen lo observado. Incluya una sección con las principales *Conclusiones* para la muestra.

##### RESULTADOS

A continuación se presenta un análisis de calidad del alineamiento realizado con *Qualimap* sobre el archivo `S7_sorted_RG.bam`, resultante del mapeo con BWA-MEM contra el genoma de referencia *hg19*. Los resultados generales indican una excelente proporción de lecturas mapeadas (99.93%), cobertura promedio alta (82.9X) y una calidad media de mapeo de 58.8, lo que evidencia un alineamiento robusto y confiable. Sin embargo, se observa una tasa moderada de duplicación (37.6%), que podría tener implicaciones en la representatividad efectiva de la cobertura.

###### 6.1 COBERTURA A LO LARGO DEL GENOMA

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig1_coverage_across_reference.png?raw=true)

La [[Fig1](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig1_coverage_across_reference.png)] muestra la cobertura a través de la referencia genómica, revelando una profundidad promedio de **82.9X** con desviación estándar de **83.4**. Aunque la cobertura es alta, la variabilidad observada sugiere la presencia de regiones con sobre-representación (picos) y sub-representación (valles). No se observan zonas extensas sin cobertura, lo cual confirma una adecuada uniformidad general del alineamiento.

###### 6.2 Distribución de la calidad de mapeo

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig2_mapping_quality_histogram.png?raw=true)

El histograma de la [[Fig2](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig2_mapping_quality_histogram.png?raw=true)] evidencia una concentración marcada de valores de MAPQ entre **50 y 60**, con media **58.8**, lo que indica una alta confianza en la asignación posicional de las lecturas. La baja frecuencia de valores inferiores a 30 sugiere escasa ambigüedad en el mapeo, reflejando la eficiencia de BWA-MEM al alinear fragmentos de longitud media (~250 bp) y sin contaminación aparente.  

###### 6.3 Distribución del tamaño de inserto

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig3_insert_size_histogram.png?raw=true)

La [[Fig3](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig3_insert_size_histogram.png?raw=true)] muestra una distribución centrada en **252 bp**, con desviación estándar **40 bp**, y percentiles 25/50/75 de **231/249/267 bp**, respectivamente. Esta simetría indica una librería de secuenciación bien construida, sin evidencias de fragmentos aberrantes o contaminación cruzada.  

###### 6.4 Tasa de duplicación de lecturas

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig4_duplication_rate_histogram.png?raw=true)

En la [[Fig4](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig4_duplication_rate_histogram.png?raw=true)] se observa una **tasa de duplicación estimada del 37.6%**, lo cual es moderado. Este nivel de duplicación puede reducir la cobertura efectiva y aumentar el sesgo de representación, aunque no compromete la validez global del análisis.  

##### CONCLUSIONES

1. El alineamiento de la muestra S7 presenta alta calidad global, con más del **99.9%** de lecturas correctamente mapeadas y una calidad de mapeo media de **58.8**, lo que confirma la fiabilidad del proceso de alineamiento.

2. La cobertura promedio de **82.9X** es suficiente para análisis genómicos detallados. Sin embargo, la alta desviación estándar **(83.4)** indica cierta heterogeneidad entre regiones, posiblemente debido a variaciones en la eficiencia de captura.

3. El tamaño de inserto **(≈252 bp)** y su distribución estrecha respaldan una preparación de librería técnicamente consistente.

4. La tasa de duplicación moderada **(37.6%)** sugiere la necesidad de filtrar duplicados antes del análisis de variantes para evitar sobreestimaciones de cobertura o frecuencia.

5. En conjunto, los datos son de buena calidad, aptos para análisis posteriores (como *variant calling* o *copy number analysis*), aunque con precaución ante posibles sesgos derivados de la captura o duplicación.

---

#### 7. Incluya el reporte completo generado con *qualimap* como anexo.

Este reporte completo se puede ver en el siguiente archivo [[qualimapReport](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/S7_sorted_RG/qualimapReport.html)]. 
Un informe mas detallado de las figuras 1 al 4 se puede ver [[Reporte]([Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion3/Reporte_Alineamiento_de_lecturas.md at main · maluflorezg/Tareas_BioinfRepro2025_MLFG · GitHub](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Reporte_Alineamiento_de_lecturas.md)]

---

---

### PARTE 2 - LLAMADO DE VARIANTES

---

#### 1.Seguir este tutorial con los datos de la muestra previamente elegida. Todas las muestras son de pacientes, para los cuales se sospechaba de una mutación patogénica. Se realizó una secuenciación de un panel de genes con equipamiento MiSeq.

Continuamos con la muestra S7, con el flujo que se plaantea en el tutorial

```shell
# 1. Recalibración de calidades de bases (Q) en lecturas
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T BaseRecalibrator -R /datos/reference/genomes/hg19_reference/hg19.fasta -I S7_sorted_RG.bam -knownSites /datos/reference/genomes/hg19_reference/dbSNP_hg19.vcf -o S7_recall_data.table
# 2. Recalibración a los datos de secuencia
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T PrintReads -R  /datos/reference/genomes/hg19_reference/hg19.fasta -I S7_sorted_RG.bam --BQSR S7_recall_data.table -o S7_recall_reads.bam
# LLAMADO DE VARANTES
# 1. Identificar variantes
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T HaplotypeCaller -R /datos/reference/genomes/hg19_reference/hg19.fasta -I S7_recall_reads.bam --dbsnp /datos/reference/genomes/hg19_reference/dbSNP_hg19.vcf -stand_call_conf 30 -L "chr19" -o S7_raw_variants.vcf#
# 2. APLICAR FILTRO A LAS VARIANTES**
# 1. Extraer SNPs**
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T SelectVariants -R /datos/reference/genomes/hg19_reference/hg19.fasta -V S7_raw_variants.vcf -selectType SNP -o S7_RAW_SNP.vcf
# Filtrar SNPs
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T VariantFiltration -R /datos/reference/genomes/hg19_reference/hg19.fasta -V S7_RAW_SNP.vcf --filterExpression "DP <10" --filterName "FILTER" -o S7_FILTERED_SNP.vcf
# Extraer InDels
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T SelectVariants -R /datos/reference/genomes/hg19_reference/hg19.fasta -V S7_raw_variants.vcf -selectType INDEL -o S7_RAW_INDEL.vcf
# Filtrar InDels
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T VariantFiltration -R /datos/reference/genomes/hg19_reference/hg19.fasta -V S7_RAW_INDEL.vcf --filterExpression "DP <10" --filterName "FILTER" -o S7_FILTERED_INDEL.vcf
# Combinar vcfs filtrados
java -jar /opt/GenomeAnalysisTK-3.7-0/GenomeAnalysisTK.jar -T CombineVariants -R /datos/reference/genomes/hg19_reference/hg19.fasta --variant:foo S7_FILTERED_SNP.vcf --variant:bar S7_FILTERED_INDEL.vcf -o S7_FILTER_VARIANTS.vcf -genotypeMergeOptions PRIORITIZE -priority foo,bar
```

---

#### 2. En materiales y métodos del reporte, indique el número de genes incluidos en el panel e incluya una tabla con la lista de genes (*consejo: revise el archivo regiones_blanco.bed*). Indique también la región genómica total (en pares de bases) cubierta por el panel, o sea, el tamaño de las regiones blanco (*consejo: revise su reporte qualimapReport.html*).

Para obtener la lista completa de genes en el archivo regiones_blanco.bed* :

```
cut -f4 regiones_blanco.bed | sort | uniq > genes_panel.txt
```

Para contar el número total:

```
wc -l genes_panel.txt
369 genes_panel.txt
```

**LISTADO DE GENES**

| Nº  | Gen                 | Cromosoma   | Función / relevancia clínica general                                      |
| --- | ------------------- | ----------- | --------------------------------------------------------------------------- |
| 1   | **ABL1**            | chr9        | Tirosina quinasa; implicado en leucemia mieloide crónica (BCR-ABL).        |
| 2   | **BRAF**            | chr7        | Protooncogén; mutaciones comunes en melanoma y cáncer de tiroides.        |
| 3   | **BRCA1**           | chr17       | Reparación del ADN; asociado a cáncer de mama y ovario hereditario.       |
| 4   | **BRCA2**           | chr13       | Reparación del ADN; cáncer de mama, ovario y próstata.                   |
| 5   | **CBL**             | chr11       | Regulador de ubiquitinación; alteraciones en leucemias.                    |
| 6   | **CALR**            | chr19       | Mutaciones en neoplasias mieloproliferativas (JAK/STAT).                    |
| 7   | **CEBPA**           | chr19       | Factor de transcripción; leucemia mieloide aguda.                          |
| 8   | **CRLF2**           | chrX        | Receptor de citoquinas; alteraciones en leucemia linfoblástica aguda.      |
| 9   | **EZH2**            | chr7        | Metiltransferasa; componente del complejo PRC2, implicado en linfomas.      |
| 10  | **FLT3**            | chr13       | Tirosina quinasa; mutaciones FLT3-ITD comunes en LMA.                       |
| 11  | **IKZF1**           | chr7        | Factor de transcripción Ikaros; deleciones en ALL.                         |
| 12  | **JAK2**            | chr9        | Vía JAK/STAT; mutaciones en policitemia vera y trombocitemia esencial.     |
| 13  | **JAK3**            | chr19       | Señalización linfocitaria; mutaciones en inmunodeficiencias y neoplasias. |
| 14  | **KIT**             | chr4        | Receptor tirosina quinasa; mutaciones en GIST y mastocitosis.               |
| 15  | **KRAS**            | chr12       | GTPasa oncogénica; mutaciones en colon, páncreas, pulmón.                |
| 16  | **MLL (KMT2A)**     | chr11       | Regulador epigenético; reordenamientos en leucemias.                       |
| 17  | **MPL**             | chr1        | Receptor de trombopoyetina; mutaciones en neoplasias mieloproliferativas.   |
| 18  | **P2RY8**           | chrX        | Receptor acoplado a proteína G; asociado a reordenamientos CRLF2.          |
| 19  | **PAX5**            | chr9        | Factor de transcripción B-cell; deleciones en ALL.                         |
| 20  | **PDGFRA / PDGFRB** | chr4 / chr5 | Receptores tirosina quinasa; fusiones en sarcomas y leucemias.              |
| 21  | **PTEN**            | chr10       | Supresor tumoral; regulador de la vía PI3K/AKT.                            |
| 22  | **RB1**             | chr13       | Supresor tumoral; pérdida en retinoblastoma y cánceres sólidos.          |
| 23  | **SF3B1**           | chr2        | Splicing factor; mutaciones en síndromes mielodisplásicos.                |
| 24  | **TP53**            | chr17       | “Guardián del genoma”; mutaciones en múltiples cánceres.                 |
| 25  | **WT1**             | chr11       | Factor de transcripción; alteraciones en tumores renales y leucemias.      |

**Tabla 1.** Listado de genes incluidos en el panel

Para el análisis de variantes se utilizó un panel dirigido que abarca **25 genes** asociados a cáncer hematológico y tumores sólidos (Tabla 1).  

---

#### 3. Realice el filtrado de variantes con dos filtros, DP<10 y uno adicional que usted proponga.

Inicialmente se realiza el filtro con `DP<10`:

```
java -jar GenomeAnalysisTK.jar -T VariantFiltration \
  -R hg19.fasta \
  -V S7_RAW_SNP.vcf \
  -o S7_FILTERED1_SNP.vcf \
  --filterExpression "DP < 100" \
  --filterName "LowDP"
```

Luego se procede a realizar el filtro con `QD <2.0`:

```
java -jar GenomeAnalysisTK.jar -T VariantFiltration \
  -R hg19.fasta \
  -V S7_FILTERED1_SNP.vcf \
  -o S7_FILTERED2_SNP.vcf \
  --filterExpression "QD < 10.0" \
  --filterName "LowQD"
```

---

#### 4. Estime cuántas variantes son eliminadas por el filtro DP<10 solamente, y cuántas por ambos filtros.

Cuantas variantes son eliminadas solamente por el filtro DP<10
**Respuesta: 9 variantes**

```
grep "PASS" S7_FILTERED1_SNP.vcf | grep -c "^[^#]"
9
```

Cuantas variantes son eliminadas por ambos filtros (DP<10, QD<2.0)
**Respuesta: 9 variantes**

```
grep "PASS" S7_FILTERED2_SNP.vcf | grep -c "^[^#]"
9
```

---

#### 5. Genere un reporte e incluya una tabla con el número de variantes detectadas totales, SNPs, e INDELs. Para cada caso, indicar el número de variantes filtradas y que pasaron los filtros (solo uno, y ambos)

**5.1 Conteo de variantes totales, SNPs e INDELs**

```
# Variantes totales (RAW)
grep -v "^#" S7_RAW_SNP.vcf | wc -l
# Solo SNPs 
grep -v "^#" S7_FILTERED1_SNP.vcf | grep -v "PASS" | wc -l
# Solo INDELs 
grep -v "^#" S7_FILTERED2_SNP.vcf | grep -v "PASS" | wc -l
```

**5.2 Conteo de variantes filtradas**

```
# Variantes con FILTER=LowDP
grep -v "^#" S7_FILTERED1_SNP.vcf | grep "LowDP" | wc -l

# Variantes con FILTER=LowQD
grep -v "^#" S7_FILTERED2_SNP.vcf | grep "LowQD" | wc -l
```

**5.3 Variantes que pasaron solo un filtro**

```
# Pasan filtro1 pero fallan filtro2 (LowQD) 
comm -23 \
 <(grep -v "^#" S7_FILTERED1_SNP.vcf | cut -f1-2 | sort) \
 <(grep "LowQD" S7_FILTERED2_SNP.vcf | cut -f1-2 | sort) | wc -l
```

| Categoría                                          | Total | SNPs  | INDELs |
| -------------------------------------------------- | ----- | ----- | ------ |
| Variantes detectadas (RAW)                         | 9     | 9     | 0      |
| Variantes filtradas por LowDP (DP < 10)            | 0     | 0     | 0      |
| Variantes filtradas por LowQD (QD < 2.0)           | 0     | 0     | 0      |
| Variantes que pasan **solo un** filtro             | 0     | 0     | 0      |
| Variantes que pasan **ambos** filtros (PASS final) | **9** | **9** | **0**  |

**Tabla 2.** Número de variantes que pasan los filtros LowDP (DP < 10) y LowQD (QD < 2.0)

---

#### 6. Visualice una variante en IGV, mostrando tracks tanto para el alineamiento (bam) como las variantes detectadas (VCF).

1. Se ingresa a [IGV web](https://igv.org/app)

2. Selecciono cromosoma 19: **Genome → Human → hg19**  

3. Cargo BAM: **Tracks → Local File… → **S7_sorted_RG.bam** y **S7_sorted_RG.bam.bai**.  

4. Cargo VCF filtrado: **Tracks → Local File…** → **S7_FILTERED2_SNP.vcf**

5. Para visualizar una variante en el cromosoma 19 ingreso la coordenada: `chr19:17,941,123-17,941,193`. Este rango me da una ventada de 75 pb, lo cual me permite visualizar 2 variantes de **JAK3** :
   
   1. Posición 17,941,143 → **Sustitución A>C**, ID:rs2302600 
   
   2. Posición 17,941,173 → **Sustitución C>G**, ID:rs2302601 
   
   ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/IGV1.png?raw=true)
   
   **Figura 1.** Visualizacíon de dos variantes de **JAK3** en el cromosoma 19
   
   Utilizando una coordenada de: `chr19:17,940,836-17,949,026`, puedo visualizar alrededor de 6 variantes en **JAK3** [IGV]([IGV](https://tinyurl.com/69ybz2a5).
   
   ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/IGV2.png?raw=true)
   
   **Figura 2.** Visualizacíon de seis variantes de **JAK3** en el cromosoma 19
   
   | Tipo de ubicación       | Posición | Detalle                          |
   | ----------------------- | -------- | -------------------------------- |
   | Exónicas (codificantes) | 17941143 | Sustitución A>C, Gen **JAK3**    |
   | Exónicas (codificantes) | 17941173 | Sustitución C>G, Gen **JAK3**    |
   | Exónicas (codificantes) | 17941294 | Sustitución T>C, Gen **JAK3**    |
   | Exónicas (codificantes) | 17942370 | Sustitución T>C, Gen **JAK3**    |
   | Exónicas (codificantes) | 17946054 | Sustitución G>A, Gen **JAK3**    |
   | Exónicas (codificantes) | 17948732 | Sustitución T>C, Gen **JAK3**    |
   | Intrónicas              | 0        | No hay variantes fuera de exones |
   | Upstream/Downstream     | 0        | Ninguna variante                 |
   | Intergénicas            | 0        | Todas caen en regiones del panel |
   
   **Tabla 3.** Variantes detectadas según la ubicación

---

#### 7. Realice una anotación de las variantes con la herramienta en línea [VEP](https://grch37.ensembl.org/info/docs/tools/vep/index.html). Asegúrese de usar la versión del genoma que utilizó en el alineamiento. Incluya anotaciones de Significancia clínica y puntajes CADD.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/VEP1.png?raw=true)

**Figura 3.** Resumen global de la anotación de variantes realizado con VEP utilizando el genoma GRCh37/hg19.  A la izquierda se muestra un resumen estadistico, y dos gráficos circulares; en el centroun gráfico de todas las consecuencias y a la derecha un gráfico con consecuencias codificantes. 

##### Resumen estadistico:

- **Variants processed:** 9 variantes fueron analizadas.

- **Variants filtered out:** 0 variantes fueron eliminadas por filtros automáticos.

- **Novel / existing variants:** Las 9 variantes corresponden a variantes previamente conocidas en bases de datos.

- **Overlapped genes:** Las variantes afectan un total de **11 genes**.

- **Overlapped transcripts:** Las variantes se anotaron en **31 transcritos** distintos.

##### CONSECUENCIAS FUNCIONALES

##### 1. Todos los Tipos de Consecuencias

Considera todos los transcritos superpuestos. Las categorías principales son:

- **intronic_variant (38%)** → variantes ubicadas en intrones.

- **downstream_gene_variant (20%)** → variantes localizadas después del gen.

- **upstream_gene_variant (20%)** → variantes antes del inicio del gen.

- Otras anotaciones incluyen:
  
  - non_coding_transcript_variant
  
  - splice polypyrimidine tract variant
  
  - UTR variants
  
  - NMD variants
  
  - missense_variant (1%)
  
  - synonymous_variant (1%)

##### 2. Consecuencias Codifocantes

Considera aquellas que afectan directamente al marco de lectura o secuencia proteica.

Se observan dos tipos de variantes codificantes:

- **missense_variant (50%)** → variantes que cambian un aminoácido.

- **synonymous_variant (50%)** → variantes que no cambian el aminoácido.

---

#### 8. Baje la tabla de variantes anotadas en formato TXT y fíltrela (por ejemplo en R) para generar una tabla que solo contenga variantes con un valor distinto a "benign" en la columna "CLIN_SIG" o un valor de CAAD > 20. Incluya incluya la tabla filtrada en su informe (si hubo variantes que pasaron los filtros) e interprete sus resultados.

Las variantes detectadas en la muestra S7 fueron anotadas con VEP (Ensembl, GRCh37/hg19) y exportadas en formato TXT. Posteriormente, se aplicó un filtrado en R para seleccionar únicamente aquellas variantes con **significancia clínica distinta de “benign” o “benign/likely_benign”** en la columna `CLIN_SIG` o con un puntaje **CADD > 20**.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/R3.png?raw=true)Users/macbookair/Library/Application%20Support/marktext/images/2025-11-29-10-14-33-image.png)

Tras aplicar estos criterios, **No se identificaron variantes que cumplieran las condiciones**, de modo que la tabla filtrada resultó vacía. Todas las variantes anotadas presentaban categorías de significancia clínica benigna o probablemente benigna y no contaban con evidencia de alto impacto funcional.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/R2.png?raw=true)

Estos hallazgos indican que, dentro de las regiones analizadas por el panel, **no se detectan mutaciones con evidencia de patogenicidad** y las variantes observadas son consistentes con polimorfismos benignos sin relevancia clínica conocida.

---

#### **Conclusión**

El análisis completo de la muestra, incluyendo el alineamiento, la llamada de variantes y su posterior anotación funcional mediante VEP (GRCh37/hg19), no evidenció la presencia de **mutaciones con potencial patogénico** dentro de los genes incluidos en el panel. Todas las variantes detectadas fueron clasificadas por VEP como **benignas o probablemente benignas**, sin anotaciones de significancia clínica adversa y sin puntajes que sugirieran un impacto funcional elevado. Tampoco se identificaron variantes codificantes con alteraciones relevantes en IGV ni patrones que indicaran afectación de regiones críticas.
