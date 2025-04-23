#!/bin/bash

# Ejercicio 1:

## 1. Instalacion de docker

### Configuracion del repositorio apt 
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

### Instalacion latest-version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Verificar la instalacion
sudo docker run hello-world

## 2. Habilitar e iniciar servicio

sudo systemctl enable docker
sudo systemctl start docker

## 3. Imprimir infromacion del cliente y del servido
### No podemos ver la infromacion del server por permisos
docker info
### Si ejecutamos con sudo, podemos ver los datos del server
sudo docker info

## 4. Extra agregar docker a sudo, para evitar usar el sudoi todo el tiempo
### Agregamos el usuario ubuntu al grupo docker con sudo
sudo usermod -aG docker ubuntu
### nos salimos para que los cambios tengan efecto
logout
### verificamos que somos parte del grupo docker
groups

### Verificamos que podamos ejecutar comando sin el sudo
### Ahora podemos ver la ifnroacion del server sin necesidad del sudo
docker info


# Ejercicio 2:
## 1. Busqueda de repositorio oficiales

docker search --filter is-official=true ubuntu
docker search --filter is-official=true alpine
docker search --filter is-official=true nginx

## 2. obtener imagen oficialde ngnix y correr un contenedor
docker pull nginx

docker run --name nginx-container -d -p 8080:80 nginx


# Ejercicio 3:

## 1. Revisar el estado de dokcer daemon
sudo systemctl status docker

## 2. Detener docker daemon
sudo systemctl stop docker

## 2. 5 revisar el status de nuevo
sudo systemctl status docker

## 3. Ejcutar un contener mientras esta en stop
docker run hello-world

## 4. restart y volver hace correr el contendor
sudo systemctl start docker
docker run hello-world


# Ejercicio 4:

## 1. Correr un contenedor de ubutnu de manera interactiva
## -it interactivo, con el nombre, la imagen y el shell a ejecutar dentro
## Como es nuestra primera vez usando ubuntu hara un pull de la imagen
docker run -it --name ubuntu_container ubuntu bash

## 2. Ejcutar apt update e instalar curl adentro
apt update && apt install -y curl

## 3. salir del contenedor
exit


# Ejercicio 5:

## 1. losta de contenedores
docker ps
## lista de contenedores incluidos los exited
docker ps -a

# Ejercicio 6:
## 1. Ejecutar un contenedor en segundo plano 
## agregamos el sleep para que no se cierre de inmediato y este vivo al menos por 300 segundos
docker run -d --name lifecycle alpine sleep 300

## 2. Pausar el contenedor
docker pause lifecycle

## 3. Reanudar el contenedor
docker unpause lifecycle

## 4. Detener el contenedor
docker stop lifecycle

## 5. Reiniciar el contenedor
docker restart lifecycle

## 6. Forzar la terminación del contenedor (kill)
docker kill lifecycle

### comando para ver los diferentrs cambios de esta es un ps -a con un filter para solo mostrar el nombre y el status 
docker ps -a --filter "name=lifecycle" --format "table {{.Names}}\t{{.Status}}"

# Ejercicio 7:

## 1. Eliminar un contendor corriendo
### como en el anteior lo maramos primero le haremos un restart
docker restart lifecycle

### ahora lo eliminamos, tenemos que forzarlo, porque esta corriendo, el comando normal fallaria
docker rm -f lifecycle 

# Ejercicio 8:

## 1. Descaragr las imagenes de alpine y ubuntu
### gracias a los ejericio anteiores ya tenemos ambas imagenes, pero este seria el comando pra obtenerlos 
docker pull alpine  
docker pull ubuntu 

## 2. mostrar la lista de imagenes
docker images

# Ejercicio 9:

### No se si este ejecicio es solo par aejecutar comando o para probar el caso de uso que despues de ejecutar el comando se elimine asi que hare uno, en el que el contenedor permanecera y otr oen el que se eliminara

## 1. Ejecutar alpine con comando echo (se mantiene)
docker run --name alpine_hello alpine echo "hello from alpine"

## 2. ejecutar busybox con comando uname (se elimina)
### como no teniamos la imagen de busybox, la descargara
docker run --rm busybox uname -a

## 3. listas contendores
### El de alpine que no corrimos con rm, se peude ver, el de busybox no
docker ps -a


# Ejercicio 10:

## 1. eliminar todos los contendores detenidos
### como en mi caso todos estan exit, hare correr algunos
docker start d15933aef7c3  # ubuntu
docker start 04981dc26ed6  # nginx
docker container prune

## 2. eliminar imagenes no utilizadas

### listo las imagenes antes yd espues para la comparativa
docker images
docker image prune - a
docker images

## 3. inspeccionar el uso del disco de docker
docker system df

