## TAREA 2.2

### **Análisis genético de poblaciones**

#### Parte 1: Análisis de control de calidad

Responda las siguientes preguntas:

##### 1. ¿Cómo se llaman los archivos que contienen las tasas de datos perdidos por SNP y por muestra?

**Comando:**

```
plink --bfile $C/chilean_all48_hg19 --missing
```

 **Por SNP:** `plink.lmiss`
 **Por Individuo:** `plink.lmiss`

##### 2. ¿Cuántas variantes se eliminaron por tener una tasa de datos perdidos mayor a 0.2?

Fueron removidos **4680 variantes**

El siguiente comando elimina SNPs e individuos con pérdida de datos >0,2

```
plink --bfile $C/chilean_all48_hg19 --geno 0.2 --make-bed --out chilean_all48_hg19_2
plink --bfile chilean_all48_hg19_2 --mind 0.2 --make-bed --out chilean_all48_hg19_3
```

**Después de aplicar el filtro:** 

```
Total genotyping rate is 0.989751.
4680 variants removed due to missing genotype data (--geno).
808686 variants and 48 people pass filters and QC
```

##### 3. ¿Cuántos individuos tenían una tasa de datos perdidos mayor a 0,02?

El siguiente comando elimina SNPs e individuos con pérdida de datos >0,02

```
plink --bfile chilean_all48_hg19_3 --geno 0.02 --make-bed --out chilean_all48_hg19_4
plink --bfile chilean_all48_hg19_4 --mind 0.02 --make-bed --out chilean_all48_hg19_5
```

**Después de aplicar el filtro:**

```
Total genotyping rate is 0.991846.
234062 variants removed due to missing genotype data (--geno).
574624 variants and 48 people pass filters and QC.
```

Basado en los resultados no hubo invividuos con una tasa de datos perdidos mayor a 0.02, se mantienen los mismos 48 individuos iniciales

##### 4. Basados en los histogramas y en sus cálculos, ¿qué valores umbrales de datos perdidos para muestras y SNPs sugeriría?

Yo suguiero aplicar el umbral de 0.02 para SNPs (-geno) e individuos (-mind), debido a que en los histogramas puedo observar que con estos umbrales puedo descartar una gran cantidad de variantes con datos perdidos pero no descarto individuos.

### Parte 2: Revisar Discrepancias

Revise discrepancias entre entre el sexo declarado en el la tabla de fenotipos (archivo ped/bed) y el inferido desde los genotipos

##### 1. ¿Cuántos individuos fueron eliminados por discrepancia de sexo?

```
plink --bfile chilean_all48_hg19_5 --remove sex_discrepancy.txt --make-bed --out
```

```
574624 variants and 45 people pass filters and QC.
```

##### 2. ¿Qué riesgo(s) se corre(n) si no se eliminaran?

En Plink, se puede inferir el sexo genético de cada individuo a partir de marcadores del cromosoma X.  Luego, Plink compara ese sexo genético inferido con el sexo declarado en el archivo `.fam`.

**Si NO se eliminan las discrepancias en esos individuos:**

Puede haber riesgo de errores de calidad, como: 

- Indicar que hubo **intercambio de muestras** (mix-up)

- Que se asignó mal el ID del individuo,

- O que los datos de genotipado están **contaminados** (mezcla de ADN).  

- Además, se introduce **ruido o falsos resultados** en los análisis.

**Sesgos en análisis de asociación (GWAS, FST, PCA, etc.)**

- Los genotipos del cromosoma X/Y se comportan distinto según el sexo.

- Un individuo con sexo mal asignado puede distorsionar:
  
  - Cálculos de heterocigosidad (porque los hombres son hemicigotos en X)
  
  - Diversidad genética o estructura poblacional
  
  - Frecuencias alélicas
  
  - Errores en los test de asociación (porque el modelo asume que los sexos son correctos).

**Problemas en imputación y análisis por cromosoma**

- Al imputar o filtrar datos por cromosoma, Plink usa el sexo para decidir si esperar 1 o 2 copias de cada alelo en X/Y.

- Un sexo mal asignado puede causar errores de formato o exclusión de SNPs.

### Parte 3: Filtrado de SNPs

