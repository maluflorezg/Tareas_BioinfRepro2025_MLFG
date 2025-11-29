**Martha Flórez Giraldo**
**TAREA 3.1 - Control de calidad de lecturas NGS**
**Fecha: 10.11.2025**

___

---

#### **TAREA 3.1 - Control de calidad de lecturas NGS** **

**Archivo asignado S7**

Para realizar un trimming adecuado de lecturas se debe hacer un análisis previo de la calidad de la secuenciación mediante el programa FastQC. Usando las lecturas crudas de una secuenciación NGS ejecute FastQC: Los datos están en Datos: `181004_curso_calidad_datos_NGS/fastq_raw` 

Realizar las siguientes tareas tanto para las secuencias crudas y podadas. Además de generar los informes de calidades deben realizar una comparación de los resultados. Recuerden que la ubicación de las secuencias crudas es en el directorio: 181004_curso_calidad_datos_NGS/fastq_raw/ y las secuencias ya podadas se encuentran en 181004_curso_calidad_datos_NGS/fastq_filter

#### Usando comandos Unix:

#### 1. Contar el número de lecturas (reads) en un archivo fastq

Para S7_R1.fastq.gz y S7_R2.fastq.gz

```
echo "S7_R1.fastq.gz (raw): $(( $(zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz | wc -l) / 4 )) reads"
S7_R1.fastq.gz (raw): 27877 reads
echo "S7_R2.fastq.gz (raw): $(( $(zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R2.fastq.gz | wc -l) / 4 )) reads"
S7_R2.fastq.gz (raw): 27877 reads
```

Para S7_R1_filter.fastq.gz y S7_R2_filter.fastq.gz

```
echo "S7_R1_filter.fastq.gz (filter): $(( $(zcat ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R1_filter.fastq.gz | wc -l) / 4 )) reads"
S7_R1_filter.fastq.gz (filter): 24769 reads
echo "S7_R2_filter.fastq.gz (filter): $(( $(zcat ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R2_filter.fastq.gz | wc -l) / 4 )) reads"
S7_R2_filter.fastq.gz (filter): 24769 reads
```

---

#### 2. Previsualizar las primeras 40 líneas del mismo archivo fastq

Con el comando 

```
zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz | head -n 40
```

El resultado es el siguiente para S7_R1.fastq.gz:

