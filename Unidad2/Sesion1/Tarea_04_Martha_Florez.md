### TAREA 4

## VCF , "Variant Call Format" [Ref](http://samtools.github.io/hts-specs/VCFv4.2.pdf)

Formato para representar una posición en el genoma (posiblemente con variantes) y su información asociada. También puede contener información de genotipos de varias muestras para cada posición.

Programa asociado: [VCFtools](https://vcftools.github.io/index.html) y [BCFtools](https://github.com/samtools/bcftools)

**Ejercicios**

Consulta el [manual de VCFtools](https://vcftools.github.io/man_latest.html) y escribe un script que responda lo siguiente para el archivo `GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf`  **sin copiarlo a su directorio**:

1. ¿Cuántos individuos y variantes (SNPs) tiene el archivo?
   
   **4450360 y 120160424**
   
   ```
   bioinfo1@genoma:~/mflorez/Unidad2$ wc -l /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   4450483 /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   
   bioinfo1@genoma:~/mflorez/Unidad2$ wc -w /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   120160424 /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   ```
   
   ```
   bioinfo1@genoma:~/mflorez/Prac_Uni5$ grep -v "^#" /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf | wc -l
   4450360
   bioinfo1@genoma:~/mflorez/Prac_Uni5$ grep -c -v "^#" /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf
   4450360
   bioinfo1@genoma:~/mflorez/Prac_Uni5$ zcat /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz | grep -v -c "^#"
   4450360 
   ```

2. ¿Cuántos sitios del archivo no tienen datos perdidos?

```
bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Tareas_BioinfinvRepro/Unidad2/Prac_Uni5/code$ vcftools --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz --max-missing 1.0 --out results/missing_site

VCFtools - 0.1.18
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
    --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz
    --max-missing 1
    --out results/missing_site
Using zlib version: 1.2.7
Warning: Expected at least 2 parts in FORMAT entry: ID=PL,Number=G,Type=Integer,Description="Normalized, Phred-scaled likelihoods for genotypes as defined in the VCF specification">
Warning: Expected at least 2 parts in INFO entry: ID=AC,Number=A,Type=Integer,Description="Allele count in genotypes, for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=AC,Number=A,Type=Integer,Description="Allele count in genotypes, for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=AF,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=AF,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=MLEAC,Number=A,Type=Integer,Description="Maximum likelihood expectation (MLE) for the allele counts (not necessarily the same as the AC), for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=MLEAC,Number=A,Type=Integer,Description="Maximum likelihood expectation (MLE) for the allele counts (not necessarily the same as the AC), for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=MLEAF,Number=A,Type=Float,Description="Maximum likelihood expectation (MLE) for the allele frequency (not necessarily the same as the AF), for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=MLEAF,Number=A,Type=Float,Description="Maximum likelihood expectation (MLE) for the allele frequency (not necessarily the same as the AF), for each ALT allele, in the same order as listed">
Warning: Expected at least 2 parts in INFO entry: ID=culprit,Number=1,Type=String,Description="The annotation which was the worst performing in the Gaussian mixture model, likely the reason why the variant was filtered out">
After filtering, kept 18 out of 18 Individuals
After filtering, kept 382626 out of a possible 4450360 Sites
Run Time = 32.00 seconds
```

3. Genera un archivo en tu carpeta de trabajo `Prac_Uni5/data` que contenga solo SNPs en una ventana de 2Mb en cualquier cromosoma. Nombra el archivo`CLG_Chr<X>_<Start>-<End>Mb.vcf` donde es número del cromosoma, es el inicio de la ventana genómica y es el final en megabases.
   
   ```
   vcftools --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz --chr 2 --from-bp 2000000 --to-bp 4000000 --recode --recode-INFO-all --out results/CLG_Chr2_2_4Mb.vcf.gz
   ```

4. Reporta cuántas variantes tienen el archivo generado
   
   El archivo VCF tiene encabezados que comienzan con `#`. Cada línea que **no empieza con `#`** corresponde a una variante (SNP, indel, etc.).
   
   Para contar utilizo `grep -v "^#" ... | wc -l`
   
   Respuesta: 3559
   
   ```
   grep -v "^#" CLG_Chr2_2_4_Mb.vcf.recode.vcf | wc -l
   ```
   
   Otra forma: 
   
   Ese comando **extrae todas las variantes** del cromosoma 1, entre las posiciones **2,000,000 y 4,000,000 pb**, de tu VCF original y las guarda en un nuevo archivo comprimido `CLG_Chr2_2_4_Mb.vcf.gz`.
   
   ```
   vcftools --vcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz --chr 2 --from-bp 2000000 --to-bp 4000000 --recode -c | bgzip -c > CLG_Chr2_2_4_Mb.vcf.gz
   vcftools --vcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf   --chr 2   --from-bp 2000000   --to-bp 4000000   --recode   --out CLG_Chr2_2_4_Mb
   After filtering, kept 18 out of 18 Individuals
   Outputting VCF file...
   After filtering, kept 3559 out of a possible 4450360 Sites
   Run Time = 7.00 seconds
   ```

5. Reporta la cobertura promedio para todos los individuos del set de datos
   
   Esto crea `cobertura.ldepth.mean` con la **profundidad promedio en cada variante** (columna MEAN_DEPTH).
   
   ```
   vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --depth --out cobertura
   After filtering, kept 18 out of 18 Individuals
   Outputting Mean Depth by Individual
   After filtering, kept 3559 out of a possible 3559 Sites
   Run Time = 0.00 seconds
   ```

6. Calcula la frecuencia de cada alelo para todos los individuos dentro del archivo y guarda el resultado en un archivo
   
   `frecuencias.frq` con formato como este
   
   ```
   bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Prac_Uni5/results$ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --freq --out frecuencias
   
   VCFtools - 0.1.18
   (C) Adam Auton and Anthony Marcketta 2009
   
   Parameters as interpreted:
       --vcf CLG_Chr2_2_4_Mb.recode.vcf
       --freq
       --out frecuencias
   After filtering, kept 18 out of 18 Individuals
   Outputting Frequency Statistics...
   After filtering, kept 3559 out of a possible 3559 Sites
   Run Time = 0.00 seconds
   ```

7. Filtra el archivo de frecuencias para solo incluir variantes bialélicas (tip: awk puede ser útil para realizar esta tarea, tip2: puedes usar bcftools para filtrar variantes con más de dos alelos antes de calcular las frecuencias).
   
   - `NR==1` → conserva la cabecera.
   
   - `$3 != "." && $4 != "."` → asegura que existan exactamente **dos alelos** reportados (si hay más, vcftools los lista en filas adicionales con `.`).
   
   ```
   awk 'NR==1 || ($3 != "." && $4 != ".")' frecuencias.frq > frecuencias_bialelicas.frq
   ```

8. Llama a un script escrito en lenguaje R que lee el archivo de frecuencias de variantes bialélicas y guarda un histograma con el espectro de MAF para las variantes bialélicas
   
   ```
   bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Prac_Uni5/results$ head -n 5 frecuencias_bialelicas.frq
   CHROM    POS    N_ALLELES    N_CHR    {ALLELE:FREQ}
   2    2002630    2    32    C:0.84375    A:0.15625
   2    2004564    2    32    A:0.65625    G:0.34375
   2    2006687    2    18    C:0.277778    T:0.722222
   2    2006872    2    32    G:0.875    A:0.125
   ```
   
   ```
   bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Prac_Uni5/code$ cat > ../code/script_R_ejercicio8.R <<'EOF'
   > #!/usr/bin/env Rscript
   > 
   > # Archivos de entrada y salida
   > infile <- "results/frecuencias_bialelicas.frq"
   > out_tsv <- "results/maf_values.tsv"
   > out_png <- "results/maf_histogram.png"
   > 
   > # Cargar librería
   > suppressMessages(library(ggplot2))
   > 
   > # Leer archivo de frecuencias generado con vcftools --freq
   > freq <- read.table(infile, header = TRUE)
   > 
   > # Filtrar variantes bialélicas con MAF válido
   > freq_bial <- subset(freq, MAF > 0 & MAF <= 0.5)
   > 
   > # Guardar los valores de MAF en un TSV
   > write.table(freq_bial$MAF,
   >             out_tsv,
   >             sep = "\t",
   >             row.names = FALSE,
   >             col.names = "MAF",
   >             quote = FALSE)
   > 
   > # Graficar histograma
   > p <- ggplot(freq_bial, aes(x = MAF)) +
   >   geom_histogram(binwidth = 0.05, fill = "steelblue", color = "black", boundary = 0) +
   >   labs(title = "Espectro de frecuencias alélicas menores (MAF)",
   >        x = "Frecuencia alélica menor (MAF)",
   >        y = "Número de variantes") +
   >   theme_minimal(base_size = 14)
   > 
   > ggsave(out_png, plot = p, width = 8, height = 6, dpi = 300)
   > 
   > cat("✅ Script finalizado. Archivos creados:\n")
   > cat(" - Valores de MAF:", out_tsv, "\n")
   > cat(" - Histograma MAF:", out_png, "\n")
   > EOF
   ```
   
   `maf_histogram.png`
   
   ![](/Users/macbookair/Library/Application%20Support/marktext/images/2025-10-03-16-59-17-image.png)

9. ¿Cuántos sitios tienen una frecuencia del alelo menor <0.05?
   
   ```
   bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Prac_Uni5/results$ awk 'NR>1 && $1 < 0.05' maf_values.tsv | wc -l
   580
   ```

10. Calcula la heterocigosidad de cada individuo.
    
    ```
    bioinfo1@genoma:~/mflorez/Tareas_BioinfRepro2025_MLFG/Unidad2/Prac_Uni5/results$ vcftools --vcf CLG_Chr2_2_4_Mb.recode.vcf --het --out heterocigosidad
    
    VCFtools - 0.1.18
    (C) Adam Auton and Anthony Marcketta 2009
    
    Parameters as interpreted:
        --vcf CLG_Chr2_2_4_Mb.recode.vcf
        --het
        --out heterocigosidad
    Outputting Individual Heterozygosity
        Individual Heterozygosity: Only using biallelic SNPs.
    After filtering, kept 3559 out of a possible 3559 Sites
    Run Time = 0.00 seconds
    ARI-008 0.0991853
    ARI-014 0.256631
    ARI-1 0.207815
    ARI-15 0.172689
    ARI-9 0.176258
    ARI_018 0.326635
    Ari_006 0.158705
    Ari_021 0.151088
    Ari_023 0.134806
    CD5J-106 0.128492
    CD5J-108 0.0653319
    CD5J-471 0.0840939
    CDSJ_167 0.133309
    CDSJ_297 0.0926232
    Cdsj_283 0.105032
    L19_CDSJ_321 0.200829
    ```

11. Calcula la diversidad nucleotídica por sitio.
    
    ```
    
    ```

12. Filtra los sitios que tengan una frecuencia del alelo menor <0.05
    
    ```
    
    ```

13. Convierte el archivo `wolves_maf05.vcf` a formato plink.
    
    ```
    
    ```