##### 1. ¿Cuál es el nombre del primer conjunto de datos que solo contiene SNPs en autosomas?

Inicialmente quedan en un listado `snp_1_22.txt`contiene los SNPs autosomales solamente.
Después se extraen y se genera un make bed donde queda en `chilean_all48_hg19_7.bim`

##### 2. ¿Cuántos SNPs se encontraban en cromosomas sexuales?

El siguiente comando me permitio generar un archivo con SNPs autosomales solamente. 

```
plink --bfile chilean_all48_hg19_6 --extract snp_1_22.txt --make-bed --out chilean_all48_hg19_7
```

```
574624 variants loaded from .bim file.
48 people (26 males, 19 females) loaded from .fam.


Calculating allele frequencies... done.
557922 variants and 45 people pass filters and QC.
```

Por lo que se concluye que la diferencia corresponde a los cromosomas sexuales **16702 SNPs sexuales**

Tambien puede obtenerlo con el comando:

```
expr $(wc -l < chilean_all48_hg19_6.bim) - $(wc -l < chilean_all48_hg19_7.bim)
16702
```

##### 3. ¿Como calcularía el número de cromosomas que porta cada uno de los alelos para cada SNP?

Se puede producir frecuencias por SNP genera un archivo `.frq`; a partir de esas frecuencias se puede hacer los conteos de cromosomas:

Luego ejecutar el siguiente comando: 

```
plink --bfile chilean_all48_hg19_7 --freq --out chilean_all48_hg19_7_freq
```

### Parte 4: Borrar SNPs por filtro de HWE

##### 1. ¿Cuál es el nombre del archivo con los resultados de la prueba de HWE?

Es `plink.hwe` se genera después de ejecutar el comando: 

```
plink --bfile chilean_all48_hg19_7 \
      --hwe 1e-6 midp \
      --make-bed \
      --out chilean_all48_hg19_8
```

##### 2. ¿Basándose en la distribución de los valores de *p*, le parece el umbral usado razonable o propondría otro valor?

La gran mayoría de los SNPs tienen valores *p* muy cercanos a 0 (0.0 - 0.8) y se distribuyen de forma homogénea , lo que indica fuertes desviaciones del equilibrio de Hardy-Weinberg.

Me parece que el umbral usado (`p < 1e-6`) esta bien, ya queme permite eliminar solo SNPs con desviaciones extremas, probablemente debidas a errores de genotipificación.

Aunque hay que tener en cuenta que si el dataset es pequeño o si se pierden muchos SNPs se puede ver afectado el poder estadístico. En ese caso se pude bajar el  umbral a `1e-5` o incluso `1e-4`. 

### Parte 5: Eliminar parentescos desconocidos

##### 1. ¿Cuántos SNPs en aparente equilibrio de ligamiento se encontraron?

Se realiza el filtro con el siguiente comando:

```
plink --bfile chilean_all48_hg19_9 --exclude $T/inversion.txt --range --indep-pairwise 50 5 0.2 --out indepSNP
```

Me genera: 

```
458097 variants loaded from .bim file.
45 people (26 males, 19 females) loaded from .fam.
45 phenotype values loaded from .fam.
--exclude range: 7915 variants excluded.
--exclude range: 450182 variants remaining.

Pruning complete.  346968 of 450182 variants removed.
Marker lists written to indepSNP.prune.in and indepSNP.prune.out 
```

De los 450182 SNPs fueron removidos 346968, lo que me da un total de **103214 SNPs que se encuentran en equilibrio de ligamiento**. Se encuentran listados en `indepSNP.prune.in`

```
wc -l indepSNP.prune.in
103214 indepSNP.prune.in
```

##### 2. ¿Cuántos SNPs se eliminaron por estar en regiones de inversiones conocidas?

con el comando `--exclude $T/inversion.txt --range`. Quedará registrado en `indepSNP.log`

```
exclude range: 7915 variants excluded.
```

##### 3. ¿Cuántos individuos quedaron luego del filtro de parentesco?

**42 individuos** quedaron luego del filtro de parentesco

Con el comando: 

