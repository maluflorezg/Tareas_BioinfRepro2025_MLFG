#### INFORME ALINEAMIENTO DE LECTURA

A continuación se presenta un análisis de calidad del alineamiento realizado con *Qualimap* sobre el archivo `S7_sorted_RG.bam`, resultante del mapeo con BWA-MEM contra el genoma de referencia *hg19*. Los resultados generales indican una excelente proporción de lecturas mapeadas (99.93%), cobertura promedio alta (82.9X) y una calidad media de mapeo de 58.8, lo que evidencia un alineamiento robusto y confiable. Sin embargo, se observa una tasa moderada de duplicación (37.6%), que podría tener implicaciones en la representatividad efectiva de la cobertura.

##### 1. COBERTURA A LO LARGO DEL GENOMA

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig1_coverage_across_reference.png?raw=true)

**Figura 1. Cobertura a lo largo de la referencia.**  
*Distribución de la profundidad de lectura en las diferentes regiones del genoma. Se observa la variación local de la cobertura (eje Y) a lo largo de las posiciones genómicas (eje X).*

La **Figura 1** muestra la cobertura a través de la referencia genómica, revelando una profundidad promedio de **82.9X** con desviación estándar de **83.4**. Aunque la cobertura es alta, la variabilidad observada sugiere la presencia de regiones con sobre-representación (picos) y sub-representación (valles). No se observan zonas extensas sin cobertura, lo cual confirma una adecuada uniformidad general del alineamiento.

##### 2. DISTRIBUCIÓN DE LA CALIDAD DE MAPEO

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig2_mapping_quality_histogram.png?raw=true)

**Figura 2. Histograma de calidades de mapeo (MAPQ).**  
*Distribución de las puntuaciones de calidad de alineamiento (MAPQ) de las lecturas mapeadas.*

El histograma de la **Figura 2** evidencia una concentración marcada de valores de MAPQ entre **50 y 60**, con media **58.8**, lo que indica una alta confianza en la asignación posicional de las lecturas. La baja frecuencia de valores inferiores a 30 sugiere escasa ambigüedad en el mapeo, reflejando la eficiencia de BWA-MEM al alinear fragmentos de longitud media (~250 bp) y sin contaminación aparente.

##### 3. DISTRIBUCIÓN DEL TAMAÑO DE INSERTO

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig3_insert_size_histogram.png?raw=true)

**Figura 3. Histograma del tamaño de inserto.**  
*Distribución de la distancia entre los pares de lecturas (insert size) en bases.*

La **Figura 3** muestra una distribución centrada en **252 bp**, con desviación estándar **40 bp**, y percentiles 25/50/75 de **231/249/267 bp**, respectivamente. Esta simetría indica una librería de secuenciación bien construida, sin evidencias de fragmentos aberrantes o contaminación cruzada.

##### 4. TASA DE DUPLICACIÓN DE LECTURAS

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion3/Figuras/Fig4_duplication_rate_histogram.png?raw=true)

**Figura 4. Histograma de tasa de duplicación.**  
*Frecuencia de lecturas únicas frente a lecturas duplicadas estimadas por posiciones de inicio de los fragmentos.*

En la **Figura 4** se observa una **tasa de duplicación estimada del 37.6%**, lo cual es moderado. Este nivel de duplicación puede reducir la cobertura efectiva y aumentar el sesgo de representación, aunque no compromete la validez global del análisis.

##### CONCLUSIONES

1. El alineamiento de la muestra S7 presenta alta calidad global, con más del **99.9%** de lecturas correctamente mapeadas y una calidad de mapeo media de **58.8**, lo que confirma la fiabilidad del proceso de alineamiento.

2. La cobertura promedio de **82.9X** es suficiente para análisis genómicos detallados. Sin embargo, la alta desviación estándar **(83.4)** indica cierta heterogeneidad entre regiones, posiblemente debido a variaciones en la eficiencia de captura.

3. El tamaño de inserto **(≈252 bp)** y su distribución estrecha respaldan una preparación de librería técnicamente consistente.

4. La tasa de duplicación moderada **(37.6%)** sugiere la necesidad de filtrar duplicados antes del análisis de variantes para evitar sobreestimaciones de cobertura o frecuencia.

5. En conjunto, los datos son de buena calidad, aptos para análisis posteriores (como *variant calling* o *copy number analysis*), aunque con precaución ante posibles sesgos derivados de la captura o duplicación.
