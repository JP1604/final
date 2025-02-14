FROM docker:dind

# Instalar dependencias: bash + git
RUN apk add --no-cache bash git

# Configurar entorno
WORKDIR /app
COPY . /app
RUN chmod +x ex.sh

# Crear directorio de logs
RUN mkdir -p /app/logs

# Ejecutar script al iniciar
ENTRYPOINT ["/app/ex.sh"]