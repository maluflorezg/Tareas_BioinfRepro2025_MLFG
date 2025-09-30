# Se Carga el archivo
meta_maiz <- read.table("maizteocintle_SNP50k_meta_extended.txt",
                        header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Tipo de objeto
class(meta_maiz)
head(meta_maiz)
nrow(meta_maiz)

# Muestra las primeras 6 líneas
head(meta_maiz)

# Número de muestras
nrow(meta_maiz)

# Número de estados con muestras
length(unique(meta_maiz$Estado))

# Muestras colectadas antes de 1980
sum(meta_maiz$Año._de_colecta < 1980, na.rm = TRUE)

# Número de muestras por raza
table(meta_maiz$Raza)

# Altitud promedio, máxima y mínima
mean(meta_maiz$Altitud, na.rm = TRUE)
max(meta_maiz$Altitud, na.rm = TRUE)
min(meta_maiz$Altitud, na.rm = TRUE)

# Nueva df solo con la raza Olotillo
olotillo <- subset(meta_maiz, Raza == "Olotillo")

# Nueva df con razas Reventador, Jala y Ancho
sub_raza <- subset(meta_maiz, Raza %in% c("Reventador", "Jala", "Ancho"))

# Guardar matriz anterior en un archivo CSV dentro de /meta
write.csv(sub_raza, "~/Documents/meta/submat.csv", row.names = FALSE)

exists("sub_raza")         # ¿existe el objeto?
is.data.frame(sub_raza)    # ¿es data.frame?
nrow(sub_raza); ncol(sub_raza)  # tamaño
head(sub_raza)             # vistazo rápido

carpeta_meta <- file.path("~", "Documents", "meta")
archivo_csv  <- file.path(carpeta_meta, "submat.csv")
archivo_csv

if (!dir.exists(carpeta_meta)) {
  dir.create(carpeta_meta, recursive = TRUE)
}
dir.exists(carpeta_meta)   # debería devolver TRUE

write.csv(sub_raza, archivo_csv, row.names = FALSE)

# write.csv(sub_raza, archivo_csv, row.names = FALSE, fileEncoding = "UTF-8")

file.exists(archivo_csv)   # TRUE si el archivo está allí
file.info(archivo_csv)     # información del archivo (tamaño, fecha, etc.)

check <- read.csv(archivo_csv, stringsAsFactors = FALSE)
head(check)
dim(check)

system(paste("open", carpeta_meta))

write.csv2(sub_raza, archivo_csv, row.names = FALSE)  # separador ; y decimal ,
