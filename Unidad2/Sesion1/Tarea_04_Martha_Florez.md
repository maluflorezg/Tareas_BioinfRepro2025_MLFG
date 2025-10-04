### TAREA 4

## VCF , "Variant Call Format" [Ref](http://samtools.github.io/hts-specs/VCFv4.2.pdf)

Formato para representar una posición en el genoma (posiblemente con variantes) y su información asociada. También puede contener información de genotipos de varias muestras para cada posición.

Programa asociado: [VCFtools](https://vcftools.github.io/index.html) y [BCFtools](https://github.com/samtools/bcftools)

**Ejercicios**

Consulta el [manual de VCFtools](https://vcftools.github.io/man_latest.html) y escribe un script que responda lo siguiente para el archivo `GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf`  **sin copiarlo a su directorio**:

1. ¿Cuántos individuos y variantes (SNPs) tiene el archivo?
   
   Resutado: **18 individuos y 4450483 variantes**
   
   `grep "^#CHROM"` selecciona la línea con los nombres de las columnas.
   
   `awk '{print NF-9}'` resta las 9 primeras columnas (`#CHROM` hasta `FORMAT`) y te deja solo el número de individuos.
   
   ```
   # Para calcular los individus
   grep "^#CHROM" /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf | awk '{print NF-9}'
   18
   
   # Para calcular las variantes
   $ grep -v "^#" /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf | wc -l
   4450360
   $ grep -c -v "^#" /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   4450360
   $ zcat /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz | grep -v -c "^#"
   4450360 
   ```

2. ¿Cuántos sitios del archivo no tienen datos perdidos?
   
   El número de sitios del archivo sin datos perdidos es **382.626**.
   
   El filtro `--max-missing 1.0`: elimina cualquier variante con datos faltantes
   
   El archivo `missing_site.log` guarda esta misma información.  
   Se puede verificar con: `cat results/missing_site.log`

```
# Sitios sin datos perdidos
$ vcftools --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz --max-missing 1.0 --out results/missing_site

Parameters as interpreted:
    --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz
    --max-missing 1
    --out results/missing_site

After filtering, kept 18 out of 18 Individuals
After filtering, kept 382626 out of a possible 4450360 Sites
Run Time = 32.00 seconds
```

3. Genera un archivo en tu carpeta de trabajo `Prac_Uni5/data` que contenga solo SNPs en una ventana de 2Mb en cualquier cromosoma. Nombra el archivo`CLG_Chr2_2_4Mb.vcf` donde es número del cromosoma, es el inicio de la ventana genómica y es el final en megabases.
   
   ```
   **Prac_Uni5/data**
   CLG_Chr2_2_4Mb.log CLG_Chr2_2_4Mb.recode.vcf
   ```
   
   **Parametros generados:**
   
   `--from-bp 2000000`: Posición inicial de la ventana (2 Mb)
   
   `--from-bp 2000000`: Posición final de la ventana (4 Mb)
   
   `--recode`: Crea un nuevo archivo `.vcf` con los SNPs seleccionados.
   
   `--out CLG_Chr2_2_4Mb`: Nombre base del archivo de salida.
   
   ```
   $ vcftools   --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz   --chr 2   --from-bp 2000000   --to-bp 4000000   --recode   --out CLG_Chr2_2_4Mb
   
   After filtering, kept 18 out of 18 Individuals
   Outputting VCF file...
   After filtering, kept 3559 out of a possible 4450360 Sites
   ```

4. Reporta cuántas variantes tienen el archivo generado
   
   El archivo VCF tiene encabezados que comienzan con `#`. Cada línea que **no empieza con `#`** corresponde a una variante (SNP, indel, etc.).
   
   `grep -v "^#" `: Muestra solo las líneas que **no** comienzan con `#` (descarta los encabezados).
   
   `wc -l`: Cuenta cuántas variantes hay
   
   Respuesta: El archivo `CLG_Chr2_2_4Mb.vcf` contiene **3559 variantes** en esa ventana de 2 Mb
   
   ```
   $ grep -v "^#" CLG_Chr2_2_4_Mb.vcf.recode.vcf | wc -l
   ```
   
   Otra forma: 

5. Reporta la cobertura promedio para todos los individuos del set de datos.
   
   ```
   vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --depth --out cobertura
   ```
   
   `--depth`: Genera un archivo `cobertura.idepth`, que es la profundidad promedio **por individuo**
   
   ```
   awk 'NR>1 {sum+=$3; n++} END {print "Cobertura promedio total:", sum/n}' cobertura.idepth
   Cobertura promedio total: 2.49411
   ```
   
   **Cobertura Total Promedio: 2.49X**

6. Calcula la frecuencia de cada alelo para todos los individuos dentro del archivo y guarda el resultado en un archivo
   
   ```
   $ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --freq --out frecuencias
   ```
   
   Este comando genera dos archivos de salida:
   
   `frecuencias.frq` : Contiene la frecuencia de cada alelo por variante
   
   `frecuencias.log`: Guarda el registro del proceso.
   
   Para ver el contenido de`frecuencias.frq` 
   
   ```
   head frecuencias.frq
   
   CHROM    POS    N_ALLELES    N_CHR    {ALLELE:FREQ}
   2    2002630    2    32    C:0.84375    A:0.15625
   2    2004564    2    32    A:0.65625    G:0.34375
   2    2006687    2    18    C:0.277778    T:0.722222
   2    2006872    2    32    G:0.875    A:0.125
   2    2007320    2    28    G:0.392857    T:0.607143
   ```
   
   **CHR** : Cromosoma
   **POS**: Posición
   **N_ALLELES**: Número de alelos observados (normalmente 2 si es bialélico)
   **N_CHR**: Número de cromosomas muestreados (2 × número de individuos diploides)
   **{ALLELE:FREQ}**: Frecuencia de cada alelo

7. Filtra el archivo de frecuencias para solo incluir variantes bialélicas (tip: awk puede ser útil para realizar esta tarea, tip2: puedes usar bcftools para filtrar variantes con más de dos alelos antes de calcular las frecuencias).
   
   ```
   awk 'NR==1 || ($3 != "." && $4 != ".")' frecuencias.frq > frecuencias_bialelicas.frq
   ```
   
   `NR==1`: Mantiene la **primera línea** del archivo (`#CHROM POS N_ALLELES ...`)
   
   `($3 != "." && $4 != ".")`: Mantiene solo las filas donde **ambos alelos existen**, o sea, **variantes bialélicas**.
   
   `>`: Redirige la salida a un nuevo archivo de salida: `frecuencias_bialelicas.frq`.
   
   ```
   $ head -n 5 frecuencias_bialelicas.frq
   CHROM    POS    N_ALLELES    N_CHR    {ALLELE:FREQ}
   2    2002630    2    32    C:0.84375    A:0.15625
   2    2004564    2    32    A:0.65625    G:0.34375
   2    2006687    2    18    C:0.277778    T:0.722222
   2    2006872    2    32    G:0.875    A:0.125
   ```
   
   Puedo Revisar cuantas variantes bialélicas quedaron con:
   
   ```
   $ wc -l frecuencias_bialelicas.frq
   3560 frecuencias_bialelicas.frq
   ```
   
   Quedaron **3560 frecuencias_bialelicas.frq**

8. Llama a un script escrito en lenguaje R que lee el archivo de frecuencias de variantes bialélicas y guarda un histograma con el espectro de MAF para las variantes bialélicas
   
   ```
   # script_R_ejercicio8.R
   # ----------------------------------------
   # Calcula el espectro de frecuencias alélicas menores (MAF)
   # y genera un histograma
   
   # Entrada y salida
   infile <- "/home/bioinfo1/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion1/Prac_Uni5/results/frecuencias_bialelicas.frq"
   out_tsv <- "/home/bioinfo1/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion1/Prac_Uni5/results/maf_values.tsv"
   out_png <- "/home/bioinfo1/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Sesion1/Prac_Uni5/results/maf_histogram.png"
   
   # Leer archivo de frecuencias de manera segura
   freq_raw <- readLines(infile)
   header <- strsplit(freq_raw[1], "\t")[[1]]
   freq_split <- strsplit(freq_raw[-1], "\t| ")
   freq_matrix <- do.call(rbind, lapply(freq_split, function(x) x[x != ""]))  # elimina vacíos
   freq <- as.data.frame(freq_matrix, stringsAsFactors = FALSE)
   colnames(freq) <- header
   
   # Extraer frecuencias numéricas desde la columna {ALLELE:FREQ}
   freq_values <- sapply(strsplit(freq$`{ALLELE:FREQ}`, " "), function(x) {
     freqs <- as.numeric(sub(".*:", "", x))
     return(min(freqs, na.rm = TRUE))
   })
   
   # Crear tabla con MAF
   maf_table <- data.frame(CHROM = freq$CHROM, POS = freq$POS, MAF = freq_values)
   
   # Guardar archivo TSV con los valores de MAF
   write.table(maf_table, file = out_tsv, sep = "\t", quote = FALSE, row.names = FALSE)
   
   # Graficar histograma
   png(out_png, width = 800, height = 600)
   hist(maf_table$MAF, breaks = 40, col = "skyblue", border = "white",
        main = "Distribución de frecuencias alélicas menores (MAF)",
        xlab = "Frecuencia alélica menor (MAF)",
        ylab = "Número de variantes")
   dev.off()
   
   cat("Histograma guardado en:", out_png, "\n")
   cat("Archivo con valores de MAF guardado en:", out_tsv, "\n")
   ```
   
   Se generan dos archivos: 
   
   `maf_values.tsv`y `maf_histogram.png`
   
   ! [Texto alternativo] (/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/imagenes/maf_histogram.png)
   
   ![Texto alternativo] (![loading-ag-2036](/Users/macbookair/Tareas_BioinfRepro2025_MLFG/Unidad2/imagenes/maf_histogram.png)

9. ¿Cuántos sitios tienen una frecuencia del alelo menor <0.05?
   
   **`--maf 0.05`** : Le pide a VCFtools que **mantenga solo los sitios donde la frecuencia alélica menor (MAF)** sea **mayor o igual a 0.05**.  
   Es decir, elimina los SNPs raros (los que tienen alelos con frecuencia < 0.05).
   
   ```
   $ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --maf 0.05 --out maf_filter
   
   After filtering, kept 18 out of 18 Individuals
   After filtering, kept 2978 out of a possible 3559 Sites
   Run Time = 0.00 seconds
   ```
   
   Antes del filtro, el archivo tenía **3559 sitios (SNPs)**.  
   Después del filtro (`MAF ≥ 0.05`), quedaron **2978 sitios**.
   
   Por lo tanto: **Sitios con frecuencia alélica menor a 0.05:**
   
   `3559 - 2978 = 581` 
   
   **Hay 581 sitios con una frecuencia del alelo menor a 0.05.**
   
   Otra forma: 
   
   ```
   $ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --max-maf 0.05 --out maf_low
   Parameters as interpreted:
       --vcf CLG_Chr2_2_4_Mb.recode.vcf
       --max-maf 0.05
       --out maf_low
   
   After filtering, kept 18 out of 18 Individuals
   After filtering, kept 581 out of a possible 3559 Sites
   Run Time = 0.00 seconds
   ```
   
   **Hay 581 sitios con una frecuencia del alelo menor a 0.05**

10. Calcula la heterocigosidad de cada individuo.
    
    ```
    $ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --het --out heterocigosidad
    
    Parameters as interpreted:
        --vcf CLG_Chr2_2_4_Mb.recode.vcf
        --het
        --out heterocigosidad
    
    Estructura del archivo:
    INDV    O(HOM)    E(HOM)    N_SITES    F
    ARI-008    2543    1873.2    2823    0.70520
    ARI-014    2074    1847.4    2790    0.24043
    ARI-1    2291    1916.0    2892    0.38423
    ARI-15    2381    1906.4    2878    0.48847
    ARI-9    2505    2009.8    3041    0.48020
    ARI_018    1977    1946.9    2936    0.03044
    ```

    ```
    
    **INDV:** Nombre o ID del individuo
    **O(HOM):** Número de sitios homocigotos observados
    **E(HOM):** Número de sitios homocigotos esperados (bajo equilibrio Hardy-Weinberg)
    **N_SITES:** Número total de sitios considerados
    **F:** Coeficiente de endogamia (F = 1 − (Hobs / Hexp))
    
    
    
    Para ver el resultado de heterocigosidad
    
    ```
    awk 'NR>1 {Hobs = 1 - ($2 / $4); Hexp = 1 - ($3 / $4); print $1, Hobs, Hexp, $5}' heterocigosidad.het > heterocigosidad_resumen.txt
    
    
    column -t heterocigosidad_resumen.txt | head
    ARI-008       0.0991853  0.336451  0.70520
    ARI-014       0.256631   0.337849  0.24043
    ARI-1         0.207815   0.337483  0.38423
    ARI-15        0.172689   0.337596  0.48847
    ARI-9         0.176258   0.339099  0.48020
    ARI_018       0.326635   0.336887  0.03044
    Ari_006       0.158705   0.335097  0.52638
    Ari_021       0.151088   0.337591  0.55248
    Ari_023       0.134806   0.335034  0.59763
    CD5J-106      0.128492   0.334198  0.61554
    ```

11. Calcula la diversidad nucleotídica por sitio.
    
    La **diversidad nucleotídica (π)** mide la cantidad promedio de diferencias por sitio entre dos secuencias elegidas al azar de una población.  
    En otras palabras, indica **cuán variable** es la población a nivel de nucleótidos.
    
    ```
    $ vcftools --vcf results/CLG_Chr2_2_4_Mb.vcf.recode.vcf --site-pi --out results/nucleotide_diversity
    Parameters as interpreted:
        --vcf results/CLG_Chr2_2_4_Mb.vcf.recode.vcf
        --out results/nucleotide_diversity
        --site-pi
    ```
    
    `--vcf CLG_Chr2_2_4_Mb.recode.vcf` → usa tu archivo VCF filtrado.
    
    `--site-pi` → calcula π para cada sitio.
    
    `--out diversity` → genera los archivos `nucleotide_diversity.sites.pi` y `nucleotide_diversity.log`.
    
    ```
    $ head -n 5 nucleotide_diversity.sites.pi
    CHROM    POS    PI
    2    2002630    0.272177
    2    2004564    0.465726
    2    2006687    0.424837
    2    2006872    0.225806
    ```

12. Filtra los sitios que tengan una frecuencia del alelo menor <0.05
    
    ```
    vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --maf 0.05 --recode --recode-INFO-all --out maf_low
    
    Parameters as interpreted:
        --vcf CLG_Chr2_2_4_Mb.recode.vcf
        --recode-INFO-all
        --maf 0.05
        --out maf_low
        --recode
    ```
    
    Esto genera dos archivos: 
    Nuevo archivo filtrado: `maf_low.recode.vcf` 
    log con información del proceso: `maf_low.log`
    
    ```
    vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --max-maf 0.05 --recode --recode-INFO-all --out maf_menor_005
    ```
    
    Crea el archivo `maf_menor_005.recode.vcf` con **solo los sitios que tienen frecuencia menor a 0.05**.

13. Convierte el archivo `wolves_maf05.vcf` a formato plink.
    
    ```
    plink --vcf maf_menor_005.recode.vcf --make-bed --double-id --out maf_menor_005
    ```

Esto genera 3 archivos:

`maf_menor_005.bed`, `maf_menor_005.bim`y `maf_menor_005.fam`
