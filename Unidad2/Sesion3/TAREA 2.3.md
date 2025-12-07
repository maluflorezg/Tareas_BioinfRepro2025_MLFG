### Tarea 2.3

#### Project1: ¿Todas las poblaciones actuales de Europa comparten el misma admixture?

El scrip utilizado en R Project1 es el siguiente:

```
# Once installed, load packages:
library(admixtools)
library(tidyverse)
library(ggplot2)
library(dplyr)

# Set working directory
setwd("~/Desktop/popgen_shared")

# Load metadata
metadf = read.table("v62.0_1240k_public_metadata2.csv", header = T, sep = ",")

# Project 1: Do all present-day populations from Europe displau the same 3-way admixture?

#### Get f2_blocks. Only once for the entire project

target1 <- c("GBR.DG", "Kazakhstan_Berel_IA.AG", "FIN.DG")  # ADD more modern and ancient European targets
source1 <- c("Turkey_Marmara_Barcin_N.AG", "Russia_Samara_EBA_Yamnaya.AG", "Luxembourg_Mesolithic.DG")
outgroup1 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")

all_pops <- c(target1, source1, outgroup1)
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect1"

extract_f2(pref = prefix,
           outdir = outdir,
           pops = all_pops,          # only populations to analyze
           overwrite = TRUE,
           blgsize = 0.05,            # block size in Morgans (default fine)
           verbose = TRUE)

#### Load f2_blocks
f2_blocks <- f2_from_precomp(outdir)

#### Outgroup-f3: shared drift between target and sources
#pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

f3_results <- f3(f2_blocks, pop1="Mbuti.DG", pop2=target1, pop3=source1)

#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?

f4_results <- f4(f2_blocks, pop1="GBR.DG", pop2=c("Kazakhstan_Berel_IA.AG", "FIN.DG"), pop3=source1, pop4="Mbuti.DG")

#### qpWave: test rank (how many ancestry streams are needed)
wave1 <- qpwave(f2_blocks,
                left = c(target1, source1),
                right = outgroup1)
wave1

#### qpAdm: 2-way and 3-way mixture models
admix_2way1 <- qpadm(f2_blocks, left= c(target1, source1[1:2]), right = outgroup1, target=target1[1])
admix_3way1 <- qpadm(f2_blocks, left = c(target1, source1), right = outgroup1, target=target1[1])
view(admix_2way1$weights)
view(admix_3way1$weights)
```

##### Definición de poblaciones

**Target1:** Poblaciones europeas antigua: Kazakhstan_Berel_IA.AG, 
**Source1:** Tres linajes ancestrales hipotéticos que podrían haber contribuido al acervo genético europeo. 
            **Barcin_N (Anatolia neolítica)** → ancestros de los primeros agricultores
europeos.
            **Yamnaya (estepa póntica)** → componente estepario.

            **Luxembourg_Mesolithic** → cazadores-recolectores europeos
occidentales.

**Outgroup1:** (referencia neutra) →Poblaciones externas sin relación directa
con Europa

Mbuti.DG, CHB.DG, Papuan.DG, Russia_UstIshim_IUP.DG, Denisova.DG

###### Load f2_blocks

Generan matrices de distancias genéticas por bloques entre todas las poblaciones incluidas.  

##### Outgroup_f3: Desviación compartida entre el objetivo y las fuentes

**pop1=** Outgroup **pop2=** Grupos o poblaciones +objetivo **pop3=** Con los que se va a probar la desviación compartida

- Se fija como **outgroup = Mbuti.DG**, una población africana muy divergente.

- Se calcula la deriva genética compartida entre los targets (GBR.DG, Kazakhstan_Berel_IA.AG, FIN.DG) y las fuentes (Turkey_Marmara_Barcin_N.AG, Russia_Samara_EBA_Yamnaya.AG, Luxembourg_Mesolithic.DG).

- Se mide para cada par (pop2, pop3) cuánta deriva genética compartida hay desde la separación del outgroup.

- Cuanto mayor sea el valor de f3, más relación genética comparten esas dos poblaciones.

- El **estadístico z** indica la **significancia****:** z > 3 significa resultado muy
  confiable.

**Resultados f3**

![project1_f3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project1_f3.png)

En general las poblaciones europeas modernas **(FIN.DG, GBR.DG)** muestran valores altos de z en f3 (133 a 147) con las tres fuentes antiguas (Mesolithic, Yamnaya, Barcin), lo que confirma que:

Europa
actual es el resultado de una mezcla de al menos tres componentes ancestrales:

1. Cazadores – recolectores occidentales

2. Agricultores neolíticos de Anatolia

3. Pueblos de la estepa póntica (Yamnaya)

**Finlandia (FIN.DG)**

- **FIN.DG – Mesolithic.DG (z=133)** 
  Relación fuerte: los finlandeses modernos comparten mucha deriva con cazadores – recolectores mesolíticos europeos, aunque ligeramente menor.

- **FIN.DG – Yamnaya.AG (z=145)**
  Muy alta relación: indica una fuerte componente esteparia en Finlandia

- **FIN.DG – Barcin_N.AG (z=144)**
  También comparten algo de ascendencia neolítica.

**Reino Unido (GBR.DG)**
Tiene una mezcla equilibrada entre Luxembourg y Barcin_N, con
fuerte componente Yamnaya, como se espera en el noroeste de Europa.

- **GBR.DG – Mesolithic.DG** **(z=133)**
  Los británicos modernos comparten deriva con los cazadores mesolíticos europeos.

- **GBR.DG – Yamnaya.AG** **(z=145)**
  Señal clara de mezcla con ascendencia esteparia (ya conocida en el noroeste europeo).

- **GBR.DG – Barcin_N.AG** **(z=147)**
  También comparten con los agricultores anatolios neolíticos

**Kazakhstan_Berel_IA.AG**

Muestra mayor relación con **Yamnaya**, pero menor con **Barcin_N****,** coherente con su origen estepario asiático y su distancia respecto a Europa Occidental.

- **Kazakhstan_Berel_IA.AG – Mesolithic.DG** **(z=118)**

Deriva compartida menor, relación débil con los cazadores occidentales.

- **Kazakhstan_Berel_IA.AG – Yamnaya.AG** **(z=137)**

Relación moderada: posible continuidad esteparia.

- **Kazakhstan_Berel_IA.AG – Barcin_N.AG** **(z=133)**

Poca relación con la ascendencia neolítica de Anatolia.

Esto nos confirma que las poblaciones modernas de Europa no comparten
exactamente el mismo patrón de mezcla, aunque derivan de los mismos tres componentes.

##### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?

###### Resultados f4

![project1_f4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project1_f4.png)

El test f4 mide si dos poblaciones están igualmente emparentadas con respecto a un
par de referencias.  
La idea es comprobar si hay una asimetría en las relaciones genéticas, es
decir, si una población objetivo está más cerca de una fuente que de otra.

**f4(A,B;C,D) f4(A, B; C, D)**

- Si **f4 = 0** → No hay evidencia de asimetría; A y B están igualmente
   emparentados con C y D.
- Si **f4 >0** → A comparte más alelos con C que B.
- Si **f4 < 0** → B comparte más alelos con C que A.
- Si **|Z|≥ 3**, la diferencia es estadísticamente significativa.

**1.** **GBR.DG, Kazakhstan_Berel_IA.AG; Turkey_Marmara_Barcin_N.AG, Mbuti.DG**

    GBR comparte más alelos con Barcin_N (Anatolia Neolítica) que Kazakhstan. Es decir,
    la población británica moderna tiene una herencia neolítica anatolia fuerte,     coherente con la expansión de agricultores del Neolítico hacia Europa occidental.

**2.** **GBR.DG, Kazakhstan_Berel_IA.AG; Russia_Samara_EBA_Yamnaya.AG, Mbuti.DG**