```
plink --bfile chilean_all48_hg19_9 --extract indepSNP.prune.in --genome --min 0.2 --out pihat_min0.2
```

Contamos los individuos que quedaron luego del filtro

```
wc -l chilean_all48_hg19_10.fam
42 chilean_all48_hg19_10.fam
```

##### 4. ¿Cuál fue el mayor coeficiente de parentesco efectivamente aceptado?

Para esto se debe identificar el mayor coeficiente de parentesco **(PI_HAT)** 

Con el comando 

```
plink -bfile chilean_all48_hg19_9 -remove to_romeve_by_relatedness.txt -make-bed --out chilean_all48_hg19_10
```

Los valores típicos de PI_HAT son:
1.00 = Duplicado / gemelo
0.50 = Padre-hijo o hermanos
0.25 = Medio hermano / tío-sobrino
0.125 = Primo
<0.05 = No relacionados

Los valores obtenidos fueron:

```
awk 'NR>1 && $10<0.2 {if($10>m)m=$10} END{print m+0}' pihat_all.genome
0.1996
```

#### ### PARTE 2: Unir datos locales con 1000G

Elimine variantes duplicadas del set ChileGenomico y Extraiga las variantes presentes en los datos de ChileGenomico.

```shell
plink --bfile chilean_all48_hg19_10 --list-duplicate-vars suppress-first
plink --bfile chilean_all48_hg19_10 --exclude plink.dupvar --make-bed --out chilean_all48_hg19_11
```

```shell
cut -f 2 chilean_all48_hg19_11.bim | sort -u > chilean_all48_hg19_11.snps
```

*** Nota:*** usamos un pipe para order la lista de snps dado que es un requisito para el siguiente comando.

Extraiga las variantes presentes en los datos de 1000G.

```shell
cut -f 2 $G/1kG_MDS5.bim | sort -u  > 1kG_MDS5.snps
```

***Nota:*** Usamos `$G` para buscar el set `1kG_MFS5.bim` en su carpeta en vez de copiarla al directorio de trabajo.

Encuentre la lista de SNPs en común entre ambos sets de datos.

```shell
comm -12 chilean_all48_hg19_11.snps 1kG_MDS5.snps > common_snps.txt
```

Extraiga los SNPs en común del set 1000G

```shell
plink --bfile $G/1kG_MDS5 --extract common_snps.txt --recode --make-bed --out 1kG_MDS6
```

Extraiga los SNPs en común del set ChileGenomico

```shell
plink --bfile chilean_all48_hg19_11 --extract common_snps.txt --make-bed --out chilean_all48_hg19_12
```

Los conjuntos de datos ahora contienen exactamente las mismas variantes.

### Paso 2: Homologar la versión del genoma

Los conjuntos de datos deben tener la misma versión de ensamble del genoma para usar las mismas coordenadas de SNPs. Para asegurarnos, cambiaremos las coordenadas en los datos de 1000 genomas usando las coordenadas de ChileGenomico.

```shell
awk '{print $2, $4}' chilean_all48_hg19_12.bim> buildhapmap.txt
```

buildhapmap.txt contiene un ID y una posición física por SNP en cada línea.

```
plink --bfile 1kG_MDS6 --update-map buildhapmap.txt --make-bed --out 1kG_MDS7
```

chilean_all48_hg19_12 y 1kG_MDS7 ahora tienen las mismas coordenadas.

### Paso 3: Fusionar los conjuntos de datos HapMap y 1000 Genomes

Antes de fusionar los datos de ChileGenomico con los datos de HapMap, queremos asegurarnos de que los archivos puedan fusionarse, para ello realizamos 3 pasos:

1. Asegurarse de que el genoma de referencia sea igual en ambos conjuntos de datos 1kG y ChileGenomico (que usen el mismo alelo A1 de referencia en el archivo bim).
2. Resolver problemas de hebra.
3. Eliminar los SNP que, después de los dos pasos anteriores, todavía difieren entre los conjuntos de datos.

Los siguientes pasos pueden ser bastante técnicos en términos de comandos, pero solo comparamos los dos conjuntos de datos y nos aseguramos de que correspondan.

1. establecer el genoma de referencia en ChileGenomico usando 1000G:

