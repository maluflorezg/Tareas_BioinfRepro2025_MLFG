##### Martha Flórez

##### Tarea 3.2 - cBioPortal para analizar datos genómicos de cáncer

##### Fecha: 12.11.2025

---

##### 🧬 Tarea: Exploración e interpretación de datos genómicos en cBioPortal

###### 🎯 Objetivo

Explorar un estudio real disponible en [cBioPortal](https://www.cbioportal.org/) para:

1. Analizar alteraciones genéticas en un tipo de cáncer específico,
2. Filtrar pacientes con una mutación relevante, y
3. Interpretar la información clínica y genómica obtenida.

---

##### 🧩 Parte 1: Selección del estudio (15 min)

1. Ingresa a [https://www.cbioportal.org](https://www.cbioportal.org/).
   
   Se selecciona un estudio en Cancer de Pulmón específicamente en células no pequeñas (Non-Small Cell Lung Cancer, NSCLC),
- **Nombre del estudio:** Metastatic Non-Small Cell Lung Cancer (MSK, Nature Medicine 2022)

- **Número total de pacientes:** 2,621 pacientes

- **Institución responsable:** Memorial Sloan Kettering Cancer Center, New York, NY, USA.

        Justin Jee et al. Overall survival with circulating tumor DNA-guided         therapy in advanced non-small-cell lung cancer. Nat Med. 28, 2353–2363         (2022). doi: [10.1038/s41591-022-02047-z](https://doi.org/10.1038/s41591-022-02047-z)

El estudio seleccionado fue Metastatic Non-Small Cell Lung Cancer, 
Analiza 2 621 pacientes con cáncer pulmonar metastásico de células no pequeñas, evaluando alteraciones genómicas mediante secuenciación de ADN tumoral y plasma (ctDNA) para correlacionarlas con respuesta terapéutica y sobrevida global.  
El objetivo general es comprender cómo las mutaciones somáticas influyen en la progresión y manejo clínico del NSCLC avanzado.

---

##### 🧬 Parte 2: Análisis genómico (25 min)

1. Ve a la pestaña **Summary** del estudio.
   
   ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig3.png?raw=true)

2. Localiza la tabla **“Mutated Genes”**.
3. Identifica los **5 genes con mayor frecuencia de mutación**.

| #   | Gen   | N° de mutaciones | N° de pacientes | Frecuencia (%) |
| --- | ----- | ---------------- | --------------- | -------------- |
| 1   | TP53  | 1,259            | 1,123           | 42.8%          |
| 2   | EGFR  | 858              | 662             | 25.3%          |
| 3   | KRAS  | 526              | 523             | 20.0%          |
| 4   | IKZF3 | 1                | 1               | 11.1%          |
| 5   | LZTR1 | 3                | 3               | 9.1%           |

4. Selecciona **uno de esos genes**
   
   Se selecciona el gen **TP53**

**Responde:**

- ¿Cuántos pacientes presentan esa mutación?
  
  1,123 pacientes 

- ¿Qué tipo de mutación es más frecuente (missense, nonsense, frameshift)?
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig5.png?raw=true)
  
  **Missense Mutation**, representando aproximadamente **67%** (828/1,241) de las variantes observadas.
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig5-1.png?raw=true)

- ¿Qué vías de señalización aparecen alteradas en la pestaña *Pathways*?
  
  ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig6.png?raw=true)

---

##### 👩‍⚕️ Parte 3: Análisis clínico (15 min)

1. **Entra en la pestaña Clinical Data**.
   
   ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig11.png?raw=true)

2. **Examina las variables demográficas:**
   
   - **Distribución por sexo:**  En un total de 1123 muestras; mujeres 636 y hombres 487
     
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig7.png?raw=true) 
   
   - **Distribución por edad:** **Rango de edad:** 30 – 89 años **Mediana:** 59 años
     
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig9.png?raw=true)
   
   - **Distribución por raza:** Predominio de pacientes caucásicos
     
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig8.2.png?raw=true)
     
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig8.1.png?raw=true)     

3. **Calcula:**
   
   - **Rango de edad (edad máxima − edad mínima):** Entre 30 y 89 años
   
   - **Mediana de edad (usando “Compare Groups → Median”):** el rango de edad al diagnóstico para este estudio es de 59 años
     
     ![](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad3/Sesion2/Figures/Fig10.png?raw=true)

4. **Interpreta los resultados:**
   
   - **¿Existe una predominancia por sexo o edad?**
     Entre los 1,123 pacientes con mutaciones en TP53, se observó una mayor proporción de mujeres (636) respecto a hombres (487).  
     El rango etario abarca de 30 a 89 años, con una mediana de 59 años al diagnóstico.  
     Esto refleja una ligera predominancia femenina y una concentración en adultos mayores de mediana edad, grupo donde la exposición a factores ambientales y el daño acumulado del ADN son relevantes para la aparición de mutaciones en genes supresores como TP53.
   
   - **¿Qué implicancias podría tener esa distribución para el estudio del cáncer elegido?**
     
     La predominancia de mutaciones en adultos mayores y en mujeres podría estar relacionada con diferencias en exposición a carcinógenos (como tabaco o contaminantes ambientales) y variaciones hormonales que modulan la reparación del ADN.  
     Esta distribución es relevante para el diseño de estrategias terapéuticas personalizadas y para definir grupos de riesgo según edad y sexo en cáncer de pulmón metastásico.

---

##### 🧠 Parte 4: Análisis interpretativo (10 min)

Redacta un breve comentario (5–10 líneas) respondiendo:

¿Qué relación observas entre las mutaciones más frecuentes y las características clínicas del grupo?  
¿Por qué podría ser relevante este gen como biomarcador o diana terapéutica?

*Respuesta:*

```
Las mutaciones más frecuentes (TP53, EGFR y KRAS) se correlacionan con la edad avanzada y el estadio metastásico del tumor. Los pacientes con alteraciones en TP53 tienden a presentar peor pronóstico y menor respuesta a terapias dirigidas, mientras que EGFR y KRAS definen subgrupos con tratamientos específicos. El perfil mutacional observado refleja un panorama heterogéneo donde TP53 actúa como marcador de agresividad y resistencia. 
La pérdida de función de TP53 facilita la acumulación de mutaciones y la evasión apoptótica, contribuyendo a la progresión metastásica. En NSCLC, TP53 tiene valor como biomarcador pronóstico negativo y como posible diana terapéutica, ya que restaurar su función o explotar su inestabilidad podría mejorar la eficacia de inmunoterapias y quimioterapia personalizada.
```

---

- **Formato:** PDF o Markdown (.md) con respuestas y capturas de pantalla.
- **Tiempo estimado:** 60–75 minutos.
- **Evaluación sugerida:**

| Criterio                                      | Ponderación |
| --------------------------------------------- | ----------- |
| Selección y descripción del estudio           | 20 %        |
| Análisis genómico (tabla de genes + filtrado) | 30 %        |
| Análisis clínico y rango de edad              | 25 %        |
| Interpretación final                          | 25 %        |

---

## 💡 Recomendaciones

- Incluye al menos **dos capturas de pantalla** (una del panel *Summary* y otra del panel *Clinical Data*).
- Usa lenguaje claro y conciso en las respuestas.
- Cita el nombre del estudio tal como aparece en cBioPortal.
