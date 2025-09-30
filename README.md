# Introducción a la bioinformática y la investigación reproducible para el análisis genómico

[Tareas_BioinfRepro2025_MLFG](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG)
Este es un repositorio del curso "Introducción a la bioinformática e investigación reproducible para análisis genéticos" II semestre 2025. 
Se crea con el fin de darle seguimiento al curso, subiendo las tareas asignadas y actializaciones. 

Actualmente en [Tareas_BioinfRepro2025_MLFG](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG) se encuentra:

1. **Carpeta [BioinfinvRepro](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/tree/main/BioinfinvRepro "BioinfinvRepro")**
   Es una clonación de [GitHub - u-genoma/BioinfinvRepro: Curso de introducción a la bioinformática e investigación reproducible](https://github.com/u-genoma/BioinfinvRepro.git). Incluye el material docente que se debe actualizar, además incluye información sobre los ejercicios/Tareas a realizar
2. **Carpeta [Tareas_sesiones](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/tree/main/Tareas_sesiones "Tareas_sesiones")**
   Contiene sub carpetas de las **Tareas por Sesión** que incluirá el material requerido para la realización de la tarea
3. **README.md con el detalle de lo realizado por sesion que se actualizara a medida que avanza el curso

# TAREA 1 - Introducción a la programación

Realizar los ejercicios que figuran al final del tutorial de la Sesión 1 de la Unidad 1:

1. Escribe una línea de código que cree un archivo con los nombres de las muestras de maiz enlistadas en /Unidad1/Sesion1/Prac_Uni1/Maiz/nuevos_final.fam.
2. Escribe un script que cree 4 directorios llamados PobA, PobB, PobC, PobD y dentro de cada uno de ellos un archivo de texto que diga "Este es un individuo de la población x" donde x debe corresponder al nombre del directorio.
3. Escribe un script que baje 5 secuencias (algún loci corto, no un genoma) de una especie que te interese y señala cuántas veces existe la secuencia "TGCA" en cada una de ellas. ¿Sabes qué hace esta secuencia?
4. La entrega se hace en uno más PDF. Pueden adjuntar scripts y archivos de output en archivos de texto plano.

## EJERCICIOS

1. Enlista el contenido de `Maiz` por tamaño del archivo y has que el tamaño del archivo se lea en KB y MB (ie reducido en vez de todos los bytes).

2. Necesitamos crear más archivos .bed y .fam para los ejemplos de abajo. Queremos qué se llamen `ejemplo_final.bed` y `ejemplo_final.fam`. ¿Cómo hacerlo?

El resultado del ejercicio anterior es:

```
$ ls
ejemplo_final.bed    nuevos_final.bed    nuevos_final.log
ejemplo_final.fam    nuevos_final.bim
ejemplonano.txt        nuevos_final.fam
```

3. En el archivo que estamos viendo hay unas muestras de teocintles cuyos nombres empiezan con "teos". ¿En qué líneas del documento están?

4. ¿Cómo concatenar tres o más archivos a la vez?

### El desarrollo de la Tarea_01 se encuentra en [Tarea01_Florez_Martha.pdf](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Tareas_sesiones/Sesion_1/Tarea01_Florez_Martha.pdf)

# TAREA 2 - Introducción a la programación

Realizar los ejercicios que figuran al final del tutorial de la Sesión 2 de la Unidad 2:

1. Realiza los ejercicios indicados en cada sección del tutorial de la Sesión 2 de la Unidad 2.
2. Pon tus resultados en tu repositorio personal en GiHub, siguiendo las instrucciones del tutorial
3. Organiza tu repositorio según los lineamientos del tutorial. Cada avance semanal debe tener su propia página en Markdown donde se indiquen cuáles eran los ejercicios a realizar y los resultados obtenidos.
4. Para los ejercicios que son de la partes sobre Markdown, mostrar capturas de pantalla tanto de el código como del resultado formateado.
5. Las figuras deben tener sus respectivas leyendas explicativas, un número de figura y debe estar citada en el texto.
6. Cuando envíen la tarea, no adjunten archivos. Solo indiquen el url de su repositorio.

## EJERCICIOS

1. Abre el el editor de Markdown de tu preferencia y escribe un texto en formato Markdown de manera que quede igual que los tres primeros puntos de [Preparing the environment, cleaning the data for Stacks](http://catchenlab.life.illinois.edu/stacks/manual/#procrad) (incluyendo ese subtítulo). No es necesario poner los colores, pero si quieres, cool.

2. siguiendo los pasos del tutorial anterior, genera un repositorio entro de tu cuenta de Github que se llame "Tareas_BioinfRepro2019_TusIniciales".

3. Clona el repositorio de la clase y actualízalo que vez que sea necesario. **NOTAS IMPORTANTES PARA ESTE EJERCICIO:**
   
   3.1 Clonalo en un lugar distinto de dónde habías bajado la carpeta del repo las clases anteriores, o cámbiale el nombre a esa carpeta vieja, o símil.
   3.2 Como mi repo tiene más de una rama, necesitarás agregar a tu `git clone` lo siguiente: `--branch master --single-branch`.
   3.3 Modica la página de esta sesion en tu copia local, inclyebdo tus datos (nombre y fecha de modificacón).
   3.4 Realiza un comit de tus cambios
   3.5 Toma un pantallazo de la página modificada (en un editor de Markdown) y del teminar luego de ejecuta `$ git status` incluye esos pantallazos con respectivas explicaciones de qué muestran en la página de las tadea para la Sesión en tu respositorio personal.

4. Genera un repositorio dentro de tu cuenta de Github que se llame "Tareas_BioinfRepro2019_TusIniciales".

5. Agrégme a mi como colaborador en el repositorio de tareas del curso que creaste en tu cuenta de Github. Mi nobre de usaiurio es "ravuch"

6. Mira el siguiente script [tomado del manual de Stacks] (http://catchenlab.life.illinois.edu/stacks/manual/#phand) y contesta lo siguiente:

¿Cuántos pasos tiene este script?
¿Si quisieras correr este script y que funcionara en tu propio equipo, qué línea deberías cambiar y a qué?
¿A qué equivale `$HOME`?
¿Qué paso del análisis hace el programa `gsnap`?
¿Qué hace en términos generales cada uno de los loops?

7. Retoma el ejercicio anterior y divídelo en un subscript para cada paso y un script maestro que corra toda la pipeline.

### El desarrollo de la Tarea_02 se encuentra en [Tarea_02_Martha_Florez.md](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG/blob/main/Tareas_sesiones/Sesion_2/Tarea_02_Martha_Florez.md)

# TAREA 3 - Introducción a R con un enfoque bioinformático

Revisar el tutorial de la Sesión 3 de la Unidad y resolver sus ejercicios: 

1. Poner todo en un Markdown específico para esta tarea en sus repositorios.
2. Recuerden que la página de inicio de sus repositorios debe tener un README, describiendo el repositorio, y que este debe tener links a las tareas de cada semana.
3. Organizar el material de cada semana en su propia carpeta, tal como está organizado el repositorio del curso.

## EJERCICIOS

1. Crea una variable con el logaritmo base 10 de 50 y súmalo a otra variable cuyo valor sea igual a 5.

2. Suma el número 2 a todos los números entre 1 y 150.

3. ¿Cuántos números son mayores a 20 en el vector -13432:234?

4. Carga en R el archivo `PracUni1Ses3/maices/meta/maizteocintle_SNP50k_meta_extended.txt` y ponlo en un objeto de R llamado meta_maiz.

5. Escribe un for loop para que divida 35 entre 1:10 e imprima el resultado en la consola.

Modifica el loop anterior para que haga las divisiones solo para los números nones (con un comando, NO con `c(1,3,...)`). Pista: `next`.

Modifica el loop anterior para que los resultados de correr todo el loop se guarden en una df de dos columnas, la primera debe tener el texto "resultado para x" (donde x es cada uno de los elementos del loop) y la segunda el resultado correspondiente a cada elemento del loop. Pista: el primer paso es crear un vector fuera del loop. Ejemplo:

```
elefantes<-character(0)
for (i in 2:10){
  elefantes<-rbind(elefantes, (paste(i, "elefantes se columpiaban sobre la tela de una araña")))
}
elefantes
```

6. Abre en RStudio el script `PracUni1Ses3/mantel/bin/1.IBR_testing.r`. Este script realiza un análisis de aislamiento por resistencia con Fst calculadas con ddRAD en Berberis alpina.

Lee el código del script y determina:
¿qué hacen los dos for loops del script?
¿qué paquetes necesitas para correr el script?
¿qué archivos necesitas para correr el script?

7. Escribe una función llamada `calc.tetha` que te permita calcular tetha dados Ne y u como argumentos. Recuerda que tetha =4Neu.

Ejercicio: Al script del ejercicio de las pruebas de Mantel, agrega el código necesario para realizar un Partial Mantel test entre la matriz Fst, y las matrices del presente y el LGM, parcializando la matriz flat. Necesitarás el paquete `vegan`.

8. Escribe un script que debe estar guardado en `PracUni1Ses3/maices/bin` y llamarse `ExplorandoMaiz.R`, que 1) cargue en R el archivo `PPracUni1Ses3maices/meta/maizteocintle_SNP50k_meta_extended.txt` y 2) responda lo siguiente.

(averigua cada punto con comandos de R. Recuerda comentar o tendrás 7 años de mala suerte en el lab)

¿Qué tipo de objeto creamos al cargar la base? ¿Cómo se ven las primeras 6 líneas del archivo? ¿Cuántas muestras hay? ¿De cuántos estados se tienen muestras? ¿Cuántas muestras fueron colectadas antes de 1980? ¿Cuántas muestras hay de cada raza? En promedio ¿a qué altitud fueron colectadas las muestras? ¿Y a qué altitud máxima y mínima fueron colectadas? Crea una nueva df de datos sólo con las muestras de la raza OlotilloCrea una nueva df de datos sólo con las muestras de la raza Reventador, Jala y Ancho Escribe la matriz anterior a un archivo llamado "submat.cvs" en /meta
