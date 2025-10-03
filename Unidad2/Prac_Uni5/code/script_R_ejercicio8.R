#!/usr/bin/env Rscript

# --- Archivos ---
infile <- "../results/frecuencias_bialelicas_bial.frq"
out_tsv <- "../results/maf_values.tsv"
out_png <- "../results/maf_histogram.png"

# --- Librerías ---
suppressMessages(library(ggplot2))

# --- Leer archivo sin encabezado ---
freq <- read.table(infile, header = FALSE, stringsAsFactors = FALSE)

# Asignar nombres de columna
colnames(freq) <- c("CHROM", "POS", "N_ALLELES", "N_CHR", "A1", "A2")

# --- Extraer frecuencias ---
f1 <- as.numeric(sub(".*:", "", freq$A1))
f2 <- as.numeric(sub(".*:", "", freq$A2))

# Calcular MAF
maf <- pmin(f1, f2, na.rm = TRUE)

# --- Guardar valores ---
out <- data.frame(MAF = maf)
write.table(out, file = out_tsv, sep = "\t", row.names = FALSE, quote = FALSE)

# --- Graficar histograma ---
p <- ggplot(out, aes(x = MAF)) +
  geom_histogram(binwidth = 0.05, fill = "steelblue", color = "black", boundary = 0) +
  labs(title = "Espectro de frecuencias alélicas menores (MAF)",
       x = "Frecuencia alélica menor (MAF)",
       y = "Número de variantes") +
  theme_minimal(base_size = 14)

ggsave(out_png, plot = p, width = 8, height = 6, dpi = 300)

# --- Mensaje final ---
cat("✅ Script finalizado. Archivos creados:\n")
cat(" - Valores de MAF:", out_tsv, "\n")
cat(" - Histograma MAF:", out_png, "\n")
