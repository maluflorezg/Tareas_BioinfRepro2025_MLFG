### Tarea 3.4 – Análisis de Variantes con CLC Genomics Workbench

**Autora:** Martha Flórez  
**Fecha:** 15.11.2025  
**Curso:** Bioinformática Reproductiva 2025  

---

#### 1. Introducción

En este análisis se ejecutó un flujo de trabajo completo para la identificación, evaluación y anotación de variantes a partir de datos de **secuenciación de exoma (WES)** utilizando **CLC Genomics Workbench 25**.  

El objetivo principal fue:

- Evaluar la calidad del enriquecimiento de regiones objetivo  
- Detectar variantes somáticas  
- Interpretar clínicamente variantes relevantes  
- Elaborar un informe siguiendo guías **AMP/ASCO/CAP**  

Los datos corresponden a un caso real de carcinoma de células acinares publicado por Nichols et al. (2013).  
El dataset contempla una fracción del **cromosoma 5**.

---

#### 2. Control de calidad del enriquecimiento

##### 2.1 Cobertura promedio de las regiones objetivo

La distribución de la cobertura mostró:

- **Cobertura promedio:** 22.5×  
- **Mediana:** 18×  
- **Cobertura mínima:** 0×  
- **Regiones con ≥10×:** 82.6%

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion4/Figuras/Fig_1.png?raw=true)

**Figura 1. Distribución de cobertura promedio en regiones objetivo** *La figura evidencia variabilidad marcada en la profundidad de lectura entre regiones, incluyendo segmentos con <10×.*

**Interpretación:**  
Aunque la cobertura promedio es aceptable para análisis germinal, es insuficiente para estudios somáticos, donde se recomiendan ≥50×. Esto genera riesgo de no detectar variantes heterocigotas o de baja frecuencia.

---

#### 2.2 Especificidad del mapeo en targets

Resultados:

- **36.5%** de lecturas dentro de regiones target  
- **29.1%** de bases en regiones target  

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion4/Figuras/Fig_2.png?raw=true)

 **Figura 2. Porcentaje de lecturas y bases mapeadas al panel**

**Interpretación:**  
En WES esperábamos ≥50% de lecturas en targets.  
En paneles dirigidos ≥90%.  
El valor obtenido indica **enriquecimiento pobre**, lo cual:

- Aumenta ruido fuera del target  
- Reduce cobertura efectiva  
- Disminuye sensibilidad de variantes

---

#### 2.3 Cobertura de objetivos específicos

Resultados:

- **124 regiones objetivo**  
- **72 regiones** con cobertura <10×  
- **52 regiones (42%)** con cobertura completa ≥10×  

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion4/Figuras/Fig_3.png?raw=true)

 **Figura 3. Targets cubiertos a ≥10×**

**Interpretación:**  
Solo 42% de regiones presentan cobertura ideal.  
Para un análisis clínico real se exige ≥90% de regiones con cobertura sólida.  
Aquí observamos cobertura fragmentada e insuficiente.

---

#### 3. Identificación de variantes

Tras mapeo, realineamiento local y llamada de variantes, se visualizó el genoma a nivel de target.

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion4/Figuras/Fig_4.png?raw=true)

**Figura 4. Vista del Genome Browser mostrando genes, CDS, mRNA y regiones target**

La tabla de variantes muestra:

- Variantes con frecuencias desde 25% a >90%
- Algunas con pocas lecturas únicas (riesgo de error PCR)
- Variantes con baja calidad base

![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion4/Figuras/Fig_5.png?raw=true)

**Figura 5. Lista de variantes detectadas**

---

#### **4. Interpretación clínica (AMP/ASCO/CAP)

Se seleccionaron variantes para análisis clínico mediante:

- **ClinVar**
- **VarSome**
- **CIViC**
- **OncoKB**

### **Hallazgos principales**

- Ninguna variante pertenece a genes accionables de alto impacto (BRCA1/2, TP53, EGFR, KRAS).  
- No se identificaron mutaciones catalogadas como *tier I* (alto nivel de evidencia) ni *tier II* (significancia potencial).  
- La mayoría de variantes muestran soporte limitado o baja profundidad → posible **artefacto técnico**.  
- Varias variantes se ubican en regiones con cobertura insuficiente, limitando interpretación.

---

#### 5. Conclusiones del análisis

1. **La cobertura global del experimento fue insuficiente**, especialmente en regiones críticas del panel.  
2. **La especificidad del mapeo es baja (36.5%)**, lo que afecta la eficiencia de captura.  
3. **Sólo 42% de los targets presenta cobertura adecuada (≥10×)**.  
4. Las variantes identificadas presentan **baja calidad**, y ninguna posee relevancia clínica según AMP/ASCO/CAP.  
5. Para análisis clínicos se recomienda:  
   - Optimizar captura de exoma  
   - Reevaluar preparación de librería  
   - Aumentar profundidad mínima a ≥80×  
6. El workflow permite reproducir una ruta estándar de análisis de variantes en CLC, confirmando su utilidad en entornos educativos y de entrenamiento.
