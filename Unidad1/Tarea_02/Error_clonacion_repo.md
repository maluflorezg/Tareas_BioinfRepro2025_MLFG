# ELIMINAR Y CLONAR DE NUEVO EL REPOSITORIO

Tuve problemas al abrir la carpeta BioinfinvRepro que se encontraba en la Repo Tareas_BioinfRepro2025_MLFG ya que no se actualizaba con la información recientemente cargada. Tuve varios intentos fallidos hasta que lo logré.

## ELIMINACION DE LA CARPETA `BioinfinvRepro`

La repo [GitHub - u-genoma/BioinfinvRepro: Curso de introducción a la bioinformática e investigación reproducible](https://github.com/u-genoma/BioinfinvRepro.git) no se actualiza por lo que se procede a eliminar para instalarla nuevamente

Confirmo en el bash que contiene la carpeta `Tareas_BioinfRepro2025_MLFG`

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ ls
BioinfinvRepro			README_tarea2.md		Tarea_02_Martha_Florez.md
```

Con `rm -rf` elimino las carpeta `BioinfinvRepro` diretamente (a nivel del sistema de archivo). Tambien  elimino la configuración de submódulos

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ rm -rf BioinfinvRepro

# Elimino referencias internas en Git
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ rm -rf .git/modules/BioinfinvRepro
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ rm -f .gitmodules
```

Agrego el archivo

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git add -A
```

Confirmo wl cambio en el repo y agrego los cambios 

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git commit -m "Elimino carpeta/submódulo BioinfinvRepro"
[main cc86448] Elimino carpeta/submódulo BioinfinvRepro
 1 file changed, 1 deletion(-)
 delete mode 160000 BioinfinvRepro
```

Confirmo con `ls`que la carpeta fue borrada y procedo a integrar los cambios con `push` 

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git push
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 250 bytes | 250.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG.git
   4992f00..cc86448  main -> main
```

Una vez eliminada se clona nuevamente el repositorio `BioinfinvRepro` 

```
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git clone https://github.com/u-genoma/BioinfinvRepro.git
Cloning into 'BioinfinvRepro'...
remote: Enumerating objects: 3266, done.
remote: Counting objects: 100% (456/456), done.
remote: Compressing objects: 100% (252/252), done.
remote: Total 3266 (delta 227), reused 406 (delta 198), pack-reused 2810 (from 1)
Receiving objects: 100% (3266/3266), 140.70 MiB | 13.12 MiB/s, done.
Resolving deltas: 100% (1858/1858), done.

#Agrego, guardo y subo
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git add BioinfinvRepro/
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git commit -m "Agrego carpeta BioinfinvRepro como normal"
[main 46c64d7] Agrego carpeta BioinfinvRepro como normal
 152 files changed, 388294 insertions(+)
MacBook-Air-de-Macbook:Tareas_BioinfRepro2025_MLFG macbookair$ git push
Enumerating objects: 181, done.
Counting objects: 100% (181/181), done.
Delta compression using up to 4 threads
Compressing objects: 100% (147/147), done.
Writing objects: 100% (180/180), 16.80 MiB | 8.28 MiB/s, done.
Total 180 (delta 25), reused 161 (delta 23)
remote: Resolving deltas: 100% (25/25), done.
To https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG.git
   4153f9c..46c64d7  main -> main
```


