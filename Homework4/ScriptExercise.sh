#!/bin/bash

# =============================================
# CONSTRUCCIÓN DE IMÁGENES LOCALES
# =============================================

# Como mencione en el documento, hice otra version de imagenes para mi codigo,
# uno para hacer una version mas limpia y 2 para creaar una carpeta donde guardar los logs
# Asi que esta seccion es apra contruir mis imagenes y poder probarlas localmente anets de subirlas


# Construir imagen del backend
docker build -t mi-backend:1.0 ./backend

# Construir imagen del frontend
docker build -t mi-frontend:1.0 ./frontend

# =============================================
# MANEJO DEL REGISTRY PRIVADO
# =============================================

# Autenticación en el registry de Jala
docker login docker.jala.pro --username 'robot$docker-training+rebeca.pereira' --password 'SECRET'


# Una vez que probe que todo estaba funcionando bien, cree las imagens con tag
# para subirlas al registry

# Etiquetado para el registry
docker tag mi-backend:1.0 docker.jala.pro/docker-training/backend:rebeca.pereira-v2
docker tag mi-frontend:1.0 docker.jala.pro/docker-training/frontend:rebeca.pereira-v2

# Subir imágenes al registry
docker push docker.jala.pro/docker-training/backend:rebeca.pereira-v2
docker push docker.jala.pro/docker-training/frontend:rebeca.pereira-v2

# Verificar imágenes subidas
curl -u 'robot$docker-training+rebeca.pereira:SECRET' https://docker.jala.pro/v2/docker-training/backend/tags/list
curl -u 'robot$docker-training+rebeca.pereira:SECRET' https://docker.jala.pro/v2/docker-training/frontend/tags/list

# ahora podremos ver que existen 2 bajo mi nombre, una con el rebeca.pereira-v2 y otra con el rebeca.pereira

# =============================================
# DOCKER COMPOSE (PRODUCCIÓN/EVIDENCIA)
# =============================================

# Levantar servicios con imágenes del registry

# Antes de eso elimino cualquier que tenga en mi local, para asi asegurarme de que use las del registry
# ademas es una limpieza completa de todo, imagenes, contenedore y volumenes
docker compose down -v 
docker system prune -a -f 

# Y ahora levanto los servicio, pero obligando la reconstruccionde las imagenes,
# de neuvo esto por si acaso, haya encontrado uno en local.

docker compose up --build  

# =============================================
# VERIFICACIÓN DE SERVICIOS
# =============================================

# Ver logs del backend (persistidos en volumen)
docker compose logs backend
docker compose exec backend cat /app/data/logs/api.log

# Ver datos en MongoDB
docker compose exec mongodb mongosh -u admin -p password --eval "use taskdatabase; db.tasks.find().pretty()"

# Probar comunicación entre servicios
docker compose exec frontend curl -s http://backend:8000/info

# Inspeccionar red personalizada
docker network inspect app-network

# Inspeccionar volúmenes
docker volume inspect mongodb-data backend-logs

# recordar que esto esta sujeto a los nombres de cada uno, ya sea contenedores, volúmenes, imágenes, etc.
