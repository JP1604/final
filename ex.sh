#!/bin/bash

# Configurar variables
REPO_URL="https://github.com/JP1604/dockerlanguages.git"  # Cambiar por tu URL real
LOG_DIR="/app/logs"
SUMMARY_FILE="${LOG_DIR}/summary.txt"

# Crear directorios necesarios
mkdir -p ${LOG_DIR}

# Inicializar archivo de resumen
echo -e "Lenguaje\tTiempo (ms)" > ${SUMMARY_FILE}
echo "---------------------------------" >> ${SUMMARY_FILE}

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
        
        # Medir tiempo de ejecución en nanosegundos y convertir a milisegundos
        START_TIME=$(date +%s%N)
        
        # Ejecutar el contenedor y guardar logs
        docker run --rm \
            -v "${LOG_DIR}:/codigo/logs" \
            "runtime-${LANG}" \
            > "${LOG_DIR}/${LANG}.log" 2>&1
            
        # Calcular tiempo transcurrido en milisegundos
        END_TIME=$(date +%s%N)
        ELAPSED_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
        
        # Escribir el tiempo en el archivo de log
        echo "Tiempo transcurrido: ${ELAPSED_TIME} milisegundos" >> "${LOG_DIR}/${LANG}.log"
        
        # Registrar en el resumen
        printf "%-12s\t%d\n" "${LANG}" "${ELAPSED_TIME}" >> ${SUMMARY_FILE}
    fi
done

# Mostrar resumen en consola
echo -e "\nResumen de ejecución:"
cat ${SUMMARY_FILE}

echo -e "\nProceso completado. Los logs están en: ${LOG_DIR}"