```shell
awk '{print $2, $5}' 1kG_MDS7.bim> 1kG_ref-list.txt
plink --bfile chilean_all48_hg19_12 --reference-allele 1kG_ref-list.txt --make-bed --out chilean_all48_hg19_13
```

Los conjuntos de datos 1kG y chilean_all48_hg19_13 tienen el mismo genoma (alelo) de referencia para todos los SNP.

Este comando podría generar algunas advertencias para la asignación imposible del alelo A1. Es bueno revisar:

```shell
grep "Impossible" chilean_all48_hg19_13.log | wc -l
```

2. Resolver problemas de hebra. Compruebe si hay posibles problemas de filamento.

```shell
awk '{print $2, $5, $6}' 1kG_MDS7.bim> 1kG_MDS7_tmp
awk '{print $2, $5, $6}' chilean_all48_hg19_13.bim > chilean_all48_hg19_13_tmp
sort 1kG_MDS7_tmp chilean_all48_hg19_13_tmp | uniq -u > all_differences.txt
wc -l all_differences.txt0 all_differences.txt
```

En este caso hay 0 diferencias entre los archivos. Si las hubiera, podrían deberse a problemas cambio de hebra entre conjuntos de datos.

### Paso 4: Intercambiar alelos de SNPs con potenciales problemas de hebra

Este paso no tendrá efecto alguno sobre los datos porque no hay SNPs con problemas de hebra. Sin embargo, los incluimos en nuestro flujo de trabajo ya que pueden tener efecto en un conjunto de datos distinto.

Imprima el identificador SNP y elimine los duplicados.

```shell
awk '{print $ 1}' all_differences.txt | sort -u > flip_list.txt
```

Se genera un archivo de SNPs no coincidentes entre los dos archivos.

Intercambiar los alelos de los SNPs no coincidentes.

```shell
plink --bfile chilean_all48_hg19_13 --flip flip_list.txt --reference-allele 1kG_ref-list.txt --make-bed --out chilean_all48_hg19_14
```

Compruebe si hay SNPs que siguen siendo problemáticos después de haberlos volteado.

```shell
awk '{print $2, $5, $6}' chilean_all48_hg19_14.bim > chilean_all48_hg19_14_tmp
sort 1kG_MDS7_tmp chilean_all48_hg19_14_tmp | uniq -u> uncorresponding_SNPs.txt 
wc -l uncorresponding_SNPs.txt0 uncorresponding_SNPs.txt
```

Este archivo demuestra que hay 0 diferencias entre los archivos, o sea, no hay SNPs con alelos discordantes entre conjuntos de datos.

3. Eliminar SNPs problemáticos de 1kG y ChileGenomico. En este caso, este paso es innecesario ya que no quedan SNPs con problemas, pero se muestran por completitud.

```shell
awk '{print $ 1}' uncorresponding_SNPs.txt | sort -u > SNPs_for_exlusion.txt
```

El comando anterior genera una lista de los 0 SNP que causaron las 0 diferencias entre los conjuntos de datos 1kG y ChileGenomico después de cambiar y configurar el genoma de referencia.

Elimine los SNPs problemáticos de ambos conjuntos de datos.

```shell
plink --bfile 1kG_MDS7 --exclude SNPs_for_exlusion.txt --make-bed --out 1kG_MDS8
plink --bfile chilean_all48_hg19_14 --exclude SNPs_for_exlusion.txt --make-bed --out chilean_all48_hg19_15
```

### Paso 5: Combinar 1000G con ChileGenomico.

```shell
plink --bfile 1kG_MDS8 --bmerge chilean_all48_hg19_15.bed chilean_all48_hg19_15.bim chilean_all48_hg19_15.fam --allow-no-sex --make-bed --out MDS_merge
```

## Parte 3: Análisis de estructura poblacional

### Paso 1: Realizar MDS en datos HapMap-ChileGenomico

Se asume que los SNPs no están ligados. Por lo tanto usaremos un conjunto de SNPs con bajo LD

```shell
plink --bfile MDS_merge --extract indepSNP.prune.in --genome --out MDS_merge2
plink --bfile MDS_merge --read-genome MDS_merge2.genome --cluster --mds-plot 10 --out MDS_merge2
```

