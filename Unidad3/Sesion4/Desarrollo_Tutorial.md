#### TUTORIAL– Análisis de Variantes con CLC Genomics Workbench

**Autora:** Martha Flórez  
**Fecha:** 15.11.2025  
**Curso:** Bioinformática Reproductiva 2025

---

#### TUTORIAL 1 - Identificación de variantes en una muestra tumoral

Este tutorial permitirá guiar a través del proceso de identificación y verificación de variantes.

Utilizaremos datos de secuenciación de exoma de extremos pareados de una muestra masiva de carcinoma de células acinares. La muestra fue secuenciada utilizando la plataforma Illumina 2000 y publicada por AC Nichols et al. en Case reports in
Oncological Medicine en 2013 (https://onlinelibrary.wiley.com/ doi/10.1155/2013/270362).

Los datos de ejemplo utilizados en este tutorial incluyen únicamente lecturas que se corresponden con una pequeña fracción del **cromosoma 5**. Las lecturas ya han sido recortadas para eliminar las secuencias adaptadoras de Illumina.

Para la importación de datos y referencias descargamos los archivos que se encuentras en div>
https://resources.qiagenbioinformatics. com/testdata/Example_data_tumor_25.zip.

</div>. Utilizamos el programa CLC Genomics Workbench

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig1.png)

##### 1. Identificación de Variantes

El primer paso del análisis consiste en el mapeo de las lecturas de secuenciación de la muestra tumoral al cromosoma 5, seguido de la detección de inserciones/deleciones (indels). Las indels detectadas sirven como guía para el siguiente paso: la realineación
local, que se realiza para mejorar el mapeo y permitir una mejor detección de variantes. Tras la detección de variantes, se filtran los posibles falsos positivos en función de la calidad media de las bases. 

Revisamos el informe de calidad de las regiones objetivo para identificar aquellas con baja cobertura y verificar la especificidad de las lecturas. 

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig2.png)

Revisar el informe de control de calidad para las regiones objetivo
Se debe comprobar el informe de calidad de las regiones objetivo para determinar si el enriquecimiento de Las regiones objetivo fueron exitosas.

---

##### 1. ¿Es suficiente la cobertura promedio en las regiones objetivo?

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig3.png)

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig6.png)

Resumen del reporte:

- Cobertura promedio: **22,5X**

- Cobertura mediana: **18X**

- Cobertura mínima: **0**

- Cobertura máxima: **106X**

- Pocentaje de regiones objetivo con cobertura ≥10X: **82,6%**

Para paneles dirigidos (amplicones) o regiones pequeñas, normalmente se espera:

- **Cobertura ≥ 20–30X** para análisis germinal.

- **Cobertura ≥ 50X** o incluso 100× en análisis somáticos o de cáncer.

La cobertura promedio de 22,5X es aceptable para germinal, pero:

- El  aproximadamente el **18% de las bases están por debajo de 10X**, lo que podría afectar la detección de variantes heterocigotas.

- Hay **72 regiones sin suficiente cobertura (<10X)**.

La cobertura promedio fue de **22,5X**, con una mediana de **18X**. Si bien esto se aproxima al umbral mínimo recomendado para experimentos WES, la distribución es insuficiente; un total de **72 regiones** contienen posiciones con cobertura inferior a 10X. Esto indica una cobertura heterogénea e incompleta en varios objetivos del panel.
La **cobertura promedio es suficiente para un análisis germinal básico**, pero **no es óptima**. Hay regiones con cobertura insuficiente (<10X) que podrían impactar la sensibilidad del análisis.

---

##### 2. ¿La especificidad de las lecturas dentro de las regiones objetivo está dentro del rango esperado?

Lo esperado sería:

- Para **exoma** → se espera **>50%** de lecturas en regiones objetivo.

- Para **paneles de amplicones** → se espera **>90%**.

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig8.png)

Se observa que el 36,5 % de las lecturas y el 29,1 % de las bases se alinean con las regiones objetivo.
Estos valores están por debajo del rango esperado para experimentos de enriquecimiento dirigido (≥50% para WES y >90% para paneles de amplicones). Lo que nos sugieren un enriquecimiento subóptimo, con un porcentaje considerable de lecturas mapeando fuera de las regiones objetivo.

Esto sugiere:

- Captura incompleta

- Biblioteca degradada

- Exceso de ruido fuera de las regiones target

---

##### 3. ¿Se cubren suficientemente todos los objetivos específicos?

Queremos comprobar cuántos objetivos tienen una cobertura superior a 10X en al menos el 80 % de la región total del objetivo. Esto se puede observar en la sección **1.2 Fractions of targets with coverage at least 10** y consulte el valor de la tabla «>80 % de la región objetivo tiene una cobertura de al menos 10».

![](/Users/macbookair/Library/Application%20Support/marktext/images/2025-11-21-08-51-29-image.png)

Resumen del informe:

- **Número total de regiones objetivo**: 124

- **Regiones sin cobertura suficiente (<10X)**: 72

- **Regiones con ≥30% de su longitud cubierta a ≥10X**: 107 (86,29%)

- **Regiones con 100% de la región cubierta ≥10X**: 52 (41,94%)

Podemos observar que solo **42%** de los blancos están totalmente cubiertos a ≥10X, pero el **86%** tienen al menos parte significativa cubierta (≥30%). También podemos ver que un **14%** de los blancos prácticamente no están cubiertos.

En conclusión **No se cubren completamente los objetivos específicos**.  Solo **42%** de las regiones están totalmente cubiertas. Hay **72 regiones** con baja o nula cobertura.

Para que un target esté “suficientemente cubierto” se suele exigir:

- **≥90% de la región objetivo con ≥10×** (o ≥20× según plataforma).

