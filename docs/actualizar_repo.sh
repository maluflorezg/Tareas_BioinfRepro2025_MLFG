#!/usr/bin/env bash
set -euo pipefail

# Actualiza la copia local con lo que hay en GitHub.
# Uso:
#   ./actualizar_repo.sh                # modo forzado, rama main
#   ./actualizar_repo.sh -s             # forzado + stash
#   ./actualizar_repo.sh -m             # modo seguro (pull fast-forward)
#   ./actualizar_repo.sh -b nombre_rama # especifica rama
#   ./actualizar_repo.sh -m -b dev      # pull ff-only en rama dev

BRANCH="main"
MODE="hard"   # "hard" (reset --hard) o "merge" (pull --ff-only)
DO_STASH="no"

while getopts "b:ms" opt; do
  case "$opt" in
    b) BRANCH="$OPTARG" ;;
    m) MODE="merge" ;;      # seguro
    s) DO_STASH="yes" ;;    # guardar cambios locales
    *) echo "Uso: $0 [-m] [-s] [-b rama]"; exit 1 ;;
  esac
done

# Verificaciones básicas
if ! command -v git >/dev/null 2>&1; then
  echo "Error: git no está instalado"; exit 1
fi
if [ ! -d .git ]; then
  echo "Error: aquí no hay un repositorio git (no se encuentra .git)"; exit 1
fi

# Mostrar contexto
echo "📦 Repo : $(basename "$(pwd)")"
echo "🌿 Rama : $BRANCH"
echo "🛠  Modo : $([ "$MODE" = "merge" ] && echo "seguro (pull --ff-only)" || echo "forzado (reset --hard)")"
echo "🧰 Stash: $DO_STASH"

# Cambiar a la rama objetivo si existe localmente; si no, crearla desde origin
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  git checkout "$BRANCH"
else
  echo "Rama local '$BRANCH' no existe. Intentando crearla desde origin..."
  git fetch origin
  git checkout -t "origin/$BRANCH"
fi

# Opcional: guardar cambios locales
if [ "$DO_STASH" = "yes" ]; then
  echo "Haciendo stash de cambios locales (si hay)..."
  git stash push -u -m "auto-stash $(date +%F_%T)" || true
fi

echo "Obteniendo cambios de origin..."
git fetch origin

if [ "$MODE" = "merge" ]; then
  echo "Actualizando con pull --ff-only (sin merges de tipo 'manual')..."
  git pull --ff-only origin "$BRANCH"
else
  echo "Forzando a que el árbol local sea idéntico a origin/$BRANCH..."
  git reset --hard "origin/$BRANCH"
  # Limpia archivos no versionados que ya no existen en origin (opcional, descomenta si quieres)
  # git clean -fd
fi

echo "✅ Listo. Estado actual:"
git status -sb

