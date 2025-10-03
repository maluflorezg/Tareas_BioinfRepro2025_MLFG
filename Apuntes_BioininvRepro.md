### **APUNTES**

Comandos
`pwd` nos da el directorio en donde estamos (viene de print **working directory**).

`cd` viene de **change directory** y sirve para movernos a otro directorio

`~` es una especie de ruta corta a la ruta absoluta de tu directorio home. No importa dónde estés `cd ~` te llevará a home.

`cd ..` por lo tanto te lleva a un directorio arriba de donde estés.

`cd ./` te lleva al directorio en el que estás. Lo importante a recordar es que `.` significa "el directorio actual".

`ls` Enlista los archivos y directorios presentes en un directorio

`ls -l` brinda la misma lista, pero con datos sobre: si es un directorio (d) o un archivo (-), permisos (si es sólo lectura, editable, etc y por quién, detalles más adelante), número de links al archivo, qué usuario es el dueño, a qué grupo pertenece dicho usuario, tamaño en bytes, fecha-hora en que se modificó y el nombre del directorio o archivo.

 `mkdir`Crea un directorio.

```
$ mkdir Prueba
$ ls
Prueba            nuevos_final.bim    nuevos_final.log
nuevos_final.bed    nuevos_final.fam
```

`cp`Copia un archivo o directorio de lugar A a lugar B.

```
$ cp -r Prueba ../
$ ls ../
Maiz        Manzanas    Peras        Prueba        Tomates
```

`mv`Mueve un archivo o directorio de lugar A a lugar B. Equivalente a "cut-paste".

```
$ mv ../Prueba ../Manzanas
$ ls ../
Maiz        Manzanas    Peras        Tomates
$ ls ../Manzanas
Prueba
```

Si los archivos empiezan con el mismo nombre se puede hacer

```
git mv Sesion_* Unidad1/
```

`rm`Borra (**AGUAS al usar esto**) archivos o dvirectorios.

```
$ rm -r Prueba
$ rm -r ../Manzanas/Prueba
```

### Crear archivos desde la terminal

Es posible crear archivos de texto directamente desde la terminal utilizando programas como `vi` y `nano` o el comando `touch`.

Touch solo crea un archivo sin contenido. Ejemplo :

```
$ cd Maiz
$ touch prueba
$ ls
nuevos_final.bed    nuevos_final.fam    prueba
nuevos_final.bim    nuevos_final.log
$ rm prueba
```

Con `Nano` o `Vim` podemos

```
$ nano ejemplonano.txt
```

Al guardar con `^O` (ctrl + O) pedirá un nombre de archivo. Dirá "ejemplonano.txt" porque fue el nombre que dimos al correr `nano`, pero se puede camibar.

Una vez fuera de nano podemos verlo en la Terminal y volverlo a abrir si queremos:

```
$ ls
ejemplonano.txt        nuevos_final.bim    nuevos_final.log
nuevos_final.bed    nuevos_final.fam
$ nano ejemplonano.txt
```

`curl` Sirve para bajar archivos de internet a la computadora.

Sintaxis:

```
curl [opciones] [direccionURLdelarchivo]
```

Ejemplo, podemos bajar el archivo de texto del README que vive en el repositorio de esta clase:

```
$ curl -s "https://raw.githubusercontent.com/AliciaMstt/BioinfInvRepro/master/README.md"
# Introducción a la bioinformática e investigación reproducible para análisis genéticos

Este es el repositorio de apuntes y código del curso **Introducción a la bioinformática e investigación reproducible para análisis genéticos** [...]
```

### Comodines o el uso de `*` `?` `[]` `{}`

`*` "Comodín" o *wildcard*. Cualquier texto (uno o más caracteres) a partir (derecha o izquierda) de dónde se ponga el `*`.

Ejemplo:

```
$ ls *.bed
ejemplo_final.bed    nuevos_final.bed
$ ls nuevos*
nuevos_final.bed    nuevos_final.fam
nuevos_final.bim    nuevos_final.log
```

`?`Parecido a ´*´ pero para un sólo carácter.

```
$ ls *.b??
ejemplo_final.bed    nuevos_final.bed    nuevos_final.bim
```

`[]` Para agrupar términos de búsqueda. Por ejemplo letras [a-z]

```
$ ls [a-z]*.bed
ejemplo_final.bed    nuevos_final.bed
```

## Funciones básicas de exploración de archivos con bash

 `more` Nos permite ver el archivo una línea (flecha abajo) o página a la vez (barra espaciadora). Para salir: `q`

