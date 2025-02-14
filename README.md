# 📘 Instructivo para Ejecución

## 🔧 Requisitos Previos

- Docker instalado.
- Acceso a Docker Hub (opcional si se desea subir la imagen).

## PASO A PASO PARA EJECUTAR EN PLAY WITH DOCKER

1. Actualiza los paquetes e instala Git:
    ```sh
    apk update && apk add git
    ```
2. Clona el repositorio:
    ```sh
    git clone https://github.com/JP1604/final.git
    ```
3. Crea el directorio de logs:
    ```sh
    mkdir logs
    ```
4. Navega al directorio del proyecto:
    ```sh
    cd final
    ```
5. Construye la imagen Docker:
    ```sh
    docker build -t builder .
    ```
6. Ejecuta el contenedor:
    ```sh
    docker run -it --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v $(pwd)/logs:/app/logs \
      --privileged \
      builder
    ```

## MIEMBROS DEL GRUPO

- Juan Pablo Pérez
- Andres Felipe Pérez

## ENLACE DE LOS REPOSITORIOS

- Repositorio base: [https://github.com/JP1604/final.git](https://github.com/JP1604/final.git)
- Repositorio lenguajes: [https://github.com/JP1604/dockerlanguages.git](https://github.com/JP1604/dockerlanguages.git)
