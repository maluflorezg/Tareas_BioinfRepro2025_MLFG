#!/usr/bin/env Rscript

infile <- "results/allele_freq_biallelic.frq"
out_tsv <- "results/maf_values.tsv"
out_png <- "results/maf_histogram.png"

df <- read.table(infile, header = TRUE, stringsAsFactors = FALSE)

# Extraer las frecuencias de las columnas 5 y 6 (A1:A2)
f1 <- as.numeric(sub(".*:", "", df[[5]]))
f2 <- as.numeric(sub(".*:", "", df[[6]]))

# Minor Allele Frequency
maf <- pmin(f1, f2, na.rm = TRUE)

# Guardar los valores en un archivo TSV
out <- data.frame(MAF = maf)
write.table(out, file = out_tsv, sep = "\t", row.names = FALSE, quote = FALSE)

# Histograma de MAF
png(out_png, width = 1200, height = 800, res = 150)
hist(maf, breaks = 50, main = "MAF spectrum (biallelic)", 
     xlab = "Minor allele frequency")
dev.off()