```
$ more nuevos_final.fam
1 maiz_3 0 0 0 -9
2 maiz_68 0 0 0 -9
3 maiz_91 0 0 0 -9
4 maiz_39 0 0 0 -9
5 maiz_12 0 0 0 -9
6 maiz_41 0 0 0 -9
7 maiz_35 0 0 0 -9
8 maiz_58 0 0 0 -9
9 maiz_51 0 0 0 -9
10 maiz_82 0 0 0 -9
11 maiz_67 0 0 0 -9
12 maiz_93 0 0 0 -9
13 maiz_21 0 0 0 -9
14 maiz_6 0 0 0 -9
15 maiz_101 0 0 0 -9
16 maiz_27 0 0 0 -9
17 maiz_43 0 0 0 -9
18 maiz_1 0 0 0 -9
19 maiz_33 0 0 0 -9
20 maiz_100 0 0 0 -9
21 maiz_24 0 0 0 -9
22 maiz_103 0 0 0 -9
23 maiz_72 0 0 0 -9
24 maiz_10 0 0 0 -9
25 maiz_28 0 0 0 -9
26 maiz_49 0 0 0 -9
27 maiz_56 0 0 0 -9
28 maiz_66 0 0 0 -9
29 maiz_52 0 0 0 -9
nuevos_final.fam
```

(puedes salir con `q` si no quieres escrolear (yes, esa palabra no existe en español) todo el archivo para abajo)

`less` Igual que `more` pero se desarrolló más recientemente y puede abrir archivos binarios y otras cosas raras. Juego de palabras con que *less is more*. Pum pum. Se recomienda usar `less` en la vida.

Dentro de `less` (y `more`) podemos escribir `/` y luego texto, mismo que será buscando dentro del archivo.

**Ejercicio**: En el archivo que estamos viendo hay unas muestras de teocintles cuyos nombres empiezan con "teos". ¿En qué líneas del documento están?

`head` Muestra las primeras líneas de un archivo (default 10).

```
$ head nuevos_final.fam
1 maiz_3 0 0 0 -9
2 maiz_68 0 0 0 -9
3 maiz_91 0 0 0 -9
4 maiz_39 0 0 0 -9
5 maiz_12 0 0 0 -9
6 maiz_41 0 0 0 -9
7 maiz_35 0 0 0 -9
8 maiz_58 0 0 0 -9
9 maiz_51 0 0 0 -9
10 maiz_82 0 0 0 -9
```

`tail`Muestra las últimas líneas de un archivo.

**Pregunta:** ¿Para qué podría ser útil ver las últimas líneas de un archivo?

 `wc`Brinda el número de líneas, el número de palabras y el número de caracteres del archivo.

```
$ wc nuevos_final.fam
     165     990    3604 nuevos_final.fam
```

`cat`Viene de *Concatenate*. Sirve para unir uno detrás de otro varios archivos, o para imprimir todo el contendio de un archivo a la consola.

Viene de *Concatenate*. Sirve para unir uno detrás de otro varios archivos, o para imprimir todo el contendio de un archivo a la consola.

### Usos comunes de `grep`

`grep` a secas: Busca una expresión regular y otorga las líneas donde se encontró dicha expresión.

Ejemplo:

```
$ grep ">" tomatesverdes.fasta
>gi|156629013|gb|EF438954.1| Physalis philadelphica isolate P061 maturase K (matK) gene, partial cds; chloroplast
>gi|156629009|gb|EF438952.1| Physalis philadelphica isolate P059 maturase K (matK) gene, partial cds; chloroplast
>gi|156628921|gb|EF438908.1| Physalis philadelphica isolate P056 maturase K (matK) gene, partial cds; chloroplast
>gi|156628893|gb|EF438894.1| Physalis philadelphica isolate P050 maturase K (matK) gene, partial cds; chloroplast
>gi|156629011|gb|EF438953.1| Physalis philadelphica isolate P060 maturase K (matK) gene, partial cds; chloroplast
```

**Pregunta**: ¿Por qué está ">" entre comillas?

**Ejercicio** En el mismo directorio hay otro archivo fasta. Utiliza `grep` y algo más para ver el encabezado de `tomatesverdes.fasta` y `jitomate.fasta`. ¿Qué diferencia hay con el output anterior?

 `grep -c`Para contar en cuántas líneas aparece la expresión de búsqueda

```
$ grep -c ">" tomatesverdes.fasta
5
```

`grep -l`Sólo enlista los archivos donde se encontró la expresión, pero no las líneas.

```
$ grep -l Physalis *.fasta
tomatesverdes.fasta
```

`grep -i`Hace que la búsqueda sea **insensible** a Mayúsculas/minúsculas.

`grep -w` Sirve para buscar palabras completas, por ejemplo para buscar "he" y no "the".

```
$ grep -l physalis *.fasta
$
$ grep -li physalis *.fasta
tomatesverdes.fasta
```

`grep -w` Sirve para buscar palabras completas, por ejemplo para buscar "he" y no "the".