```
@M03564:2:000000000-D29D3:1:1101:15619:1367 1:N:0:ACAGTGGT+TGTTCTCT
ACAGAGACCAGAACTTTGTAATTCAACATTCATCGTTGTGTAAATTAAACTTCTCCCATTCCTTTCAGAGGGAACCCCTTACCTGGAATCTGGAATCAGCCTCTTCTCTGATGACCCTGAATCTGATCCTTCTGAAGACAGAGCCCCAGAGTCAGCTCGTGTTGGCAACATACCATCTTCAACCTCTGCATTGAAAGTTCCCCAATTGAAAGTTGCAGAATCTGCCCAGGCGAATTTCGACGATCGTTGCA
+
CDDDBFFFCFFFGGGGGGGGGGHHHHHHHHHHHHHHHHGGHHHHHHHHHHHHHHHHHHIIHHHIHHHHHHGGGHGGGGGHHHHHHHHHHHHHHHGHHHHHHHHHHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGHHHHHHHHHGGHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHGHHHHHHHHHHHFHHHGFHHFHHHHHHHHHGHHHEHHGHGFGGGGGFEGGGGGGFGGG0
@M03564:2:000000000-D29D3:1:1101:15089:1369 1:N:0:ACAGTGGT+TGTTCTCT
CATAAAATTCACTTCCCAAAGCTGCCTACCACAAATACAAATTATGACCAAGATTTTTGGCAAAACTATAAGATAAGGAATCCAGCAATTATTATTAAATACTTAAAAAACCTGAGACCCTTACCCAATTCAATGTAGACAGACGTCTTTTGAGGTTGTATCCGCTGCTTTGTCCTCAGAGTTCTCACAGTTCCAAGGTTAGAGAGTTGGGCACTGAGACTGGTTTGCGAATTTCGACGATCGTTGCATTA
+
CDDDDFFFFFFFGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGHHHGGHHHHGHHHHGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGHHHHHHHGHHGGGHHGHHEHGHHHHHHHGHFGAGGGGGGGGGGGGGGGGGGFF
@M03564:2:000000000-D29D3:1:1101:16512:1404 1:N:0:ACAGTGGT+TGTTCTCT
CCGCGAGAGGCTGCGAGCGAGCGAGCGGGGCCTTACCGAGCAGCGGCAGCTGGCCGCCGTCGCGCGCCAACGCCGGCATGGCCTCCGGAGCCCGGGGTCCCCAGGCCGCGCCGGCCCAGCCCTGCGATGCCGCCTGGAGCGGCGCGCCTCGCGCTGCAGGTGGCTCTCTTAAGGATGCGCGTCACCGACCGCAAATTCCCTCGGACTGGTGCAAAGTGGAAGGGGGGAGGAACCCTCTCCCCAGAGGCAGG
+
CCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGHHHHGGGGGHHGGGGGGHHHGHGGGGGGGGGGGGGGGGGGGGGGGGHHHHHHHGGGGGGGGGGGGGGGGFFFFFCFFFFCCFFFFFFFFFFFBFFFFFFFFFFFFFFAFCFFFFFFFFFFFF=DFFFFFFF?FFFFFFFFFFF/BDFCDFFFFDFAFFFBAAFFFFFFFFFDFAFFFFFFFFF9BFFFFFFFFFFFCAFFFF?E/BFFFEFFFEFEFF
@M03564:2:000000000-D29D3:1:1101:17117:1411 1:N:0:ACAGTGGT+TGTTCTCT
AGCCCCGACTCCAAAAGTCTGGTCCACATTGCTCTCACCTCCATGCAGTTCTTGTGCTTGGCATCCATGACCTTCAGCAGCACCTCTGTCTTTCGGGCCTCCCCATCCACCACCTCATGGCGACAGCCCCGGTAAATCTTGGTGAAGGACCCATGGCCCAGGTTCTCATGCTGAATGGTGAGGGGACAGCAGAAGAGGCCAGTGAGGGGGTTCCTGCAGGATCCCAGCCCAAGCGAGACATAGCGAATTTC
+
CCCCCCCCCCCFGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGGHHGGGHHHHHHHHGHHHHHHHGGGGGHHGGGGDGGHHHHHHHHGHHHGHHHGHHHHHHHGHGHHHHHHHHHHHGHHHHGHHHHGGGGGGHHHGGEGFFGGGGFGGGGGGGFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFF;DFFF
@M03564:2:000000000-D29D3:1:1101:14083:1442 1:N:0:ACAGTGGT+TGTTCTCT
ATTTCTGGAAAGTCGCAGAAGGGCTGGAGGACCTGGGAAGGAGGGGGGGTACCGAAGTGGGGGCCCAGCTGGACCCCGCCAAACCACGCCCATGAACCCACCCCCAAGCCACACCATCCACTCCCTATCCCTTTGCCATTCAACCCTTCCAAGCCGCGCCCCCTCCTATCAACTCCAACCTCTCAACACCCCCCCTACCCATCCCCAACCATCTCCCACCCGCCCTGCCAATCCCCCCCTCCTTCTCTCTC
+
AAAA>FDDD1DFGFEEEEAGAGEFHCEGFECCGGFAAFGEA0AAEE//-ACGBGG@G.9FA9@@?>F--BFFA-FBB<@@@@FF-A--9-9B/FFE/9---;A?--9-AAF---AE/9-9B/9BE-/BBFB/BBFFF/BB9/BB-A-BFFFB/9--@--9=?;-;BBFFB//9/9B9//99BBFB/-/9----;@9---9///;EEEB-99/:/99/-9---9---AAF///BBFF-@@@-;-B////;//
@M03564:2:000000000-D29D3:1:1101:14409:1490 1:N:0:ACAGTGGT+TGTTCTCT
GTTTAAGGTGTGAAGTAGCTGTGCATTAAACACAAAATAAACAATAAAATTATAAGATATAGTCAAGTTCATAACGAATATGGGTGTTCTTATCATCGTTGTAGATTCTTGGGTAATGTGCTATGAGAGCGTCCTGGGAACCAATGTAGATGGAGTTGTAAATTTTCCAATATACATCTCTGACTTTCCGGGCTGGGTGAAACAGACCCTAAAATAATTGAACGGGCGAATTTCGACGATCGTTGCATTAA
+
CBCCCFFFFFFCGGGGGGGGGGHHHHHHHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHIIIIIIIIIHHHHHHHHGGGHGHHHHHGGGHHHHHHHHHHHHHGHHHHHHHHHHHGHHHHHHHHHHHHHHHHGGGGGHHGHHGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGGGGHGHHHHHHHHGHHHHHHHHHHHHHHHGGDGGGGGGHHGGGGGGGGGGGFFFFFF
@M03564:2:000000000-D29D3:1:1101:16094:1519 1:N:0:ACAGTGGT+TGTTCTCT
TTTCTCCATCTGGGCTCCATTTAGACCTGAAAGGGTTAGTTGAGACCATTCACAGGCCAAAGACGGTACAACTTCCTTGGAGATTTTGTCACTTCCACTCTCAAAGGGCTTCTGATTTGCTACATTTGAATCTAATGGATCAGTATCATTTGGTTCCACTTCAGATACAAATGAGTATTTTTCTTTCACTTGGTTTTTAGATTTTTCACATTCATCAGCGTTTGCTTCATGGAAAATTTTTTTCCTAGTCT
+
CCCCCFFFFFFFGGGGGGGGGGHHHHHHHHHHHHGHHHHHHHHHHHGHHHGHHHHHGGHHHHHHGGGHGHHHHHHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHHGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGHHHGHHGHHGHFHHHGHFHHHGHHHHHGHBGHHDDHHHHHHHHHHHHFHHHBGHHGGEHBFHHHHHFHFHGG1FDFGHDGGGDBBHE0CG00GHFGHHHHGGG0FB00BF
@M03564:2:000000000-D29D3:1:1101:17873:1536 1:N:0:ACAGTGGT+TGTTCTCT
TTAAATGGTTTTCTTTTCTCCTCCAACCTAATAGTGTATTCACAGAGACTTGGCAGCCAGAAATATCCTCCTTACTCATGGTCGGATCACAAAGATTTGTGATTTTGGTCTAGCCAGAGACATCAAGAATGATTCTAATTATGTGGTTAAAGGAAACGTGAGTACCCATTCTCTGCTTGACAGTCCTGCAAAGGATTTTTAGTTTCAACTTTCGATAAAAATTGTTTCCTGTGACTTTCATAATGTAAATC
+
CCCCCFFFFFFCGGGGGGGGGGHHHHHGHHHHHHGGFGHHHHHHHHHHHHHHHHHGGHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGHHHHHHHHHHHHHHHHHHHGHHHGHHHHHHHHHHHHHHHHHHHHHIHHHHHHHHHHHHHGHHHHHHHHHGGHHGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGHHHHHHHHHHHHGHHHGGHHGHHHHHHHHHHHHHHFHHHHHGHHHCHHHHHFGF
@M03564:2:000000000-D29D3:1:1101:16924:1538 1:N:0:ACAGTGGT+TGTTCTCT
TGTAAAGCTTTATAAAGTCCTGGCTGCTACATACCACTTCTTCTGCATCTGCCAGCTGACATCCTAAAAACGAAGTCAAATTAGGGAAGGATGGCCGTTTCCTTGAGTCAAAAGCCCAGCAGGATTGCATTATAATGTATCTGTAAAAGCAATAGAACAAGGAACAAGATGAAGAAGTCTGAATGAAGCAAAATGGATCATTTTCCATATAATGAAGCACCATTTATTCCTCTGGAGCTGCTTATTTACAG
+
CCCCCFFFFFFFGGGGGGGGGGHHHGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHGHHIHHHIHHHHHHHGGGGGGHHHHHHHHHHHHGGHHHGHHGGGHHHHHHHHHHHHHHHHHHHHHHHHGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGHHGHHHHHHHHHHHHHHHHHHFHFHHHHHHHHHHHHHGHHHHHHGHHHHHHHHHGHHHHHFHHFHHHHHHHHGHHG0
@M03564:2:000000000-D29D3:1:1101:18072:1552 1:N:0:ACCGTGGT+TGTTCTCT
GCCTTTTTAGTTAAGAGTTTTTATTTCCTGCCACAGAAAGTTCATCAAAAGAGAGTCAAAACACAGCTGAAATTATAAGTCCTCCATCACCAGACCGACCTCCTCATTCACAAACCTCTGGCTCCTGTTATTATCATGTCATCTCAAAGGTCCCCAGGATTCGAACACCCCGTTCTTCTCCAACCCAGCGCTCCCCTGGCTGTCGCCCGTTGCCTTCTTCCGGTAAAAGACTTTATTGCCCTACTTGCCCT
+
CCCCCFFFCFFFGGGGGGGGGGHHHHHHHHHHHHHHGHGHHHHFHHGHFHHGHHGHHHHHGHEHGHHHHHHHHHGHFHGGHHHHHHHHHHHFGHGHGGGGGHHHHHHHHFHBGHHGHHHH3FFHGHHHHHHHHHHHH4GH4GHHHHHHHHHHHHH2///@FGGHHHGHGG//?F0FGHHHHHHG.C...<-<CEGGHGGGF.;C..;:EBFGGGGFFF0;0.-;:CGGGGF0CB0;C00:BFFFFFF0;B0
```