*GBR* está más próximo a Yamnaya que Kazakhstan, aunque la diferencia es menor. Esto
sugiere una componente esteparia moderada en la ascendencia británica.

**3.** **GBR.DG, Kazakhstan_Berel_IA.AG; Luxembourg_Mesolithic.DG, Mbuti.DG**

*GBR* comparte más deriva con Luxembourg Mesolítico (cazadores-recolectores europeos) que la población de *Kazajistán*.

**4.** **GBR.DG, FIN.DG; Turkey_Marmara_Barcin_N.AG, Mbuti.DG**

GBR es más cercano a Barcin_N que Finlandia, lo cual indica que el componente neolítico anatolio es más fuerte en Europa occidental (Britania) que en Europa del norte (Finlandia).

**5.** **GBR.DG, FIN.DG; Russia_Samara_EBA_Yamnaya.AG, Mbuti.DG**

No hay diferencia entre *GBR* y *FIN* en su afinidad hacia Yamnaya, aunque el signo
negativo indica una tendencia leve a mayor afinidad esteparia en Finlandia, coherente con su posición geográfica.

**6.** **GBR.DG, FIN.DG; Luxembourg_Mesolithic.DG, Mbuti.DG**

Finlandia comparte más alelos con Luxembourg Mesolithic que GBR, lo que sugiere que FIN retiene más ascendencia cazadora-recolectora europea que las poblaciones británicas, donde esa fracción fue más diluida por la llegada de agricultores.

**CONCLUSIONES:**

1. **Poblaciones occidentales (GBR.DG)** muestran mayor afinidad con:

        **Agricultores neolíticos (Barcin_N)**

        **Cazadores-recolectores mesolíticos (WHG)** → Esto refleja la historia de mezcla         de Europa occidental durante el Neolítico y la Edad del Bronce.

2. **Poblaciones del norte (FIN.DG)** muestran:

        **Mayor afinidad con Yamnaya (esteparia)** → consistente con su componente         genético estepario más alto.

        **Más relación con Mesolíticos** → posiblemente por conservación de linajes
        antiguos del norte europeo.

3. **Kazakhstan_Berel_IA.AG** (antigua población de Asia central) à Está
   más alejada de las fuentes europeas ancestrales, lo cual indica que es una
   población asiática esteparia sin mezcla europea posterior.

Los resultados f4 muestran que las poblaciones modernas de Gran Bretaña (GBR.DG) son genéticamente intermedias entre agricultores neolíticos de Anatolia (Barcin_N), pueblos de la estepa (Yamnaya) y cazadores-recolectores europeos (WHG), con predominio del componente neolítico europeo occidental.

En cambio, Finlandia conserva una mayor fracción cazadora-recolectora y una afinidad ligeramente mayor con la estepa, reflejando un perfil genético
más “nórdico” o “mesolítico”.

###### qpWave: test rank (how many ancestry streams are needed)**

El test qpWave evalúa si las poblaciones del bloque “left” pueden explicarse por un cierto número de flujos ancestrales distintos respecto al conjunto “right” (outgroups). Es decir, cuenta cuántos “componentes de mezcla” independientes son necesarias para explicar la variación genética observada.

**Rank =** Número de ondas (componentes) de ascendencia asumidas

**Dof =** Grados de libertad (depende de cuántas poblaciones haya en left y right).

**Chisq =** Estadístico Chi-cuadrado del ajuste del modelo para ese rango

**P =** Probabilidad de que el modelo se mantenga; si p > 0.05 → **modelo plausible**

**dofdiff** / **chisqdiff =** Diferencias entre modelos consecutivos (test de mejora del ajuste).

**p_nested =** p del modelo, indica si reducir el rango empeora el ajuste significativamente.

- **p_** **nested **< 0.05 → modelo rechazado**** (no explica los datos).

- **p****_nested **> 0.05 → modelo aceptado**** (suficiente número de fuentes).

**Significado del rank**

- **rank** **= 0** → Todas las poblaciones “left”
  derivan de **una misma fuente ancestral** (no hay mezcla).

- **rank** **= 1** → Se necesitan **dos flujos de
  ascendencia**.

- **rank** **= 2** → Se necesitan **tres flujos**.

El test se basa en compararmodelos anidados de distinto rango y ver en qué punto la probabilidad deja de ser significativa.

Hay dos pasos para rechazar una hipótesis:

1. **p del modelo mismo (p)**
- Si p > 0.05, el modelo *no se puede rechazar* (es plausible).

- Si p < 0.05, se *rechaza* (no explica bien los datos).
2. **p anidado (p_nested)**
- Compara si reducir el rango (por ejemplo, de 2 → 1) empeora significativamente el ajuste.

- Si p_nested < 0.05, la reducción *sí empeora* → el rango inferior se **Rechaza**.

###### RESULTADOS pqwave

**wave1** 

![project1_imagen_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project1_imagen_4.png)

**rank = 3**, SE ACEPTA (P=0.72)

**CONCLUSION:**

**Rank = 3, No se Rechaza** **à** Se necesitan **4 flujos de
ascendencia** (rank + 1 = 4) para explicar las relaciones entre las poblaciones del conjunto “left”.

**rank = 0, 1 y 2 =** Son **rechazados** (p_nested ≈ 0) → No puede explicarse con 1,
2 o 3 fuentes ancestrales.

**qpAdm: 2-way and 3-way mixture models**

Se quiere saber si GBR.DG puede explicarse como mezcla de Barcin_N

+ Yamnaya, que es el clásico modelo de dos componentes
  para Europa occidental.

**admix_2way**

![project1_admix_2way.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project1_admix_2way.png)

###### Weights

- **Turkey_Marmara_Barcin_N.AG = 1.28**

- **Russia_Samara_EBA_Yamnaya.AG = 4.36**

Ambos positivos, indica que GBR.DG comparte ascendencia con ambas fuentes.

La relación (aproximadamente 1 : 4) sugiere que la mayor parte de la ascendencia británica deriva del componente “estepario” (Yamnaya), con una menor pero presente contribución neolítica (Barcin).

###### admix_3way

![project1_admix_3way.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project1_admix_3way.png)

Al aplicar un 3-way qpAdm para GBR se obtiene:

**weights negativos**: sugieren que el modelo incluye fuentes correlacionadas.

**Z-score bajos**: Esto se debe a que el modelo no está bien ajustado o hay redundancia entre las fuentes.

**CONCLUSION:**

El modelo de tres fuentes (Barcin_N + Yamnaya + WHG) no muestra coeficientes significativos para GBR.DG.
Esto indica que el modelo estadístico no converge bien (probablemente por correlación entre fuentes o demasiadas poblaciones en “left”).

#### Project 2: Steppe formation model

El scrip utilizado en R Project2 es el siguiente:

