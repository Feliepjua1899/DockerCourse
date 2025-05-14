#!/bin/bash

# =============================================
# COMANDOS PARA EL BACKEND
# =============================================

# Construir imagen del backend
docker build -t fastapi-backend .

# Ejecutar solo backend (para pruebas con Thunder Client/Postman)
docker run -p 8000:8000 --env-file .env fastapi-backend

# Ejecutar backend sin exponer puerto 
docker run -d --env-file .env fastapi-backend

# Entrar al contenedor del backend
docker exec -it api-container sh

# Probar endpoint /info desde dentro del contenedor
docker exec api-container curl http://localhost:8000/info

# =============================================
# COMANDOS PARA DOCKER COMPOSE
# =============================================

# Hacer build de todos los servicios
docker compose build

# Levantar todos los servicios
docker compose up

# Detener todos los servicios
docker compose down

# Reconstruir imágenes y levantar servicios (cuando hay cambios)
docker compose up --build

# =============================================
# UTILIDADES
# =============================================

# Ver contenedores en ejecución
docker ps 

# Ver todos los contenedores (incluidos los detenidos)
docker ps -a

# Eliminar todos los contenedores detenidos
docker container prune

# Eliminar todas las imágenes no usadas
docker image prune -a

# =============================================
# COMANDOS PARA EL REGISTRY
# =============================================

# Login al registry (usar el secret proporcionado)
echo "SECRET" | docker login docker.jala.pro --username "robot\$docker-training+rebeca.pereira" --password-stdin

# Etiquetado para push (BACKEND)
docker tag fastapi-backend docker.jala.pro/docker-training/backend:rebeca.pereira

# Etiquetado para push (FRONTEND)
docker tag frontend-app docker.jala.pro/docker-training/frontend:rebeca.pereira

# Subir imágenes al registry
docker push docker.jala.pro/docker-training/backend:rebeca.pereira
docker push docker.jala.pro/docker-training/frontend:rebeca.pereira

# Verificar imágenes subidas
curl -u "robot\$docker-training+rebeca.pereira:SECRET" https://docker.jala.pro/v2/docker-training/backend/tags/list
curl -u "robot\$docker-training+rebeca.pereira:SECRET" https://docker.jala.pro/v2/docker-training/frontend/tags/list