*** Nota***: esto no reduce el tamaño del conjunto de datos MDS_merge2, solo crea el archivo `MDS_merge2.genome` para el set reducido de SNPs con bajo LD.

### Paso 2: Generar un archivo con información de poblaciones

El archivo `$G/20100804.ALL.panel` (obtenido desde aquí) contiene códigos de población de los individuos de 1000 genomas .

Convierta los códigos de población en códigos de superpoblación (es decir, AFR, AMR, ASN y EUR).

```shell
awk '{print$1,$1,$2}' $G/20100804.ALL.panel > ethnicity_1kG.txt
sed 's/JPT/ASN/g' ethnicity_1kG.txt>ethnicity_1kG2.txt
sed 's/ASW/AFR/g' ethnicity_1kG2.txt>ethnicity_1kG3.txt
sed 's/CEU/EUR/g' ethnicity_1kG3.txt>ethnicity_1kG4.txt
sed 's/CHB/ASN/g' ethnicity_1kG4.txt>ethnicity_1kG5.txt
sed 's/CHD/ASN/g' ethnicity_1kG5.txt>ethnicity_1kG6.txt
sed 's/YRI/AFR/g' ethnicity_1kG6.txt>ethnicity_1kG7.txt
sed 's/LWK/AFR/g' ethnicity_1kG7.txt>ethnicity_1kG8.txt
sed 's/TSI/EUR/g' ethnicity_1kG8.txt>ethnicity_1kG9.txt
sed 's/MXL/AMR/g' ethnicity_1kG9.txt>ethnicity_1kG10.txt
sed 's/GBR/EUR/g' ethnicity_1kG10.txt>ethnicity_1kG11.txt
sed 's/FIN/EUR/g' ethnicity_1kG11.txt>ethnicity_1kG12.txt
sed 's/CHS/ASN/g' ethnicity_1kG12.txt>ethnicity_1kG13.txt
sed 's/PUR/AMR/g' ethnicity_1kG13.txt>ethnicity_1kG14.txt
```

Crea un archivo de etnicidad de los datos de ChileGenomico.

```shell
awk '{if($1~/CDSJ/) pop="MAP"}{if($1~/ARI/) pop="AYM"} {print $1, $2, pop}' chilean_all48_hg19_14.fam > ethnicityfile_CLG.txt
```

Concatenar los archivos de carrera.

```shell
cat ethnicity_1kG14.txt ethnicityfile_CLG.txt | sed -e '1i \ FID IID ethnicity'> ethnicityfile.txt
```

### Paso 3: Graficar resultados de MDS

En R con el siguiente scrip

```
# ===================================================================
# Script: MDS_plot.R
# Genera gráficos MDS (C2 vs C3) y (C3 vs C4)
# ===================================================================

# Cargar librerías necesarias
if(!require(ggplot2)) install.packages("ggplot2", repos="https://cloud.r-project.org")

# Leer archivo MDS (ajusta el nombre si es distinto)
mds <- read.table("MDS_merge2.mds", header = TRUE)
eth <- read.table("ethnicityfile.txt", header = TRUE)

# Unir ambos por el identificador
data <- merge(mds, eth, by = "IID")

# Asegurar que 'ethnicity' sea un factor (para colores consistentes)
data$ethnicity <- as.factor(data$ethnicity)

# Definir paleta de colores (para mantener los mismos tonos del gráfico ejemplo)
colores <- c("EUR"="blue", "ASN"="goldenrod", "AMR"="brown3",
             "AFR"="green3", "AYM"="orange", "MAP"="darkgreen")

# ==============================
# Gráfico 1: Componentes 2 vs 3
# ==============================
png("MDS_Comp2_vs_Comp3.png", width=1000, height=800)
ggplot(data, aes(x=C2, y=C3, color=ethnicity, shape=ethnicity)) +
  geom_point(size=3, alpha=0.8) +
  scale_color_manual(values = colores) +
  theme_bw() +
  labs(title="MDS Components 2 vs 3",
       x="MDS Component 2",
       y="MDS Component 3") +
  theme(legend.title = element_blank(),
        plot.title = element_text(hjust=0.5, face="bold", size=16))
dev.off()

# ==============================
# Gráfico 2: Componentes 3 vs 4
# ==============================
png("MDS_Comp3_vs_Comp4.png", width=1000, height=800)
ggplot(data, aes(x=C3, y=C4, color=ethnicity, shape=ethnicity)) +
  geom_point(size=3, alpha=0.8) +
  scale_color_manual(values = colores) +
  theme_bw() +
  labs(title="MDS Components 3 vs 4",
       x="MDS Component 3",
       y="MDS Component 4") +
  theme(legend.title = element_blank(),
        plot.title = element_text(hjust=0.5, face="bold", size=16))
dev.off()

cat("✅ Gráficos guardados como MDS_Comp2_vs_Comp3.png y MDS_Comp3_vs_Comp4.png\n")
```