```
# Project 2: Steppe formation model

## Modify names to match your dataset!

#### Load packages:
library(admixtools)
library(tidyverse)

#### Get f2_blocks. Only once for the entire project

target2 <- c("Russia_MLBA_Sintashta.AG", "Kazakhstan_Maitan_MLBA_Alakul.AG", "Russia_LBA_Srubnaya_Alakul.SG")
source2 <- c("Iran_GanjDareh_N.AG", "Russia_Sidelkino_HG.SG")
outgroup2 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")


all_pops <- c(target2, source2, outgroup2)
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect2"

extract_f2(pref = prefix,
           outdir = outdir,
           pops = all_pops,          # only populations to analyze
           overwrite = TRUE,
           blgsize = 0.05,            # block size in Morgans (default fine)
           verbose = TRUE)

#### Load f2_blocks
f2_blocks <- f2_from_precomp(outdir)

#### Outgroup-f3: shared drift between target and sources
#pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

f3_results <- f3(f2_blocks, pop1="Mbuti.DG", pop2=target2, pop3=source2)


#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population

f4_results_1 <- f4(f2_blocks, pop1="Russia_MLBA_Sintashta.AG", pop2= c("Kazakhstan_Maitan_MLBA_Alakul.AG", "Russia_LBA_Srubnaya_Alakul.SG"), pop3=source2, pop4="Mbuti.DG")
f4_results_2 <- f4(f2_blocks, pop1="Kazakhstan_Maitan_MLBA_Alakul.AG", pop2= c("Russia_MLBA_Sintashta.AG","Russia_LBA_Srubnaya_Alakul.SG"), pop3=source2, pop4="Mbuti.DG")
f4_results_3 <- f4(f2_blocks, pop1="Russia_LBA_Srubnaya_Alakul.SG", pop2= c("Russia_MLBA_Sintashta.AG", "Kazakhstan_Maitan_MLBA_Alakul.AG"), pop3=source2, pop4="Mbuti.DG")


#### qpWave: test rank (how many ancestry streams are needed). Run one per each target population
wave2_1 <- qpwave(f2_blocks,
                left = c(target2[3], source2),
                right = outgroup2)

wave2_2 <- qpwave(f2_blocks,
                  left = c(target2[2], source2),
                  right = outgroup2)
wave2_3 <- qpwave(f2_blocks,
                  left = c(target2[1], source2),
                  right = outgroup2)

#### qpAdm: 2-way mixture models. Run one per each target populations

admix_2way_1 <- qpwave(f2_blocks, left=c(target2[1], source2), right=outgroup2)  # Sintashta
admix_2way_2 <- qpwave(f2_blocks, left=c(target2[2], source2), right=outgroup2)  # Maitan/Alakul
admix_2way_3 <- qpwave(f2_blocks, left=c(target2[3], source2), right=outgroup2)  # Srubnaya/Alakul

admix_2way_1 <- qpadm(f2_blocks, left = c(target2[1], source2), right = outgroup2, target=target2[1])
admix_2way_2 <- qpadm(f2_blocks, left = c(target2[2], source2), right = outgroup2, target=target2[2])
admix_2way_3 <- qpadm(f2_blocks, left = c(target2[3], source2), right = outgroup2, target=target2[3])

View(admix_2way_1$weights)
View(admix_2way_2$weights)
View(admix_2way_3$weights)
```

- **Targets (poblaciones de la estepa):**
  Russia_MLBA_Sintashta.AG → Cultura Sintashta (Edad del Bronce Media
  Tardía, ~2000 a.C.)
  Kazakhstan_Maitan_MLBA_Alakul.AG → Cultura Alakul, área del norte de
  Kazajistán (~1900–1600 a.C.)
  Russia_LBA_Srubnaya_Alakul.SG → Cultura Srubnaya-Alakul, Rusia occidental
  (~1800 a.C.)

- **Source** **(posibles ancestros):**
   Iran_GanjDareh_N.AG → Población neolítica iraní (agricultores tempranos del  Zagros).
   Russia_Sidelkino_HG.SG → Cazadores-recolectores del noreste europeo (EHG)

- **Outgroup:** `Mbuti.DG` (africanos) → sirve como referencia externa para medir cuánta deriva comparten los pares (target–source).

###### Outgroup-f3: shared drift between target and sources

Mide cuánta deriva genética comparten las poblaciones de la estepa (targets) con dos posibles fuentes ancestrales: una iraní neolítica y una cazadora mesolítica del norte de Rusia.

**pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with**

![project2_f3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_f3.png)

El f3(Mbuti; Target, Source) mide la cantidad de deriva genética compartida entre el Target y la Source desde que se separaron del outgroup (Mbuti).

- **Valores mayores de f3 (est)** = mayor afinidad genética → Más ascendencia compartida.

- **Z-score** (indica la robustez), |z| ≥ 3 es significativo → Todos >100, extremadamente significativos.

Todos los valores de f3 son **altos** **(~0.068–0.075)** → Lo que indica que las poblaciones de la estepa muestran una gran afinidad tanto con los cazadores – recolectores
del norte (Sidelkino_HG) como con los agricultores iraníes (GanjDareh_N).

**CONCLUSIÓN:**  
Todos los grupos muestran afinidad con ambos orígenes, pero consistentemente un
poco mayor con Russia_Sidelkino_HG, lo cual es lógico dado que las culturas Sintashta, Srubnaya y Alakul son descendientes directos de la tradición Yamnaya, que tenía una fuerte base cazadora del norte.

###### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population

1. **f4_results_1 (pop1 = Sintashta):** 
   
   ![project2_f4_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_f4_1.png)
   
   Sintashta, Maitan y Srubnaya son genéticamente muy similares. Solo se observa una ligera tendencia a que Maitan tenga más
   relación con Irán_N, pero no es significativa (|z|<3). Es decir, se mantiene un linaje más “puro” estepario, con menos aporte iraní directo.

2. **f4_results_2 (pop1 = Maitan):** 
   
   ![project2_f4_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_f4_2.png)
   
   Resultado negativo de la f4 (–0.003, z≈–2.3) indica una ligera inclinación de Maitan hacia Irán_N; consistente con una mezcla algo más
   “sur-oriental” en comparación con Sintashta, reflejando quizás un mayor
   contacto con el sur o Asia Central.

3. **f4_results_3 (pop1 = Srubnaya):** 
   
   ![](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_f4_3.png)
   
   Srubnaya podría tener ligeramente más componente iraní que las otras poblaciones, pero la diferencia no es estadísticamente fuerte.

Los **tests f4** confirman que las tres culturas esteparias (Sintashta, Srubnaya, Alakul) forman un continuo genético muy homogéneo, derivado de la mezcla inicial entre Sidelkino y pueblos del Irán/Cáucaso (GanjDareh_N).

###### qpWave: test rank  (how many ancestry streams are needed). Run one per each target population

**wave2_1**→ **Russia_LBA_Srubnaya**

<img src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_qpwave_1.png" title="" alt="project2_qpwave_1.png" width="581">

- p(rank=1)= 0.599 → el modelo con **dos flujos** ajusta bien.

- p_nested(rank=0) = 6.21e-29` → una sola fuente ancestral no basta

Srubnayarequiere al menos dos fuentes de ascendencia —típicamente una esteparia (Yamnaya-like) y otra iraní/CHG-like.

**wave2_2→ Kazakhstan_Maitan_LBA**

![project2_qpwave_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_qpwave_2.png)

- p(rank=1) = 0.479 → el modelo de dos flujos también funciona bien.

- p_nested(rank=0) = 8.6e-23  → una sola fuente no explica la variación.

Maitan (Kazajistán Bronce Medio) también muestra mezcla bidireccional 

→ Un componente estepario (de Srubnaya/Sintashta) 

- Un componente meridional (Iran_N/CHG).

Este patrón es típico del movimiento de poblaciones indoeuropeas hacia Asia Central, incorporando ancestros locales del sur.

**wave2_3→ Russia_MLBA_Sintashta**

![project2_qpwave_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project2_qpwave_3.png)

- p(rank=1) = 0.667 → dos flujos explican los datos.

- p_nested(rank=0) = 9.98e-26 → un solo flujo ancestral no es suficiente.

Sintashta también requiere dos fuentes ancestrales:

→ Mayormente derivada de Yamnaya (esteparia)

- Una contribución de cazadores-recolectores del noreste europeo (EHG) o CHG-like.

En todos los casos, el rank=1 es aceptado → las tres poblaciones comparten la misma estructura de mezcla binaria, sin señales de una tercera ascendencia significativa.

###### 

**CONCLUSIÓN**

Los resultados combinados de los análisis f3, f4, qpAdm y qpWave confirman de
manera coherente el modelo clásico de formación de la ascendencia esteparia
euroasiática. Los valores elevados en la f3 indican que las tres poblaciones analizadas (Russia MLBA Sintashta.AG, Kazakhstan Maitan MLBA Alakul.AG y Russia LBA Srubnaya Alakul.SG) comparten una gran cantidad de deriva genética tanto con, Russia Sidelkino HG como con los agricultores del Neolítico iraní (Iran GanjDareh N), lo que sugiere una mezcla establecida entre estos linajes antes o durante la expansión de los grupos de la Edad del Bronce Medio.

En la f4 no detectaron asimetrías significativas entre las tres poblaciones, aunque
muestran ligeras tendencias de mayor afinidad de Maitan-Alakul y Srubnaya hacia el componente iraní en comparación con Sintashta, lo que podría reflejar contactos posteriores con poblaciones del sur de Asia Central. No obstante, las diferencias no son estadísticamente robustas, lo que apunta a una homogeneidad genética generalizada entre estos grupos de la estepa.

El modelo qpAdm (2-way) cuantifica la contribución de cada fuente ancestral, revelando proporciones promedio de ~30–35 % Iran N y ~65–70 % EHG, con errores estándar bajos y valores-Z > 4, lo cual respalda la existencia de una mezcla bipartita estable. Finalmente, los resultados de qpWave muestran que para todas las poblaciones el modelo de dos fuentes (rank = 1) es estadísticamente suficiente (p > 0.05), descartando la necesidad de una tercera corriente de ascendencia.

En conjunto, los datos demuestran que la ascendencia esteparia que caracterizó a
las poblaciones de la Edad del Bronce —y posteriormente se expandió hacia
Europa y Asia Central— se originó por la integración genética entre
cazadores-recolectores del noreste europeo y agricultores del suroeste
asiático. Las culturas Sintashta, Alakul y Srubnaya representan variaciones regionales de un mismo linaje estepario fundacional que permaneció genéticamente estable, consolidando la base genética que posteriormente se distribuyó con las migraciones indoeuropeas. 

#### 

#### Project 3: Peopling of the Americas**

El scrip utilizado en R Project3 es el siguiente:

```
# Project 3: Peopling of the Americas