```
$ grep iso tomatesverdes.fasta
>gi|156629013|gb|EF438954.1| Physalis philadelphica isolate P061 maturase K (matK) gene, partial cds; chloroplast
>gi|156629009|gb|EF438952.1| Physalis philadelphica isolate P059 maturase K (matK) gene, partial cds; chloroplast
>gi|156628921|gb|EF438908.1| Physalis philadelphica isolate P056 maturase K (matK) gene, partial cds; chloroplast
>gi|156628893|gb|EF438894.1| Physalis philadelphica isolate P050 maturase K (matK) gene, partial cds; chloroplast
>gi|156629011|gb|EF438953.1| Physalis philadelphica isolate P060 maturase K (matK) gene, partial cds; chloroplast
$ grep -w iso tomatesverdes.fasta
$
```

 `grep -E`Lee el texto entre comillas como una expresión regular completa, es decir con operadores, cuantificadores y posicionadores. Es útil utilizarlo junto con `-o` para mostrar solo la parte del texto encontrado que cumple con la expresión regular.

```
$ grep -oE "\| \w+ \w+" tomatesverdes.fasta
| Physalis philadelphica
| Physalis philadelphica
| Physalis philadelphica
| Physalis philadelphica
| Physalis philadelphica
```

`sed` es particularmente útil para sustituir una expresión regular (como una palabra) por otra.

Por ejemplo esta línea cambia "Solanum lycopersicum" del archivo "tomates.fasta" por "jitomate"

```
sed 's/Solanum lycopersicum/jitomate/' tomates.fasta
```

`awk` es parecido, pero es particularmente útil para archivos con filas y columnas, pues puedes acceder específicamente a ellas.

### Actualización del repo BioinfinvRepro

```
# Entra a la carpeta BioinfinvRepro
MacBook-Air-de-Macbook:BioinfinvRepro

# Descarga los cambios del repo original
git fetch origin
git pull origin main

# Registrar el cambio en repo Tareas_BioinfRepro2025_MLFG.git
git add BioinfinvRepro
git commit -m "Actualizo submódulo BioinfinvRepro"
git push origin main
```

Hay una opción (al parecer más flexible) que configurar `u-genoma/BioinfinvRepro` como remoto adicional; **jalar actualizaciones periódicamente** sin borrar nada, haz esto dentro de tu carpeta

```
BioinfinvRepro
cd BioinfinvRepro # Agrega el repo original como remoto extra git remote add upstream https://github.com/u-genoma/BioinfinvRepro.git # Obtén los cambios nuevos del original git fetch upstream # Fusiona con tu rama local (ej: main) git merge upstream/main`

Luego regresas a la raíz de tu repo y haces:
cd ..
git add BioinfinvRepro
git commit -m "Actualizo BioinfinvRepro desde upstream" git push origin main`
```

Elimina el repo en GitHub.

Crea uno nuevo vacío.

En tu servidor, elimina la carpeta .git y vuelve a iniciar el repo:

```
git rm -rf .
git init
git remote add origin git@github.com:maluflorezg/Tareas_BioinfRepro2025_MLFG.git
git add .
git commit -m "Repo limpio sin archivos grandes"
git push -u origin main
```

Así subes solo lo actual y sin la historia “sucia”.

Opción avanzada (limpiar la historia)

Usar una herramienta como BFG Repo-Cleaner o git filter-repo para eliminar de todo el historial los archivos grandes.

Ejemplo con BFG:

bfg --delete-files plink.hwe
bfg --delete-files 1kG_MDS6.ped

Luego fuerzas el push:

git push origin main --force

👉 Te recomiendo la opción 1 (empezar limpio) si no necesitas mantener la historia de commits.
Verifica en qué rama estás:

git branch

Si estás en master, cámbiale el nombre a main:

git branch -M main

Ahora enlaza tu repo con GitHub y sube:

git remote add origin git@github.com:maluflorezg/Tareas_BioinfRepro2025_MLFG.git
git push -u origin main

👉 Después de esto, tu carpeta Prac_Uni5 debería estar en GitHub en la rama main, limpia y sin los archivos gigantes. 🚀
Como actualizar el git

1. Asegurarme de estar en mi repo 
   bioinfo1@genoma:~$ cd ~/mflorez/Tareas_BioinfRepro2025_MLFG

Qué hacer ahora

Ve a la carpeta de tu repo:

cd ~/mflorez/Tareas_BioinfRepro2025_MLFG

Ahora prueba:

git remote -v

Debe salir:

origin  git@github.com:maluflorezg/Tareas_BioinfRepro2025_MLFG.git (fetch)
origin  git@github.com:maluflorezg/Tareas_BioinfRepro2025_MLFG.git (push)

Para confirmar la rama:

git branch

Para ver el último commit:

git log -1
