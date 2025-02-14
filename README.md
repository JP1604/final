📘 Instructivo para Ejecución

🔧 Requisitos Previos

Docker instalado.

Acceso a Docker Hub (opcional si se desea subir la imagen).

#PASO A PASO PARA EJECTUR EN PLAY WITH DOCKER
1. apk update && apk add git
2. git clone https://github.com/JP1604/final.git
3. mkdir logs
4. cd final 
5. docker build -t builder
6. docker run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/logs:/app/logs \
  --privileged \
    builder

#MIEMBROS DEL GRUPO
Juan Pablo Pérez
Andres Felipe Pérez 

#ENLACE DE LOS REPOSITORIOS 
repositorio base: https://github.com/JP1604/final.git
repositorio lenguajes: https://github.com/JP1604/dockerlanguages.git


