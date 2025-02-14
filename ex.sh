#!/bin/bash

# Configurar variables
REPO_URL="https://github.com/JP1604/dockerlanguages.git"  # Cambiar por tu URL real
LOG_DIR="/app/logs"

# Crear directorio de logs (por si acaso)
mkdir -p ${LOG_DIR}

# Clonar el repositorio objetivo
echo "Clonando repositorio..."
git clone ${REPO_URL} /app/source

# Construir y ejecutar para cada lenguaje
cd /app/source/Lenguajes

for LANG_DIR in *; do
    if [ -d "${LANG_DIR}" ]; then
        LANG=$(basename "${LANG_DIR}")
        echo "Procesando ${LANG}..."
        
        # Construir la imagen
        docker build -t "runtime-${LANG}" -f "${LANG_DIR}/Dockerfile" "${LANG_DIR}"
        
        # Ejecutar el contenedor y guardar logs
        docker run --rm \
            -v "${LOG_DIR}:/codigo/logs" \
            "runtime-${LANG}" \
            > "${LOG_DIR}/${LANG}.log" 2>&1
    fi
done

echo "Proceso completado. Los logs están en: ${LOG_DIR}"