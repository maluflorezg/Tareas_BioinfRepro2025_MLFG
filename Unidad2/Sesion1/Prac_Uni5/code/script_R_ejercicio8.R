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

cat("✅ Histograma guardado en:", out_png, "\n")
cat("✅ Archivo con valores de MAF guardado en:", out_tsv, "\n")