---

#### 3.a Ubicar la lectura 3 e identificar la información disponible. Describir en detalle la información entregada.

```
zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz | sed -n '9,12p'
```

Nos da la lsiguente información:

```
@M03564:2:000000000-D29D3:1:1101:16512:1404 1:N:0:ACAGTGGT+TGTTCTCT
CCGCGAGAGGCTGCGAGCGAGCGAGCGGGGCCTTACCGAGCAGCGGCAGCTGGCCGCCGTCGCGCGCCAACGCCGGCATGGCCTCCGGAGCCCGGGGTCCCCAGGCCGCGCCGGCCCAGCCCTGCGATGCCGCCTGGAGCGGCGCGCCTCGCGCTGCAGGTGGCTCTCTTAAGGATGCGCGTCACCGACCGCAAATTCCCTCGGACTGGTGCAAAGTGGAAGGGGGGAGGAACCCTCTCCCCAGAGGCAGG
+
CCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGHHHHGGGGGHHGGGGGGHHHGHGGGGGGGGGGGGGGGGGGGGGGGGHHHHHHHGGGGGGGGGGGGGGGGFFFFFCFFFFCCFFFFFFFFFFFBFFFFFFFFFFFFFFAFCFFFFFFFFFFFF=DFFFFFFF?FFFFFFFFFFF/BDFCDFFFFDFAFFFBAAFFFFFFFFFDFAFFFFFFFFF9BFFFFFFFFFFFCAFFFF?E/BFFFEFFFEFEFF
```