[[Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/fig/MDS_Comp2_vs_Comp3.png at main · maluflorezg/Tareas_BioinfRepro2025_MLFG · GitHub](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad2/Sesion2/fig/MDS_Comp2_vs_Comp3.png#:~:text=Sesion2/fig-,MDS_Comp2_vs_Comp3,-.png)]

![MDS_Comp2_vs_Comp3.png](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad2/Sesion2/fig/MDS_Comp2_vs_Comp3.png?raw=true)

**Interpretación**

- **En C2:** Se separa principalmente poblaciones asiáticas (ASN) de europeas (EUR).

- **En C3:** Se observa una variación entre poblaciones africanas (AFR) y amerindias (AYM, MAP), mostrando el eje de diferenciación intraamericana.

- Los AMR (american admixed) aparecen en una franja intermedia, lo que es consistente con su composición genética mixta (europea, africana y amerindia).

[[Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion2/fig/MDS_Comp3_vs_Comp4.png at main · maluflorezg/Tareas_BioinfRepro2025_MLFG · GitHub](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad2/Sesion2/fig/MDS_Comp3_vs_Comp4.png#:~:text=MDS_Comp2_vs_Comp3.png-,MDS_Comp3_vs_Comp4,-.png)]

![MDS_Comp3_vs_Comp4.png](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Unidad2/Sesion2/fig/MDS_Comp3_vs_Comp4.png?raw=true)

**Interpretación**

- **En C3:** Se observa la separación del linaje africano con respecto a los amerindios.

- **En C4:** Se observan diferencias más sutiles entre grupos dentro del continente americano (por ejemplo, AYM vs MAP).

- Se observa una verticalidad diferenciada entre ASN y EUR indica poca mezcla entre ellos y estabilidad interna.

### Paso 4: Realizar un análisis de ancestría

Utilizaremos la herramienta [ADMIXTURE](http://software.genetics.ucla.edu/admixture/) para inferir ancestría de las muestras chilenas asumiendo un modelo simple de mezcla.

Admixture asumen que los SNPs a usar no están en LD. Tendremos que usar nuevamente nuestro archivo con SNPs en bajo LD, pero esta vez sí crearemos un set plink de datos reducidos

```shell
plink --bfile MDS_merge --extract indepSNP.prune.in --make-bed --out MDS_merge_r2_lt_0.2
```

1. ¿Cuántos SNPs quedaron luego del filtro?
   
   ```
   plink --bfile MDS_merge --extract indepSNP.prune.in --make-bed --out MDS_merge_r2_lt_0.2
   ```
   
   70534 variantes y  671 personas pasaron el filtro

2. ADMIXTURE asume que los individuos no están emparentados. Sin embargo, no realizamos ningún filtro. ¿Por qué?
   
   Puede deberse a varias razones:
   
   1. Se está explorando la estructura de ancestría dentro de la población chile. Si se eliminan individuos emparentados se puede perdes parte de la variabilidad.
   
   2. En total hay 671 personas y si se eliminan parientes el tamaño se reduce mucho mas. 
   
   3. El ADMIXTURE mantiene el conjunto de datos sin filtrar ya que asume independencia entre los individuos. El algoritmo de máxima verosimilitud es robusto a pequeñas dependencias debidas a parentesco, siempre que los datos estén en bajo LD y no contengan duplicados o gemelos.