#### Load packages:
library(tidyverse)
library(admixtools)

#### Get f2_blocks. Only once for the entire project

target3 <- c("Pima.DG", "CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG") #check for other ancient or present-day groups in the Americas.
source3 <- c("USA_Anzick_realigned.SG","USA_Ancient_Beringian.SG","USA_Nevada_SpiritCave_11000BP.SG")
outgroup3 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")


all_pops <- c(target3, source3, outgroup3, "India_GreatAndaman_100BP.SG")
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect3"

extract_f2(pref = prefix,
           outdir = outdir,
           pops = all_pops,          # only populations to analyze
           overwrite = TRUE,
           blgsize = 0.05,            # block size in Morgans (default fine)
           verbose = TRUE)

#### Load f2_blocks
f2_blocks <- f2_from_precomp(outdir)

#### Outgroup-f3: shared drift between target and sources
#pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

f3_results <- f3(f2_blocks, pop1="Mbuti.DG", pop2=target3, pop3=source3)


#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population
target3 <- c("Pima.DG", "CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG") #check for other ancient or present-day groups in the Americas.

f4_results_1 <- f4(f2_blocks, pop1="Pima.DG", pop2= c("CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_2 <- f4(f2_blocks, pop1="CLM.DG", pop2= c("Pima.DG", "Karitiana.DG", "Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_3 <- f4(f2_blocks, pop1="Karitiana.DG", pop2= c("Pima.DG", "CLM.DG", "Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_4 <- f4(f2_blocks, pop1="Chile_LosRieles_12000BP.AG", pop2= c("Pima.DG", "CLM.DG", "Karitiana.DG"), pop3=source3, pop4="Mbuti.DG")


#### qpWave: test rank (how many ancestry streams are needed). Run one per each target population
wave_1 <- qpwave(f2_blocks,
                left = c(target3[1], source3),
                right = outgroup3)

wave_2 <- qpwave(f2_blocks,
                  left = c(target3[2], source3),
                  right = outgroup3)

wave_3 <- qpwave(f2_blocks,
                  left = c(target3[3], source3),
                  right = outgroup3)

wave_4 <- qpwave(f2_blocks,
                  left = c(target3[4], source3),
                  right = outgroup3)

wave_5 <- qpwave(f2_blocks,
                left = c(target3[1],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                right = outgroup3)

wave_6 <- qpwave(f2_blocks,
                 left = c(target3[2],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_7 <- qpwave(f2_blocks,
                 left = c(target3[3],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_8 <- qpwave(f2_blocks,
                 left = c(target3[4],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_1
wave_2
wave_3
wave_4
wave_5
wave_6
wave_7
wave_8

#### qpAdm: 2 or 3-way mixture models. Run one per each target populations
admix_2way_1 <- qpadm(f2_blocks, left = c(target3[1], source3[1:2]), right = outgroup3, target=target3[1])
admix_2way_2 <- qpadm(f2_blocks, left = c(target3[2], source3[1:2]), right = outgroup3, target=target3[2])
admix_2way_3 <- qpadm(f2_blocks, left = c(target3[3], source3[1:2]), right = outgroup3, target=target3[3])
admix_2way_4 <- qpadm(f2_blocks, left = c(target3[4], source3[1:2]), right = outgroup3, target=target3[4])

View(admix_2way_1$weights)
View(admix_2way_2$weights)
View(admix_2way_3$weights)
View(admix_2way_4$weights)

admix_2way_1
admix_2way_2
admix_2way_3
admix_2way_4

admix_3way_1 <- qpadm(f2_blocks, left = c(target3[1], source3), right = outgroup3, target=target3[1])
admix_3way_2 <- qpadm(f2_blocks, left = c(target3[2], source3), right = outgroup3, target=target3[2])
admix_3way_3 <- qpadm(f2_blocks, left = c(target3[3], source3), right = outgroup3, target=target3[3])
admix_3way_4 <- qpadm(f2_blocks, left = c(target3[4], source3), right = outgroup3, target=target3[4])

View(admix_3way_1$weights)
View(admix_3way_2$weights)
View(admix_3way_3$weights)
View(admix_3way_4$weights)

admix_3way_1
admix_3way_2
admix_3way_3
admix_3way_4
```

###### Get f2_blocks. Only once for the entire project

- **Targets (poblaciones americanas modernas y antiguas):**
  Pima.DG (México / Norteamérica moderna)
  CLM.DG (Colombianos modernos)
  Karitiana.DG (Amazonía, Brasil
  Chile_LosRieles_12000BP.AG (antigua población del sur de Chile, ~12.000 a.C.)

- **Fuentes (poblaciones ancestrales del norte de América):**
  USA_Anzick_realigned.SG → individuo Clovis (Montana, ~12.600 a.C.)
  USA_Ancient_Beringian.SG → Alaska, linaje basal a todos los
  americanos
  USA_Nevada_SpiritCave_11000BP.SG → individuo de Nevada (~10.900 a.C.),
  posterior al poblamiento inicial.

- **Outgroup:** `Mbuti.DG` (africanos), para medir la deriva genética
  compartida.

###### Outgroup-f3: shared drift between target and sources

![project3_f3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_f3.png)

**CLM.DG –USA_Ancient_Beringian.SG (est= 0.0649, z= 128)**
CLM comparte mucha deriva con los antiguos de Alaska (linaje basal)

**CLM.DG – USA_Anzick_realigned.SG (est= 0.0679, z=128)**
Afinidad muy alta con Anzick (Clovis) → fuerte relación con el linaje americano
continental.

**CLM.DG –USA_Nevada_SpiritCave_11000BP.SG (est= 0.0673, z= 131)**
Relaciónsólida también con Spirit Cave → continuidad en América

**Chile_LosRieles_12000BP.AG – USA_Ancient_Beringian.SG (est= 0.0843, z=136)**
Alta afinidad → deriva compartida temprana con Alaska, coherente con un origen
común.

**Chile_LosRieles_12000BP.AG –USA_Nevada_SpiritCave_11000BP.SG (est= 0.0836, z= 136)**
Igual de alta afinidad → continuidad genética entre los primeros pobladores del norte
y del sur.

**Karitiana.DG – USA_Ancient_Beringian.SG (est= 0.0943, z= 140)**
Valor más alto del conjunto → fuerte conexión genética con la raíz americana

**Karitiana.DG – USA_ Anzick_realigned.SG (est= 0.0936, z=142)**
También altísima afinidad → descendencia directa del linaje Clovis.

**Karitiana.DG – USA_ Nevada_SpiritCave_11000BP.SG (est= 0.0925, z=141)**
Relación estable → continuidad desde el poblamiento inicial hasta Sudamérica

**Pima.DG – USA_ Ancient_Beringian.SG (est= 0.0874, z=126)**
Fuerte afinidad → linaje norteño conservado.

**Pima.DG – USA_ Anzick_realigned.SG (est= 0.0867, z= 136)**
Alta afinidad con Anzick → continuidad desde el norte de América

**Pima.DG – USA_ Nevada_SpiritCave_11000BP.SG (est= 0.0933, z= 136)**
También alto → Pima conserva la herencia basal americana.

Todos los valores de f3 son altos (0.06–0.09)→ lo que indica una fuerte afinidad genética entre los pueblos americanos modernos y los individuos antiguos del norte (Anzick, Spirit Cave, Ancient Beringian).

**CONCLUSIÓN Outgroup – f3: Deriva genética compartida**

El análisis outgroup-f3 midió la cantidad de deriva genética compartida entre las poblaciones americanas (Pima.DG, CLM.DG, Karitiana.DG y Chile_LosRieles_12000BP.AG) y sus potenciales fuentes antiguas del norte (USA_Anzick_realigned.SG, USA_Ancient_Beringian.SG, USA_Nevada_SpiritCave_11000BP.SG), usando Mbuti.DG como grupo externo.

Los valores de f3 fueron altos en todos los casos (0.06–0.09), indicando una fuerte afinidad genética entre los grupos modernos y los linajes antiguos.

- **Karitiana y Chile_LosRieles** mostraron los valores más altos (~0.09), lo que sugiere que conservan una gran fracción del linaje fundador americano.

- **Pima y CLM**, por su parte, presentaron valores ligeramente menores, reflejando mayor complejidad genética posterior, posiblemente por eventos de mezcla regional en América del Norte o Central.

Esto confirma que todas las ramas indígenas americanas derivan de una población
fundadora común originada tras la separación de los Ancient Beringians, que posteriormente se expandió rápidamente desde el norte de América hacia Sudamérica.

###### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population

**1) pop1= Pima.DG**

![project3_f4_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_f4_1.png)

- **vs CLM**: Pima está más cerca de Anzick, Ancient Beringian y Spirit que CLM.

- **vs Karitiana**: Karitiana está más cerca de Anzick, Ancient Beringian y Spirit que Pima 

- **vs LosRieles**: Pima más cercano de Anzick, Ancient Beringian y Spirit que LosRieles

Pima retiene más afinidad con el tronco beringiano y con Clovis que CLM/Karitiana/LosRieles, mientras que Karitiana muestran mayor cercanía a Anzick, Ancient Beringian y Spirit que Pima.

**2) pop1 = CLM.DG**

![project3_f4_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_f4_2.png)

- **vs Pima**: Pima más cercano Anzick, Ancient Beringian y Spirit Cave que CLM.

- **vs Karitiana**: Karitiana más cercano a Anzick, Ancient Beringian y Spirit que CLM

- **vs LosRieles**: CLM más cercano a Anzick, Ancient Beringian y Spirit Cave que LosRieles 
  
  Pima (México/norte) y Karitiana (Amazonía) retienen más herencia directa del linaje fundacional americano (Anzick/Beringian).  
  CLM (Colombia) muestra señales de aislamiento y mezcla posteriores,
  quedando genéticamente intermedia entre los antiguos norteños y los antiguos
  del sur (Chile 12 ka).

Por lo tanto, CLM.DG se separa claramente de los linajes antiguos americanos por su deriva moderna y mezcla, mientras que Pima y Karitiana preservan afinidades más antiguas; Chile_LosRieles, en cambio, representa un linaje basal sudamericano anterior a la diversificación continental.

**3) pop1 = Karitiana.DG****

![project3_f4_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_f4_3.png)

- **vs Pima:** Karitiana está más relacionada con Anzick, Ancient Beringian y Spirit Cave que Pima.

- **vs CLM**: Karitiana está más relacionada con Anzick, Ancient Beringian y Spirit Cave que CLM.

- **vs LosRieles**: Karitiana está más relacionada
  con Anzick y Ancient Beringian. Con respecto a Karitiana y LosRieles, tienen afinidades similares respecto a Spirit-Cave.

Karitiana muestra la mayor afinidad con Anzick, Ancient Beringian y Spirit Cave,
coherente con la idea de que estas muestras antiguas del interior de Norteamérica están más próximas al linaje que dio origen a muchos sudamericanos que a algunos norteños actuales.

**4) pop1 = Chile_LosRieles_12000BP.AG**

![project3_f4_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_f4_4.png)

- **vs Pima y CLM**: Resultados con Anzick y Spirit Cave ⇒ LosRieles está más cerca de Clovis/Spirit Cave que Pima y CLM.

- A diferencia Pima y Ancient Beringian están más relacionados que LosRieles

- **vs Karitiana**: Al igual que en la anterior LosRieles y Karitiana, tienen afinidades similares respecto a Spirit-Cave.

LosRieles y Karitiana comparten una relación muy estrecha con los Clovis/Spirit Cave (antiguos del interior de Norteamérica), más que Pima/CLM.

###### 

###### **CONCLUSION** **f4 Tests: Asimetrías y afinidades diferenciales**

Las pruebas **f4** se emplearon para evaluar si las poblaciones actuales muestran una mayor afinidad hacia alguna de las fuentes antiguas específicas.

Los resultados indican que:

- **Pima.DG** y **CLM.DG** presentan asimetrías significativas respecto a Anzick y Spirit Cave, lo que refleja una mayor cercanía con linajes continentales del Holoceno temprano que con los antiguos beringianos. 

- **Karitiana.DG** muestra un patrón más equilibrado, sin
  sesgos claros hacia ninguna fuente, lo que sugiere una posición intermedia o
  basal dentro del linaje americano.

- **Chile_LosRieles_12000BP.AG** exhibe mayor afinidad con Anzick
  (Clovis, ~12.6 ka) que con Ancient Beringian o Spirit Cave, reforzando su relación directa con los primeros pobladores del continente.

Estas asimetrías evidencian que, aunque todas las poblaciones comparten un ancestro
común, la estructura interna del linaje americano se diversificó rápidamente, generando afinidades diferenciadas entre regiones.

###### qpWave: test rank (how many ancestry streams are needed). Run one per each target population**

en `qpWave` miramos el **rank** mínimo
aceptado (p-value > 0.05).

- **rank = 0** ⇒ “1 flujo de ascendencia” basta (clado).

- **rank = 1** ⇒ “2 flujos” (modelo 2-way).

- **Rank = 2** ⇒ “3 flujos” (modelo 3-way), etc.

· Si un rank se **Rechaza** (p < 0.05), necesitamos más flujos.

**1) wave_1 — Pima +(Anzick, AB, SpiritCave)**

![project3_qpwave_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_1.png)

**rank=2**, No se rechaza. Se requieren al menos al menos 3 flujos de ascendencia independientes para explicar la relación de Pima.DG con Anzick, Ancient Beringian y Spirit Cave frente a los outgroups.

**2) wave_2 — CLM +(Anzick, AB, SpiritCave)**### 

![project3_qpwave_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_2.png) **rank=2**, **rank=2**, No se rechaza. Se requieren al menos al menos 3 flujos de ascendencia independientes para explicar la relación de CLM con Anzick, Ancient Beringian y Spirit Cave frente a los outgroups.
CLM representa una mezcla de al menos tres linajes: un componente ancestral
beringiano, uno cloviano (Anzick) y uno posterior o diferenciado (SpiritCave).

###### 3) wave_3 — Karitiana + (Anzick, AB, SpiritCave)

**rank=2**, No se rechaza à Se requieren al menos al menos 3 flujos de ascendencia

independientes para explicar la relación de Karitiana con Anzick, Ancient Beringian y Spirit Cave frente a los outgroups.
Karitiana conserva un linaje americano profundo similar al beringiano, con
contribuciones de ascendencia Clovis y Spirit Cave, pero sin evidencia de flujo
reciente

**4) wave_4 — LosRieles + (Anzick, AB, SpiritCave)**

![project3_qpwave_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_4.png) **Rank=1** Se ACEPTA. Se requieren al menos al menos 2 o 3 flujos de ascendencia independientes para explicar la relación de LosRieles con Anzick, Ancient Beringian y Spirit Cave frente a los outgroups. Chile_LosRieles refleja una población derivada de los
linajes fundadores de América (Anzick/Beringian) con una ligera diferenciación
hacia un componente similar a SpiritCave — evidencia de estructura continental
incipiente hacia 12 ka BP.

**CONCLUSION qpWave: Número de flujos de ascendencia**

El test **qpWave** se utilizó para estimar el número mínimo de corrientes de ascendencia que explican cada población americana en relación con los antiguos linajes del
norte.

Los resultados muestran que:

- **Pima.DG** y **CLM.DG y Karitiana.DG:** requieren al menos tres flujos de ascendencia independientes, indicando mezclas complejas entre linajes beringianos, clovisoides y posiblemente otros continentales posteriores.

- **Chile_LosRieles_12000BP.AG** también muestra necesidad de dos o tres flujos, aunque con predominio claro del linaje Clovis.

De forma general, qpWave sugiere que la diversidad genética americana no se originó
a partir de un único flujo migratorio, sino mediante la combinación de múltiples ramas derivadas de una población fundadora común en Beringia.

**qpAdm: 2-way mixture models. Run one per each target populations**

**1)** **Pima.DG**

![project3_admix_2way_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_1.png)

- Los weight no son significativos (|z| < 3) y además los valores son grandes pero con errores altos → el modelo no es estable.

- El signo negativo de Anzick y positivo de Ancient Beringian sugiere una tendencia hacia un componente beringiano más fuerte, pero estadísticamente no se sostiene.
  
  **2) CLM.DG (Colombianos modernos)**
  
  ![project3_admix_2way_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_2.png)

- El modelo claramente **inestable** (errores inmensos, pesos irreales).

- Esto ocurre cuando las dos fuentes son **demasiado correlacionadas** (Anzick y Ancient Beringian comparten demasiada historia común frente a CLM).

**3)** **Karitiana**

![project3_admix_2way_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_3.png)

- Igual que Pima: coeficientes grandes, errores altos, Z insignificantes.

- Señal de mayor peso positivo para Ancient Beringian (norteño), pero no significativa.

**4)** **Chile_LosRieles**

![project3_admix_2way_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_4.png)

- weight positivo para <Anzick (Clovis)

- weight ligeramente negativo para Ancient Beringian → indica mayor afinidad de Los Rieles con el linaje continental de Anzick, y menor aporte, aunque estadísticamente no significativo (|z| < 3)

- 

**CONCLUSION qpAdm 2-way: Modelos de mezcla binaria**

Los modelos de dos fuentes (Anzick + Ancient Beringian) fueron inestables para casi
todas las poblaciones:

- En **Pima**, los coeficientes indicaron una leve tendencia hacia el linaje beringiano, pero sin significancia estadística.

- En **CLM** y **Karitiana**, los errores fueron altos y la proporciones irreales, reflejando colinealidad entre las fuentes.

- Solo **Chile_LosRieles** mostró un patrón interpretable, con un mayor aporte del linaje Clovis (Anzick) y una contribución menor de Ancient Beringian.

La población Chile_LosRieles_12000BP.AG, de edad paleolítica temprana, sí puede explicarse principalmente como descendiente del linaje Clovis (Anzick) con mínima o nula influencia beringiana, reforzando un modelo de poblamiento inicial rápido y continuo desde el norte de América hacia el sur antes de 12.000 BP.

Estos resultados confirman que dos fuentes no bastan para explicar la diversidad genética americana actual. Los modelos de mezcla binaria (Anzick + Ancient Beringian) son insuficientes para explicar la diversidad genética de las poblaciones americanas modernas. Las poblaciones Pima, CLM y Karitiana requieren al menos un tercer flujo,
probablemente representado por linajes tipo Spirit Cave (~11 ka) o derivados de expansiones continentales posteriores.

**qpAdm: 3-way mixture models. Run one per each target populations**

**1)** **Pima.DG**

![project3_admix_3way_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_3way_1.png)

![project3_admix_3way_2_rankdrop.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_3way_2_rankdrop.png)

- El modelo **3-way** funciona: el rank 2 se acepta → tres fuentes explican bien a Pima.

- Solo **Spirit Cave (~11 ka)** tiene un peso significativo (z>3), lo que indica que **Pima** conserva una **fuerte** **afinidad con poblaciones del interior de Norteamérica
  post-Clovis**, más que con Clovis (Anzick) o Ancient Beringian.

· Las otras dos fuentes aportan
contribuciones pequeñas o no significativas.

**2)** **CLM.DG**

![project3_admix_2way_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_1.png)

![project3_admix_2way_2_rankdrop.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_2_rankdrop.png)

- Weight: Muy y con grandes errores, lo que indica colinealidad entre fuentes y mal ajuste.

- Ninguna fuente tiene |z|significativa → el modelo no es confiable.

- rank 2: p < 0.05 → parcialmente aceptado, pero modelo inestable.
  
  

**3)** **Karitiana.DG**

![project3_admix_2way_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_3.png)

![project3_admix_2way_3_rankdrop.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_3_rankdrop.png)

- Ninguna fuente tiene un weight significativo; errores muy altos.

- A pesar de que el modelo 3-way se ajusta estadísticamente, la inestabilidad numérica indica dependencia fuerte entre las tres fuentes.
  
  

**4) Chile_LosRieles_12000BP.AG**

![project3_admix_2way_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_4.png)

![project3_admix_2way_4_rankdrop.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_admix_2way_4_rankdrop.png)



- Buen ajuste general, errores moderados. weight positivos.

- Mayor contribución de **Anzick (Clovis)** y algo menor de Spirit Cave, con aporte casi nulo de Ancient Beringian.

- rank 2: p > 0.05 → **ACEPTADO**

- Es el modelo más estable de los cuatro targets.
  
  

**CONCLUSION qpAdm 3-way: Modelos de mezcla binaria**

El análisis de mezcla de tres vías confirma que ninguna población americana moderna o antigua se explica completamente con solo dos linajes del norte (Anzick y Ancient Beringian).

- En el norte (Pima): Predomina un componente Spirit Cave-like, indicando mezcla posterior entre linajes beringianos y continentales.

- En el centro (CLM): El modelo 3-way no converge, lo que sugiere una mayor complejidad genética asociada a migraciones tardías y flujo génico regional.

- En el sur (Karitiana y LosRieles): Ambos derivan principalmente del linaje Clovis/Anzick, con escasa señal beringiana.

En conjunto, los resultados son coherentes con un modelo de poblamiento rápido desde Beringia hacia Sudamérica, con una posterior estructuración norte–sur y una segunda mezcla continental que afectó sobre todo a poblaciones del norte.



**CONCLUSION FINAL**

El poblamiento del continente americano ha sido uno de los procesos más debatidos
en arqueogenética. A partir de los resultados obtenidos mediante los tests f3, f4,qpWave y qpAdm (2 - 3 way), se observa un patrón coherente que refuerza un modelo de **origen común temprano en Beringia, seguido de una rápida dispersión hacia el sur y una diferenciación norte – sur progresiva.

Los resultados integrados demuestran que todas las poblaciones americanas derivan
de un linaje fundador común originado en Beringia, el cual se diversificó poco después del ingreso al continente.

Las poblaciones del norte (Pima, CLM) presentan señales de mezclas múltiples entre linajes beringianos y continentales posteriores, mientras que las del sur (Karitiana,
Los Rieles) conservan una ascendencia más directa del linaje Clovis.

En conjunto, los análisis apoyan un modelo de poblamiento temprano, rápido y
continuo desde el norte de América hacia el sur, con una posterior estructuración latitudinal y una complejidad creciente hacia las regiones septentrionales por mezclas secundarias durante el Holoceno.

Estos patrones son consistentes con la hipótesis de una única dispersión inicial a través del corredor beringiano, seguida de una expansión en oleadas sucesivas que dieron origen a la diversidad genética observada en las poblaciones americanas modernas y antiguas.



#### **Project 4: Medieval / Iberian admixture**

**Get f2_blocks. Only once for the entire project**

El scrip utilizado en R Project4 es el siguiente:

```
# Project 4: Medieval / Iberian admixture

## Modify names to match your dataset!

#### Load packages:
library(admixtools)
library(tidyverse)

#### Get f2_blocks. Only once for the entire project

target4 <- c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG") 
source4 <- c("Spain_MLN.AG", "Morocco_EN.WGC.SG", "Yoruba.DG") 
outgroup4 <- c("Ethiopia_4500BP.SG", "Han.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG")


all_pops <- c(target4, source4, outgroup4)
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect4"

extract_f2(pref = prefix,
           outdir = outdir,
           pops = all_pops,          # only populations to analyze
           overwrite = TRUE,
           blgsize = 0.05,            # block size in Morgans (default fine)
           verbose = TRUE)

#### Load f2_blocks
f2_blocks <- f2_from_precomp(outdir)

#### Outgroup-f3: shared drift between target and sources
#pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

f3_results <- f3(f2_blocks, pop1="Ethiopia_4500BP.SG", pop2=target4, pop3=source4)


#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population


f4_results_1 <- f4(f2_blocks, pop1="Spain_Islamic.AG", pop2= c("Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_2 <- f4(f2_blocks, pop1="Spain_Medieval.AG", pop2= c("Spain_Islamic.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_3 <- f4(f2_blocks, pop1="Spain_NazariPeriod_Muslim.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_4 <- f4(f2_blocks, pop1="Spain_Islamic_Zira.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_5 <- f4(f2_blocks, pop1="Spain_Visigoth_Granada.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG"), pop3=source4, pop4="Mbuti.DG")


#### qpWave: test rank (how many ancestry streams are needed). Run one per each target population
wave_1 <- qpwave(f2_blocks,
                left = c(target4[1:2], source4),
                right = outgroup4)

wave_2 <- qpwave(f2_blocks,
                 left = c(target4[2], source4),
                 right = outgroup4)
wave_3 <- qpwave(f2_blocks,
                 left = c(target4[3], source4),
                 right = outgroup4)
wave_4 <- qpwave(f2_blocks,
                 left = c(target4[4], source4),
                 right = outgroup4)
wave_5 <- qpwave(f2_blocks,
                 left = c(target4[5], source4),
                 right = outgroup4)

wave_1
wave_2
wave_3
wave_4
wave_5

#### qpAdm: 2 or 3-way mixture models. Run one per each target populations
admix_2way_1 <- qpadm(f2_blocks, left = c(target4[1], source4[1:2]), right = outgroup4, target=target4[1])
admix_2way_2 <- qpadm(f2_blocks, left = c(target4[2], source4[1:2]), right = outgroup4, target=target4[2])
admix_2way_3 <- qpadm(f2_blocks, left = c(target4[3], source4[1:2]), right = outgroup4, target=target4[3])
admix_2way_4 <- qpadm(f2_blocks, left = c(target4[4], source4[1:2]), right = outgroup4, target=target4[4])
admix_2way_5 <- qpadm(f2_blocks, left = c(target4[5], source4[1:2]), right = outgroup4, target=target4[5])

View(admix_2way_1$weights)
View(admix_2way_2$weights)
View(admix_2way_3$weights)
View(admix_2way_4$weights)
View(admix_2way_5$weights)
admix_2way_1
admix_2way_2
admix_2way_3
admix_2way_4
admix_2way_5


```



En este proyecoto se busca explorar las relaciones genéticas entre las poblaciones
de la **Península Ibérica medieval** y sus
posibles fuentes africanas, norteafricanas y neolíticas.

**Targets (poblaciones ibéricas medievales e islámicas):**

- *Spain_Islamic.AG* — población islámica de época andalusí.

- *Spain_Islamic_Zira.AG* — islámicos del sitio de Zira.

- *Spain_Medieval.AG* — individuos cristianos y musulmanes medievales.

- *Spain_NazariPeriod_Muslim.AG* — individuos del último reino musulmán (Granada, siglo XIII–XV).

- *Spain_Visigoth_Granada.AG* — individuos visigodos de la Alta Edad Media.

**Sources (posibles orígenes):**

- *Spain_MLN.AG* → Neolítico ibérico (autóctono europeo).

- *Morocco_EN.WGC.SG* → Neolítico marroquí (norte de África).

- *Yoruba.DG* → África subsahariana (control africano).

**Outgroup:** *Ethiopia_4500BP.SG* (línea africana basal usada para calibrar la deriva).



**Outgroup-f3: shared**

![project4_f3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f3.png)

pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

Permite medir la cantidad de deriva genética compartida entre las poblaciones ibéricas medievales e islámicas y una población *source* (posibles fuentes de ascendencia), desde que ambas se separaron del *outgroup* (Ethiopia_4500BP.SG, una población basal africana). Cuanto mayor sea el valor de f3, más cercana es larelación genética entre *target* y *source*.

- **Spain_MLN.AG** presenta el valores altos de f3 (~0.11–0.12), lo cual indica
  una fuerte continuidad genética local desde el Neolítico ibérico.

- **Morocco_EN.WGC.SG** presenta valores ligeramente menores (~0.09–0.10), lo cual indica una relación secundaria o mezcla norteafricana.

- **Yoruba.DG** tiene valores mucho más bajos (~0.07), lo cual indica una débil influencia subsahariana, probablemente introducida durante el periodo islámico.



**CONCLUSIÓN - Outgroup – f3:**

Los resultados del outgroup-f3 indican que las poblaciones medievales e islámicas
de la Península Ibérica comparten una base genética sólida con el linaje neolítico local (*Spain_MLN.AG*), complementada por un aporte norteafricano procedente del Magreb (*Morocco_EN.WGC.SG*) y una contribución menor, aunque detectables, de origen subsahariano (*Yoruba.DG*).

En conjunto, estos patrones apoyan un modelo de admixture ibérico-magrebi sostenido desde la Edad Media, superpuesto sobre una estructura genética autóctona persistente desde el Neolítico.



###### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population**

Queremos evaluar asimetrías genéticas entre las poblaciones medievales ibéricas y sus posibles fuentes ancestrales.

- **pop1** = una población medieval ibérica (el target).

- **pop2** = otras poblaciones medievales contemporáneas.

-  **pop3** = posibles fuentes (Spain_MLN.AG, Morocco_EN.WGC.SG, Yoruba.DG).

- **pop4** = Mbuti.DG (outgroup).
  
  

**1) Spain_Islamic.AG como población de referencia**

![project4_f4_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f4_1.png)

-  **f4 < 0 con Spain_MLN.AG y Morocco_EN.WGC.SG** → indica que *Spain_Islamic.AG* comparte **más alelos con el Magreb** y **con el Neolítico ibérico** que las demás poblaciones medievales.

- El **|z|**es significativo → clara asimetría.

- Con **Yoruba.DG**, f4 también negativo, aunque menor → Indica un leve componente subsahariano.

*Spain_Islamic.AG* tiene una afinidad genética significativamente mayor con el **Magreb y el componente africano**, en comparación con las otras poblaciones medievales ibéricas.



**2) Spain_Medieval.AG como población de referencia**

![project4_f4_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f4_2.png)

- **f4 < 0 con MLN y Morocco_EN.WGC.SG** → las poblaciones islámicas (comparadas) son más cercanas al Magreb.

- **f4 negativo con Yoruba.DG** → *Spain_Medieval.AG* tiene menos aporte africano subsahariano que los grupos islámicos.

Las poblaciones *Spain_Medieval.AG* (cristianas o preislámicas) conservan un perfil predominantemente ibérico local, con muy poca influencia africana.



 **3) Spain_NazariPeriod_Muslim.AG comopoblación de referencia**

![project4_f4_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f4_3.png)

**f4 < 0 con Morocco_EN.WGC.SG** → fuerte señal de mezcla magrebí reciente.

- **f4>0 con Spain_MLN.AG** → aún conserva una base genética ibérica.

- **f4 ligeramente negativo con Yoruba.DG** → presencia menor de componente subsahariano.

La población *NazariPeriod_Muslim.AG* representa un **modelo mixto**: base ibérica local con un **aporte magrebí notable**, lo que concuerda con la historia de Granada como refugio de comunidades musulmanas norteafricanas tras la Reconquista.



**4) Spain_Islamic_Zira.AG como población de referencia**

![project4_f4_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f4_4.png)

- **f4 negativos con Morocco_EN.WGC.SG (Z ≈ –5 a –7)** → alta afinidad magrebí.

- **f4 neutros con Spain_MLN.AG (Z < 2)** → menor conexión con el Neolítico ibérico que las otras.

- **f4 negativos con Yoruba.DG** → posible rastro subsahariano leve, pero no significativo.

*Spain_Islamic_Zira.AG* muestra la **mayor proximidad genética al Magreb**, siendo probablemente la población más representativa del influjo norteafricano directo durante la ocupación islámica.



**5) Spain_Visigoth_Granada.AG como población de referencia**

![project4_f4_5.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_f4_5.png)

- **f4>0 con Spain_MLN.AG (Z ≈ +4–5)** → fuerte continuidad local con el Neolítico ibérico.

- **f4 ≈ 0 o ligeramente negativo con Morocco_EN.WGC.SG** → Nula o mínima afinidad magrebí.

- **f4 negativo con Yoruba.DG** → ausencia total de aporte subsahariano.

*Spain_Visigoth_Granada.AG* es genéticamente el grupo más "autóctono", derivado casi exclusivamente del linaje neolítico europeo.



**Conclusión del test f4**

Los resultados del test f4 muestran una clara estructura genética dentro de la
Península Ibérica medieval, con una gradiente norteafricano-ibérico:

- Las poblaciones islámicas y nazaríes presentan mayor afinidad genética con el norte de África (Morocco_EN.WGC.SG) y señales leves de flujo subsahariano.

- Las poblaciones visigodas y medievales cristianas muestran continuidad genética con el Neolítico ibérico (Spain_MLN.AG) y carecen de influencia africana.

En conjunto, los resultados apoyan un modelo de admixture ibérico-magrebi,
donde las poblaciones musulmanas introdujeron componentes norteafricanos y
africanos menores sobre una base genética europea establecida desde el
Neolítico.



###### qpWave: test rank (how many ancestry streams are needed). Run one per each target population



**1) wave_1 — Spain_Islamic.AG + (Anzick, AB, SpiritCave)**

![project3_qpwave_1.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_1.png)



**2) wave_2 — Spain_Medieval.AG + (Anzick, AB, SpiritCave)**

![project3_qpwave_2.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_2.png)

**3) wave_3 — Spain_NazariPeriod_Muslim.AG**

![project3_qpwave_3.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_3.png)

**4) wave_4 — **Spain_Islamic_Zira.AG**

![project3_qpwave_4.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_4.png)

**5) wave_5 — Spain_Visigoth_Granada.AG**

![project3_qpwave_5.png](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project3_qpwave_5.png)



**Conclusión General**

Ninguna de las poblaciones históricas ibéricas se explica por ≤2 flujos; todas requieren al menos 3 corrientes ancestrales. Esto no indica que la historia genética de Iberia histórica es intrínsecamente multifuente. La norma es ≥3 corrientes de ascendencia,
y el islámico temprano probablemente ≥4, reflejando migraciones y
mezclas continuas entre Europa occidental, el Magreb y África subsahariana, con variación espacial y temporal acorde a los procesos históricos documentados.

**qpAdm: 2-way mixture models. Run one per each target populations**

1) **Spain_Islamic.AG**
   
   <img src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_admix_2way_1.png" title="" alt="project4_admix_2way_1.png" width="310">
   
   

El modelo 2-vías es **válido** à ≥2 fuentes necesarias(p=0.123). Mezcla inicial ligera,
posiblemente primera ola islámica con flujo norteafricano reducido.



**2) Spain_Medieval.AG**

<img title="" src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_admix_2way_2.png" alt="project4_admix_2way_2.png" width="367">

El modelo requiere ≥2 fuentes(p= 1.55e-3); ajuste más ajustado pero válido. En este conjunto, el elemento africano parece diluido o ausente; predominancia europea.



**3) Spain_NazariPeriod_Muslim.AG**

<img src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_admix_2way_3.png" title="" alt="project4_admix_2way_3.png" width="397">

El modelo presenta buen ajuste para mezcla 2-vías (p=4.89e-3). Incremento claro de mezcla norteafricana en época nazarí.



**4) **pain_Islamic_Zira.AG**

<img src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_admix_2way_4.png" title="" alt="project4_admix_2way_4.png" width="378">

El modelo es válido (p= 1.10e-3). Señal africana intermedia; persistencia local del componente magrebí.



**5) Spain_Visigoth_Granada.AG**

<img src="file:///Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/Tarea%202.3/Figures%202.3/project4_admix_2way_5.png" title="" alt="project4_admix_2way_5.png" width="354">

El modelo presenta buen ajuste para mezcla 2-vías (p= 8.13e-2). Sorpresiva
presencia pre-islámica del componente magrebí: sugiere contactos previos o
ancestría regional común.



**CONCLUSION qpAdm 2-way: Modelos de mezcla binaria**

Las cinco poblaciones se explican adecuadamente con solo dos fuentes: una europea neolítica local y una norteafricana.  
El test *rank = 1* es aceptable en todos los casos.

**1. La proporción magrebí varía temporalmente:**

- mínima o nula en el **Medieval temprano****,**

- moderada (10–15 %) en **Nazarí, Islámico Zira y Visigodo**,
* muy leve (~5 %) en el **Islámico temprano**

En conjunto, las poblaciones ibéricas históricas pueden modelarse como mezcla básicamente bicomponente (Europa neolítica + Norte de África), con variaciones temporales en la magnitud del aporte magrebí.



**CONCLUSION FINAL**

El proyecto revela un patrón coherente de mezcla entre Europa y el norte de África en la historia genética de la Península Ibérica:

- La ascendencia europea neolítica (Spain_MLN) es la base común de todas las poblaciones medievales.

- El aporte magrebí (Morocco_EN) aparece  t empranamente, se modula según el
  contexto migratorio.

- La señal subsahariana es débil y secundaria, probablemente mediada por rutas transaharianas o comercio islámico.

- Ninguna población se explica por una sola fuente, confirmando una estructura genómica multiorigen, con ≥2 flujos principales y evidencias de continuidad local.

En conjunto, los resultados integran evidencia genética y arqueohistórica de un contacto sostenido entre Iberia y el Magreb desde tiempos visigodos hasta la caída de Granada, con fluctuaciones en magnitud pero continuidad en el vínculo biológico y cultural.