#### 3.b. ¿Donde se entrega la calidad del read?, ¿Cuál es el ID (identificador) del read? Etc. Utilice fechas y etiquetas para identificar cada parte.

Cada lectura FASTQ ocupa 4 líneas (ID, secuencia, separador, calidades).  
Por tanto, la lectura 3 está entre las líneas 9 y 12 del archivo con la siguiente información:

| Línea | Contenido                                               | Qué representa                                                                                                                         |
| ----- | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| 1     | **Encabezado**:Identificador de la lectura     (`@...`) | Detalles del instrumento y del flujo de secuenciación. Identifica de forma única la lectura, el instrumento, la corrida y los barcodes |
| 2     | Secuencia de ADN                                        | Bases nucleotídicas leídas (A, T, C, G)                                                                                                |
| 3     | Separador        (`+`)                                  | Marca el inicio de la sección de calidades                                                                                             |
| 4     | Calidades de lectura (en formato ASCII)                 | Valor de calidad Phred codificados en ASCII para cada base                                                                             |

A continuación se detalla que contiene cada línea:

##### **1. Línea 1 — Identificador**

`@M03564:2:000000000-D29D3:1:1101:16512:1404 1:N:0:ACAGTGGT+TGTTCTCT` 

Empieza con “@”, lo que indica que es el encabezado de una lectura.

**Descomposición del ID:**

| Segmento                  | Significado                              | Ejemplo / Interpretación    |
| ------------------------- | ---------------------------------------- | --------------------------- |
| `M03564`                  | ID del instrumento de secuenciación      | Ej. Illumina MiSeq/NextSeq  |
| `2`                       | Número de celda de flujo (flowcell lane) | Lane 2                      |
| `000000000-D29D3`         | ID único de la corrida (flowcell ID)     | D29D3                       |
| `1:1101:16512:1404`       | Coordenadas del cluster en el flowcell   | Tile: 1101, X:16512, Y:1404 |
| `1:N:0:ACAGTGGT+TGTTCTCT` | Información de lectura y barcode         | Ver abajo                   |

Desglose final del campo posterior:

- `1:` → lectura R1 (la primera lectura del par)

- `N:` → no pasó filtro de chimeras (N=No, Y=Yes)

- `0:` → número de control (normalmente 0)

- `ACAGTGGT+TGTTCTCT` → secuencias de índices (barcodes) del adaptador o multiplexación

##### 2. Línea 2 — Secuencia de ADN

`CCGCGAGAGGCTGCGAGCGAGCGAGCGGGGCCTTACCGAGCAGCGGCAGCTGGCCGCCGTCGCGCGCCAACGCCGGCATGGCCTCCGGAGCCCGGGGTCCCCAGGCCGCGCCGGCCCAGCCCTGCGATGCCGCCTGGAGCGGCGCGCCTCGCGCTGCAGGTGGCTCTCTTAAGGATGCGCGTCACCGACCGCAAATTCCCTCGGACTGGTGCAAAGTGGAAGGGGGGAGGAACCCTCTCCCCAGAGGCAGG` 

Contiene la secuencia de nucleótidos (bases) leídas por el secuenciador.  
Cada letra representa una base:

- `A` = adenina

- `T` = timina

- `C` = citosina

- `G` = guanina

##### 3. Línea 3 — Separador ➕

`+`  = Es un separador obligatorio, indica que a continuación viene la línea de calidades.  
Puede repetir el mismo identificador que la línea 1, aunque normalmente solo muestra el signo “+”.

##### 4. Línea 4 — Calidades de lectura

`CCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGHHHHGGGGGHHGGGGGGHHHGHGGGGGGGGGGGGGGGGGGGGGGGGHHHHHHHGGGGGGGGGGGGGGGGFFFFFCFFFFCCFFFFFFFFFFFBFFFFFFFFFFFFFFAFCFFFFFFFFFFFF=DFFFFFFF?FFFFFFFFFFF/BDFCDFFFFDFAFFFBAAFFFFFFFFFDFAFFFFFFFFF9BFFFFFFFFFFFCAFFFF?E/BFFFEFFFEFEFF` 

Cada símbolo representa la calidad de una base en formato Phred codificado en ASCII.

**Cómo leerlo:**

- `C` → calidad ≈ 34

- `G` → calidad ≈ 38

- `H` → calidad ≈ 39

- `F` → calidad ≈ 37

- `A` → calidad ≈ 32

- ... y así sucesivamente.

El valor se calcula como: **Phred = (código ASCII) − 33**

**Interpretación:**  
Un Phred 30 implica un 99.9% de probabilidad de que la base sea correcta.  
En esta lectura, la mayoría de las calidades son entre `F`, `G`, `H` → bases de alta confianza.

#### 3.c.  Traducir el código de calidad para las primeras 10 bases del tercer read a valores numéricos (Q) usando la codificación entregada en clase.

**1. Muestra S7_R1**

Para el archivo con los datos crudos (S7_R1) se utiliza en siguiente comando:

```
zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz | sed -n '12p' | cut -c1-10 | perl -ne 'chomp; @c=split //; print join(" ", map{ord($_)-33} @c), "\n"'
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LC_CTYPE = "UTF-8",
    LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
34 34 34 34 34 34 34 34 34 34
```

Para el archivo con los datos filtrados (S7_R2) se utiliza en siguiente comando:

```
$ zcat ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R1_filter.fastq.gz | sed -n '12p' | cut -c1-10 | perl -ne 'chomp; @c=split //; print join(" ", map{ord($_)-33} @c), "\n"'
  perl: warning: Setting locale failed.
  perl: warning: Please check that your locale settings:
      LANGUAGE = (unset),
      LC_ALL = (unset),
      LC_CTYPE = "UTF-8",
      LANG = "en_US.UTF-8"
      are supported and installed on your system.
  perl: warning: Falling back to the standard locale ("C").
  33 32 33 33 33 37 37 37 37 37
```

El análisis de calidad de las lecturas crudas (`S7_R1.fastq.gz`) y filtradas (`S7_R1_filter.fastq.gz`) se realizó con una evaluación puntual de los valores de calidad Phred (Q) para las primeras 10 bases del tercer read.

| Tipo de datos                        | Valores Q (primeras 10 bases del 3er read) | Q promedio | Rango Q | Interpretación de calidad                                                                                | Conclusión                                                                               |
| ------------------------------------ | ------------------------------------------ | ---------- | ------- | -------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Crudo (S7_R1.fastq.gz)**           | 34 34 34 34 34 34 34 34 34 34              | **34.0**   | 34–34   | Alta calidad constante en todas las bases; probabilidad de error ≈0.04%                                  | Lecturas muy confiables, sin variación entre posiciones.                                 |
| **Filtrado (S7_R1_filter.fastq.gz)** | 33 32 33 33 33 37 37 37 37 37              | **34.9**   | 32–37   | Leve menor calidad en las primeras bases (1–5) y mejora clara a partir de la base 6 (Q≈37, error ≈0.02%) | El filtrado mantiene y optimiza la calidad útil, eliminando regiones de menor confianza. |

**Interpretación:**

- Las lecturas **crudas** presentan una calidad alta y estable (Q promedio ≈34), reflejando un buen desempeño del secuenciador.

- Tras el **filtrado**, se observan mejoras en la calidad promedio (Q ≈35–37) y una reducción de posibles artefactos de baja calidad.

- La **probabilidad de error** por base es <0.05%, equivalente a una exactitud superior al **99.95%**.
  
  **Conclusión:**
  
  Los resultados del control de calidad (FastQC) y del cálculo directo de valores Phred indican que la muestra **S7_R1** posee lecturas de alta fidelidad y sin sesgos significativos. Los datos son aptos para análisis posteriores como alineamiento, ensamblaje o estimaciones de variantes, con una excelente relación señal/ruido y confiabilidad en la base-calling.

**2. Muestra S7_R2**

Para el archivo con los datos crudos (S7_R2) se utiliza en siguiente comando:

```
  zcat ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R2.fastq.gz | sed -n '12p' | cut -c1-10 | perl -ne 'chomp; @c=split //; print join(" ", map{ord($_)-33} @c), "\n"'
  perl: warning: Setting locale failed.
  perl: warning: Please check that your locale settings:
      LANGUAGE = (unset),
      LC_ALL = (unset),
      LC_CTYPE = "UTF-8",
      LANG = "en_US.UTF-8"
      are supported and installed on your system.
  perl: warning: Falling back to the standard locale ("C").
  33 33 33 33 33 37 37 37 37 33
```

   Para el archivo con los datos filtrados (S7_R2) se utiliza en siguiente comando:

```
$ zcat ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R2_filter.fastq.gz | sed -n '12p' | cut -c1-10 | perl -ne 'chomp; @c=split //; print join(" ", map{ord($_)-33} @c), "\n"'
  perl: warning: Setting locale failed.
  perl: warning: Please check that your locale settings:
      LANGUAGE = (unset),
      LC_ALL = (unset),
      LC_CTYPE = "UTF-8",
      LANG = "en_US.UTF-8"
      are supported and installed on your system.
  perl: warning: Falling back to the standard locale ("C").
  33 33 33 33 33 33 33 33 33 33
```

| Tipo de datos                        | Valores Q (primeras 10 bases del 3er read) | Q promedio | Rango Q | Interpretación de calidad                                                      | Conclusión                                                                                 |
| ------------------------------------ | ------------------------------------------ | ---------- | ------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| **Crudo (S7_R2.fastq.gz)**           | 33 33 33 33 33 37 37 37 37 33              | **34.2**   | 33 – 37 | Buen nivel general; ligera variación con picos altos (Q 37) en posiciones 6–9. | Lecturas confiables, aunque con pequeñas fluctuaciones en las primeras y últimas bases.    |
| **Filtrado (S7_R2_filter.fastq.gz)** | 33 33 33 33 33 33 33 33 33 33              | **33.0**   | 33 – 33 | Calidad uniforme (Q 33 ≈ 99.95 % de precisión) sin oscilaciones.               | Filtrado homogéneo; mantiene alta fidelidad general, eliminando variabilidad entre ciclos. |

   **Interpretación:**

- Las lecturas **crudas** presentan una calidad promedio alta (Q ≈ 34), con leves fluctuaciones entre las primeras y últimas bases.

- El **filtrado** homogeneiza la calidad (Q ≈ 33 constante), eliminando posibles extremos o regiones de baja confianza.

- En ambos casos, las calidades superan el umbral estándar (**Q30**, error <0.1%), lo que indica datos confiables para análisis downstream.
  
  **Conclusión**

- La muestra **S7_R2** presenta lecturas de alta calidad, aptas para alineamiento y análisis de variantes.

- El proceso de filtrado reduce la variabilidad, manteniendo valores Phred óptimos.

- No se detectan sesgos ni contaminación relevante según FastQC.

- Los resultados confirman que la muestra **S7_R2** mantiene una excelente calidad global antes y después del filtrado, con fidelidad de secuenciación superior al 99.9 %, por lo que puede emplearse sin restricciones en etapas posteriores del análisis bioinformático.  

---

#### 4. Genere un informe de calidad con FastQC para una muestra (cada estudiante una muestra distinta), para R1 y R2.

Se generaron informes de calidad para las muestras S7_R1 y S7_R2. Con los siguientes comandos:

```
fastqc ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R1.fastq.gz -o .
fastqc ~/181004_curso_calidad_datos_NGS/fastq_raw/S7_R2.fastq.gz -o .
fastqc ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R1_filter.fastq.gz -o .
fastqc ~/181004_curso_calidad_datos_NGS/fastq_filter/S7_R2_filter.fastq.gz -o .
```

Se generaron los siguientes archivos:

```
S7_R1_fastqc       S7_R1_fastqc.zip          S7_R1_filter_fastqc.zip  S7_R2_fastqc.zip          S7_R2_filter_fastqc.zip
S7_R1_fastqc.html  S7_R1_filter_fastqc.html  S7_R2_fastqc.html        S7_R2_filter_fastqc.html
```

---

#### 5. Baje los archivos HTML a su computados mediante sftp (puede usar cualquier cliente o la línea de comandos.

```
scp bioinfo1@genoma.med.uchile.cl:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion1/mflorez/S7_R*_fastqc* .
```

---

#### 6. Analice el informe de calidad creado con fastqc para las lecturas

---

##### 1. S7__R1

1. **Estadísticas básicas**

<img title="" src="https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/Informe_Calidad_S7_R1.png?raw=true" alt="" width="306"><img title="" src="https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/Informe_Calidad_S7_R1_filter.png?raw=true" alt="" width="297">

- El número total de lecturas es consistente con el tamaño esperado de un read par.

