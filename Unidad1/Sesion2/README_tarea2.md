# TAREA 2

Este repositorio contiene evidencias de la realizción del ejercicio 2 de la **Sesión 2** , el cual como uno de los ejercicios nos pide clonar el repositorio de la clase. A continuación s e describen los pasos y pantallazos 

## 1. Clonar el repositorio de la clase

Como el repo tiene varias ramas, debes clonar **solo la rama `master`**:

```
$ git clone --branch master --single-branch https://github.com/u-genoma/BioinfinvRepro/Unidad1.git
Cloning into 'BioinfinvRepro'...
remote: Enumerating objects: 3242, done.
remote: Counting objects: 100% (432/432), done.
remote: Compressing objects: 100% (236/236), done.
remote: Total 3242 (delta 218), reused 383 (delta 190), pack-reused 2810 (from 1)
Receiving objects: 100% (3242/3242), 140.47 MiB | 12.42 MiB/s, done.
Resolving deltas: 100% (1849/1849), done.

# Se crea una carpeta llamada Unidad1
```

---

## 2. Entrar en la carpeta

Buscar la carpeta que contiene el archivo `Sesion2_Organizacion_proyecto_bioinf.md`

```
cd Unidad1/Sesion2
ls
Octocat.png                                    exREADME_repoDryad.png
PracUni2                                       github_add_collaborator.png
README_example.png                             github_issues.png
Sesion2_Organizacion_proyecto_bioinf.md        github_projec.png
StacksComp.png
```

---

## 3. Editar el archivo

Abrir el archivo en Marktext (o cualquier otro editor de Markdown) y agrega al final tus datos.  **Modificado por:** Martha Florez, **Fecha:** 01-09-2025. Guardar y cerrar

---

## 4. Guardar los cambios y hacer commit

En la terminal se verifica el estado, agregar y guardar: `git status`, `git add` y `git commit`

```
$ git status
# Verifica el estado
$ git add Sesion2_Organizacion_proyecto_bioinf.md
# Se añade el archivo modificado
$ git commit -m "Agregado nombre y fecha en Sesion2"
# Crea el commit
```

---

## 5. Tomar pantallazos

Se realizan **dos capturas**:

1. El archivo en Marktext, mostrando la modificación con tu nombre y fecha.
   
   ![Pantallazo marktext](pantallazo2_marktext.png)

2. La terminal después de correr `git status` (cuando te muestre qué archivos están modificados o confirmados).
   
   ![Pantallazo terminal](pantallazo1_terminal.png)

---

## 6. Subirlo al repositorio

Hay que agregar los pantallazos en el **repositorio: [Tareas_BioinfRepro2025_MLFG](https://github.com/maluflorezg/Tareas_BioinfRepro2025_MLFG)** 

Se deben copiar los pantallazos a la carpeta del repositorio. Hacer`git add`, `git commit` y `git push` en el repo para que queden guardados.

```
ls
Octocat.png                github_add_collaborator.png
PracUni2                github_issues.png
README_example.png            github_projec.png
Sesion2_Organizacion_proyecto_bioinf.md    pantallazo1_terminal.png
StacksComp.png                pantallazo2_marktext.png
exREADME_repoDryad.png
$ git add pantallazo1_terminal.png pantallazo2_marktext.png 
$ git commit -m "Agrego pantallazos del ejercicio Sesion2"
[master e36bbb8] Agrego pantallazos del ejercicio Sesion2
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 Unidad1/Sesion2/pantallazo1_terminal.png
 create mode 100644 Unidad1/Sesion2/pantallazo2_marktext.png
$ git push origin master
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 4 threads
Compressing objects: 100% (11/11), done.
Writing objects: 100% (11/11), 138.81 KiB | 17.35 MiB/s, done.
Total 11 (delta 5), reused 0 (delta 0)
remote: Resolving deltas: 100% (5/5), completed with 3 local objects.
To https://github.com/maluflorezg/BioinfinvRepro.git
   b30b628..e36bbb8  master -> master
$ git branch -M master
$ git push -u origin master
Branch 'master' set up to track remote branch 'master' from 'origin'.
Everything up-to-date
```

---

# Conclusión

1. El archivo fue modificado exitosamente con mis datos.

2. Se generó un commit con la evidencia.

3. Las capturas se encuentran incluidas en este repositorio como prueba de la actividad



