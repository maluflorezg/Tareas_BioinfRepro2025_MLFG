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
   vcftools --gzvcf /datos/compartido/ChileGenomico/GATK_ChGdb_recalibrated.autosomes.12262013.snps.known.vcf.gz --chr 2 --from-bp 30000 --to-bp 10000000 --recode --recode-INFO-all --out results/CLG_Chr3_30000_10000000_Mb.vcf
   ```
   
   

4. Reporta cuántas variantes tienen el archivo generado

5. Reporta la cobertura promedio para todos los individuos del set de datos

6. Calcula la frecuencia de cada alelo para todos los individuos dentro del archivo y guarda el resultado en un archivo

7. Filtra el archivo de frecuencias para solo incluir variantes bialélicas (tip: awk puede ser útil para realizar esta tarea, tip2: puedes usar bcftools para filtrar variantes con más de dos alelos antes de calcular las frecuencias)

8. Llama a un script escrito en lenguaje R que lee el archivo de frecuencias de variantes bialélicas y guarda un histograma con el espectro de MAF para las variantes bialélicas

9. ¿Cuántos sitios tienen una frecuencia del alelo menor <0.05?

10. Calcula la heterocigosidad de cada individuo.

11. Calcula la diversidad nucleotídica por sitio.

12. Filtra los sitios que tengan una frecuencia del alelo menor <0.05

13. Convierte el archivo `wolves_maf05.vcf` a formato plink.