- La longitud de las lecturas es uniforme (probablemente 150 bp).
2. **Calidad por posición de base (Per base sequence quality)**
- **Crudo:** valores promedio de **Q ≈ 34–36**, con leve caída en los primeros 10–15 nucleótidos.

- **Filtrado:** mantiene Q>33 en toda la extensión; el gráfico muestra una línea estable sin caídas.  
  
  Excelente calidad general, y el filtrado eliminó las lecturas con extremos degradados.
3. **Niveles de duplicación**
- **Crudo:** proporción moderada de lecturas duplicadas (pico visible en el histograma).

- **Filtrado:** reducción significativa → las lecturas únicas predominan.  
  Esto mejora la independencia de los datos y evita sesgos en el mapeo.
4. **Contaminación por adaptadores**
- **Crudo:** Se detectan adaptadores 

- **Filtrado:** No se detecta contaminación, lo que indica un filtrado correcto.

La muestra **S7_R1** tiene una alta calidad de secuenciación, con pequeñas desviaciones corregidas tras el filtrado. El proceso de limpieza mejoró la uniformidad, eliminó adaptadores y redujo la duplicación, dejando lecturas ideales para pasos posteriores como alineamiento, ensamblaje o análisis de expresión

---

##### 2. **S7__R2.**

1. **Estadísticas básicas**

<img title="" src="https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/Informe_Calidad_S7_R2.png?raw=true" alt="" width="326">

<img title="" src="https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/Informe_Calidad_S7_R2_filter.png?raw=true" alt="" width="325">

- El número total de lecturas es consistente con el tamaño esperado de un read par.

- La longitud de las lecturas es uniforme (probablemente 150 bp).

- La codificación de calidad es estándar (Phred+33).  
2. **Calidad por posición de base (Per base sequence quality)**
- **Crudo:** Las primeras bases muestran buena calidad (> Q30), pero la calidad decae hacia el extremo 3′, llegando a valores promedio entre Q20–25.

- **Filtrado:** Se eliminan lecturas o extremos de baja calidad; la distribución de calidad es estable y > Q30 en casi toda la longitud.

        El filtrado mejora notablemente la consistencia y eleva el puntaje medio de         calidad, reduciendo la variabilidad.

3. **Contenido por posición de bases (Per base sequence content)**
- **Crudo:** Se observa un sesgo en las primeras 10 bases, con diferencias claras entre A/T y G/C, típico de librerías con adaptadores o artefactos de amplificación.

- **Filtrado:** El sesgo inicial disminuye, pero aún se mantiene una leve diferencia en las bases iniciales (< 5%), lo cual es común en R2 por el efecto del ciclo inverso en Illumina.

        Persisten ligeros sesgos, pero ya no afectan la representatividad de las lecturas.

4. **Distribución de calidad global (Per sequence quality scores)**
- **Crudo:** Pasa, con un pico alrededor de Q30.

- **Filtrado:** Pasa, con la mayoría de lecturas por encima de Q32–35.

        La calidad promedio de las lecturas aumenta tras el filtrado.

5. **Contenido GC**

        Estable (~45–50 %), consistente con genomas de organismos eucariotas o         humanos, sin picos anómalos.

        La muestra **S7_R2** tiene una alta calidad de secuenciación. El proceso de limpieza         mejoró la uniformidad, eliminó lecturas de baja calidad y adaptadores. Redujo el         sesgo en las bases iniciales. Los datos son adecuados para su uso en         alineamiento, ensamblaje o análisis de expresión.

---

#### 7. Compare los valores calculados en el punto 1 con lo entregado en el informe de calidad obtenido con FastQC

| Muestra      | Unix        | Fastqc      |
| ------------ |:-----------:|:-----------:|
| S7_R1        | 27877 reads | 27877 reads |
| S7_R2        | 27877 reads | 27877 reads |
| S7_R1_filter | 24769 reads | 24769 reads |
| S7_R2_filter | 24769 reads | 24769 reads |

**Unix** y **FastQC** entregan el mismo conteo de lecturas en todas las muestras, lo que podemos concluir: 

- Se valida la consistencia del pipeline y confirma que no hubo pérdidas accidentales en la manipulación de archivos.

- El método Unix cuenta las líneas (divididas entre 4, ya que cada lectura ocupa 4 líneas en formato FASTQ).

- El método FastQC calcula el número de lecturas internamente al procesar el archivo, confirmando el mismo valor.

- La coincidencia exacta demuestra que los archivos no están truncados y que el proceso de compresión/descompresión es correcto.

---

#### 8. Seleccione las 4 figuras más importantes a su criterio para analizar la calidad de la corrida, cópielas a un archivo Markdown en su repositorio y agregue su interpretación de cada figura. Recuerde hacer la comparación de R1 y R2 para las secuencias crudas y las secuencias podadas.

---

##### 1. S7_R1

