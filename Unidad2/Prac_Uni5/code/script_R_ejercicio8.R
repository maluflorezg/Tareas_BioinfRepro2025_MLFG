#!/usr/bin/env Rscript

# Archivos de entrada y salida (rutas relativas desde code/)
infile <- "../results/frecuencias_bialelicas.frq"
out_tsv <- "../results/maf_values.tsv"
out_png <- "../results/maf_histogram.png"

# Cargar librería
suppressMessages(library(ggplot2))

# Leer archivo de frecuencias generado con vcftools --freq
freq <- read.table(infile, header = TRUE, stringsAsFactors = FALSE)

# Extraer frecuencias de los alelos (5ª y 6ª columna suelen contener las frecuencias)
f1 <- as.numeric(sub(".*:", "", freq[[5]]))
f2 <- as.numeric(sub(".*:", "", freq[[6]]))

# Calcular la MAF como el mínimo entre las dos frecuencias
maf <- pmin(f1, f2, na.rm = TRUE)

# Guardar los valores de MAF en un TSV
out <- data.frame(MAF = maf)
write.table(out,
            file = out_tsv,
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

# Graficar histograma
p <- ggplot(out, aes(x = MAF)) +
  geom_histogram(binwidth = 0.05, fill = "steelblue", color = "black", boundary = 0) +
  labs(title = "Espectro de frecuencias alélicas menores (MAF)",
       x = "Frecuencia alélica menor (MAF)",
       y = "Número de variantes") +
  theme_minimal(base_size = 14)

ggsave(out_png, plot = p, width = 8, height = 6, dpi = 300)

cat("✅ Script finalizado. Archivos creados:\n")
cat(" - Valores de MAF:", out_tsv, "\n")
cat(" - Histograma MAF:", out_png, "\n")
