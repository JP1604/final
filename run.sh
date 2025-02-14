#!/bin/bash

# Configuración
LENGUAJES_REPO=${LENGUAJES_REPO:-"https://github.com/JP1604/dockerlanguages.git"}  # URL default
LENGUAJES_DIR="/app/lenguajes"
RESULTADOS="/app/resultados/resultados.txt"

# Clonar repo de lenguajes
echo "🔻 Clonando repositorio de lenguajes..."
if [ -d "$LENGUAJES_DIR" ]; then
    echo "⚠️  Directorio de lenguajes ya existe, eliminando..."
    rm -rf "$LENGUAJES_DIR"
fi

git clone "$LENGUAJES_REPO" "$LENGUAJES_DIR" || {
    echo "❌ Error clonando el repositorio de lenguajes"
    exit 1
}

# Procesar benchmarks
echo "Resultados de los benchmarks:" > "$RESULTADOS"
echo "Ejecutando benchmarks..."

for dir in "$LENGUAJES_DIR"/*/; do
    if [ -d "$dir" ]; then
        LENGUAJE=$(basename "$dir")
        echo "🔹 Ejecutando $LENGUAJE..."
        
        docker build -t "${LENGUAJE//+/}-benchmark" "$dir"
        
        TIEMPO=$(docker run --rm "${LENGUAJE//+/}-benchmark")
        
        if [ -n "$TIEMPO" ]; then
            echo "$LENGUAJE: $TIEMPO ms" >> "$RESULTADOS"
            echo "✅ $LENGUAJE: $TIEMPO ms"
        else
            echo "❌ Error: Salida vacía para $LENGUAJE"
        fi
    fi
done

echo "📊 Resultados guardados en $RESULTADOS"