1. **Per Base Sequence Quality (Calidad por posición de base)**
- **S7_R1 crudo:**  

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_base_Q.png?raw=true)

Muestra una excelente calidad general, con valores **Q>33** a lo largo de toda la lectura, aunque las **últimas bases** presentan una ligera caída (efecto común en Illumina).

- **S7_R1 filtrado:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_filter_base_Q.png?raw=true)La curva es más uniforme; todas las posiciones se mantienen sobre **Q=35**, sin caída al final.

**Conclusión:**  El filtrado eliminó lecturas de baja calidad y bases degradadas, resultando en una calidad más homogénea y estable.



2. **Per Sequence Quality Scores (Distribución de calidad por lectura)**

Muestra la distribución de los promedios de calidad por lectura completa.

- **S7_R1 crudo:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_Ph_score.png?raw=true)
  
  La mayoría de las lecturas tienen un promedio de **Q entre 32 y 36**, con una ligera cola hacia valores menores.

- **S7_R1 filtrado:**  
  
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_filter_Ph_score.png?raw=true)El histograma se concentra en **Q≥35**, eliminando la cola baja.
  
   **Conclusión:**  El filtrado reduce lecturas defectuosas y mejora la consistencia global, indicando que el trimming fue efectivo.
  
  
3. **Per Base Sequence Content (Contenido por base)**
   
   Indica la proporción de cada nucleótido (A, T, G, C) en cada posición a lo largo de la lectura.
- **S7_R1 crudo:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_base_seq.png?raw=true)

- **S7_R1 filtrado:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_filter_base_seq.png?raw=true) **Conclusión:**  El filtrado corrige sesgos en los extremos 5’ y mejora la representación natural de bases, eliminando contaminaciones o fragmentos técnicos.
  
  
4. **Adapter Content (Contenido de adaptadores)**
   
   Mide la presencia de secuencias de adaptadores de librería a lo largo de las lecturas.
- **S7_R1 crudo:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_adapt.png?raw=true)

- **S7_R1 filtrado:**  
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R1/S7_R1_filter_adapt.png?raw=true)
  
  **Conclusión:**  El filtrado eliminó correctamente las secuencias de adaptadores, mejorando la calidad para análisis posteriores (alineamiento, ensamblaje, cuantificación).
  
  ---
  
  ##### 2. S7_R2
1. **Calidad por posición de base  (Per Base Sequence Quality)**
- **S7_R2 Crudo:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_base_Q.png?raw=true)
  
  Las primeras bases muestran buena calidad (> Q30), pero la calidad decae hacia el extremo 3′, llegando a valores promedio entre Q20–25.
  
  

- **S7_R2 Filtrado:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_filter_base_Q.png?raw=true)
  
  Se eliminan lecturas o extremos de baja calidad; la distribución de calidad es estable y > Q30 en casi toda la longitud.

**Conclusión:** El filtrado mejora notablemente la consistencia y eleva el puntaje medio de calidad, reduciendo la variabilidad.



2. **Contenido por posición de bases (Per base sequence content)**
- **S7_R2 Crudo:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_base_seq.png?raw=true)
  
  Se observa un sesgo en las primeras 10 bases, con diferencias claras entre A/T y G/C, típico de librerías con adaptadores o artefactos de amplificación.

- **S7_R2 Filtrado:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_filter_base_seq.png?raw=true)
  
  El sesgo inicial disminuye, pero aún se mantiene una leve diferencia en las bases iniciales (< 5%), lo cual es común en R2 por el efecto del ciclo inverso en Illumina.

**Conclusión:** Persisten ligeros sesgos, pero ya no afectan la representatividad general de las lecturas.



3. **Distribución de calidad global (Per sequence quality scores)**
- **S7_R2 Crudo:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_Ph_score.png?raw=true)
  
  Pasa, con un pico alrededor de Q30.
  
  

- **S7_R2 Filtrado:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_filter_Ph_score.png?raw=true)
  
  Pasa, con la mayoría de lecturas por encima de Q32–35.

**Conclusión:** La calidad promedio de las lecturas aumenta tras el filtrado.



4. **Contenido de adaptadores (Adapter Content)**
- **S7_R2 Crudo:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_adapt.png?raw=true)
  
  Las lecturas crudas de R2 muestran una contaminación moderada-alta de adaptadores hacia el extremo final, indicando la necesidad de trimming o filtrado previo a cualquier alineamiento.
  
  

- **S7_R2 Filtrado:** 
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion1/S7_R2/S7_R2_filter_adapt.png?raw=true)
  
  El filtrado eliminó eficazmente las secuencias de adaptadores, resultando en lecturas limpias y listas para alineamiento o ensamblaje, sin necesidad de corrección adicional.