En este caso se observo que solo **75 regiones (60.48%)** cumplen ese criterio. El resto (**~40%**) están parcialmente cubiertas.

---

##### 1. Genome Browser View

El panel muestra **el cromosoma 5** con diferentes *tracks*:

###### **a) Barra superior – Mapa del cromosoma**

- Tono rojo más intenso = mayor densidad de regiones anotadas.

- Línea negra = posición actual donde están tus variantes/targets.

###### **b) Tracks de anotaciones génicas (azul, verde, amarillo)**

Estos provienen de Ensembl:

- **Genes (azul):** posiciones de genes anotados, intensidad refleja cantidad de exones en esa zona.

- **mRNA (verde):** densidad de transcritos.

- **CDS (amarillo):** exones codificantes, donde se ubican típicamente las variantes con efecto funcional.

###### **c) Track Target_region_coverage (lila)**

- Muestra las regiones objetivo (targets) del panel.

- La barra vertical azul indica la región específica seleccionada en la tabla inferior.

- Ese track corresponde a uno de tus genes target (CCNB1 en la segunda imagen).

![](/Users/macbookair/Library/Application%20Support/marktext/images/2025-11-21-12-12-13-image.png)

##### **2. Tabla Identified_variants (panel inferior)**

Lista de todas las variantes detectadas en los targets, con:

- **Tipo:** SNV, inserción, deleción.

- **Referencia / Alelo:** base original vs base variante.

- **Zigosidad:** heterocigota u homocigota.

- **Count:** lecturas que soportan la variante.

- **Coverage:** profundidad total (ref + alt).

- **Frequency:** porcentaje de lecturas con la variante.

- **Forward / Reverse reads:** soporte en ambas direcciones (indicador importante de calidad).

Utilizamos la función de filtro para identificar variantes que difieren de la secuencia de referencia humana.

Observe la columna Frecuencia. La frecuencia de la mayoría de las variantes es muy alta, pero para algunas es tan baja como el 25 %. Observando el número de lecturas que la respaldan (en la columna Recuento), se ve que solo hay 3 lecturas, lo que significa que esta variante no cuenta con un gran número de lecturas que la respalden.

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig13.png)

En general, si desea validar los resultados de su variante, se debe tener en cuenta lo siguiente:

- La calidad base promedio de la variante A (inferior a 20) podría sugerir que se trata de un error de secuenciación.

- Número de lecturas únicas que respaldan la variante. Comprobar los valores en las columnas: # posiciones de inicio únicas y # posiciones de finalización únicas. Estos valores deben ser mayores que uno. De no ser así, la variante podría deberse a un error de PCR durante el enriquecimiento.

- En la lista de secuencias, examinar las regiones que rodean la variante en la secuencia de referencia. ¿Se encuentra en una región de homopolímero (p. ej., en una secuencia de adeninas)? ¿Es una deleción o una inserción? De ser así, la variante podría ser un error de secuenciación.

- Número de lecturas que respaldan la variante. Este valor debe ser como mínimo 1, pero preferiblemente 5 o más.
  

---

#### TUTORIAL 2 - Encuentre variantes accionables con los paneles de ADN QIAseq



Este tutorial utiliza las capacidades de CLC Genomics Workbench y el complemento Biomedical Genomics Analysis para encontrar variantes accionables, incluso con frecuencias muy bajas, en datos de secuenciación dirigida generados con un kit de panel BRCA1 y BRCA2 QIAseq.

El tutorial abarca en pocos pasos todo lo siguiente:

- Importe las lecturas pareadas de Illumina en el entorno de trabajo.

- Encuentrar variantes de baja frecuencia con el flujo de trabajo de ADN dirigido a través de la herramienta Analizar muestras QIAseq guía.

---

#### 1. Importar las lecturas

1. Se descargan los datos de muestra del sitio web:

http://resources.qiagenbioinformatics.com/testdata/QIAseq_DNA_tutorial.zip

Descomprimir los archivos e importarlos

![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig2.5.png)



Una vez terminado el proceso los archivos R1 y R2 se fusionarán en un único archivo de lecturas emparejadas durante la importación.



#### 2. Ejecutar el flujo de trabajo de ADN dirigido

Ahora ejecutaremos el flujo de trabajo del panel BRCA1 y BRCA2 (DHS­102Z) con todos los ajustes configurados en sus valores predeterminados.



![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig2.6.png)



Después de hacer clic en Ejecutar, seleccione las lecturas de secuenciación haciendo doble clic en el nombre del archivo o haciendo clic una vez en el nombre del archivo y luego en la flecha que apunta hacia la derecha. Mantenga los valores predeterminados para los parámetros y guarde los resultados del flujo de trabajo y especifique una ubicación en el Área de navegación antes de hacer clic en Finalizar.

---

---

El tutorial original de QIAGEN está diseñado para usar **QIAseq Sample Analysis**

(Workflow completo, incluye todos los pasos y genera todos los outputs del tutorial)

pero nos fue proporcionada una versión DEMO que no incluye este workflow de QIAseq Sample Analysis. Por lo tanto **QIAseq Panel Analysis (Illumina)**

(es un workflow más limitado) que permite: Remoción de adaptadores, Deducción de UMIs, Mapeo, Llamado de variantes somáticas, Reportes básicos. Si genera: Trim reads report, UMI report,  Identify variants. 

**NO genera**:

- Genome browser view

- Combined report

- Structural variants report

- Long indels

- Per-region statistics

- Amino acid track

- Coverage report completo



Lo que significa que se vana obtener SOLO los resultados del sub-workflow de variantes. NO se obtendrá archivos completamente anotados del tutorial, generan un  Genome Browser View automáticamente



![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad3/Sesion4/Figuras/Fig2.7.png)
