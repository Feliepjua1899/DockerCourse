#!/bin/bash

# Ejercicio 1:

## 1. Listar todas las redes Docker disponibles en el sistema
docker network ls

## 2. Mostrar información detallada de la red bridge por defecto
docker network inspect bridge

## 3. Crear una nueva red bridge definida por el usuario
docker network create --driver bridge my-bridge-network

## 4. Ejecutar un contenedor Nginx conectado a la red creada
docker run --name nginx-net --network my-bridge-network -d nginx

## Verificar la configuración de red del contenedor
docker network inspect my-bridge-network


# Ejercicio 2:

## creamos los 2 contenedores Nginx conectados a la red bridge definida, y lo ejecutamos en segundo plano 
docker run -d --name nginx1 --network my-bridge-network nginx

docker run -d --name nginx2 --network my-bridge-network nginx

## quize hacer ping pero tuve un error de que no se tenia establecido el ping, asi que instale el ping para cada uno y despues funciono
docker exec nginx1 apt-get update
docker exec nginx1 apt-get install -y iputils-ping

docker exec nginx2 apt-get update
docker exec nginx2 apt-get install -y iputils-ping

# 2. Usar ping dentro de ambos contenedores para probar la comunicación usando los nombres de contenedor

docker exec nginx1 ping -c 4 nginx2
docker exec nginx2 ping -c 4 nginx1

# Ejercicio 3:

## 1. Crear un volumen llamado mydata
docker volume create mydata

## 2. Ejecutar un contenedor con el volumen montado en /data.
## en este caso estoy usando alpine para evitar posibles problemas de cosas que nos faltan instalar.
docker run -dit --name test-volume --mount source=mydata,target=/data alpine sh

# 3. Escribir un archivo dentro del volumen desde el contenedor, en este caso con un mensaje simple para probar la persistencia.
docker exec test-volume sh -c "echo 'Hola desde el volumen' > /data/archivo.txt"
# 3.1 Detener el contenedor
docker stop test-volume

# 3.2 Volver a iniciar el contenedor y verificar la persistencia
docker start test-volume
docker exec test-volume cat /data/archivo.txt


# Ejercicio 4:

## 1. Crear un directorio en el host que usaremos como punto de montaje, este sera nuestro contenedor compartido.
mkdir -p ~/docker-mount-test

## 2. Ejecutar un contenedor con ese directorio montado en /mnt, de nuevo usaremos alpine.
docker run -dit --name bind-test -v ~/docker-mount-test:/mnt alpine sh

## 3. Crear un archivo desde el contenedor en /mnt
docker exec bind-test sh -c "echo 'Archivo creado desde el contenedor' > /mnt/desde-contenedor.txt"

## 4. Comprobar desde el host que el archivo fue creado
cat ~/docker-mount-test/desde-contenedor.txt

# Ejercicio 5:

## 1. Crear un archivo dentro del volumen nombrado
## reutilizare mydata, para no generar tantod volumenes y contendores, usare el --rm para eliminar el contenedor al terminar
docker run --rm --name write-to-volume --mount source=mydata,target=/data alpine sh -c "echo 'Desde volumen' > /data/archivo-volumen.txt"

## 2. Crear un archivo usando bind mount (reutilizamos ~/docker-mount-test), lo mismo que antes pero con bind mount
docker run --rm --name write-to-bind -v ~/docker-mount-test:/mnt alpine sh -c "echo 'Desde bind mount' > /mnt/archivo-bind.txt"

## 3. Observar dónde está almacenado el volumen en el host
docker volume inspect mydata
## Mostrar contenido del bind mount directamente desde el host
ls -l ~/docker-mount-test
sudo ls -l /var/lib/docker/volumes/mydata/_data

# Ejercicio 6:

## 1. Ejecutar un contenedor Ubuntu con Docker instalado y acceso al demonio Docker del host.
## para los permisos, le damos el priviled y ademas compartimos el host
docker run -dit --name dind-ubuntu --privileged -v /var/run/docker.sock:/var/run/docker.sock ubuntu bash

## 2. Instalar Docker dentro del contenedor
docker exec dind-ubuntu apt-get update
docker exec dind-ubuntu apt-get install -y docker.io

## 3. Verificar que Docker funciona dentro del contenedor
docker exec dind-ubuntu docker version

# Ejercicio 7:

## 1. Ejecutamos un contenedor con límite de memoria de 256 MB y 0.5 CPU y lo manenemos vivo por 300 segundo
docker run -d --name limited_container --memory=256m --cpus="0.5" alpine sleep 300

## 2. Mostramos el uso de recursos (CPU, memoria, etc.) de los contenedores y no btenemos los datos en tiempo real, solo una vez
docker stats --no-stream

## 3. Revisamos el uso de disco del sistema Docker
docker system df


# Ejercicio 8:

## 1. Ejecutamos un contenedor con política de reinicio --restart on-failure, este supuetsamente solo se reiniciare si falla, por eso colcoamos el exit 1.
docker run -d --name test_on_failure --restart on-failure alpine sh -c "exit 1"

## verificamos su estado y vemos que efecitvamente esta haciendo reboot
docker ps -a | grep test_on_failure

## 2. Matamos el contenedor manualmente
## Como la política es on-failure, y nosotros lo matamos (no falló solo), entonces no deberia reinicarse
docker kill test_on_failure

## Verificamos el estado y efecitvamnte ahora esta en exited
docker ps -a | grep test_on_failure

## Limpiamos el contenedor anterior, solo para mantener limpio y no tener tantas cosas
docker rm -f test_on_failure

## 3. Ejecutamos otro contenedor con la política --restart unless-stopped, significa que no reicinara si el sistema se renicia hasta que lo detengamos manualmente
docker run -d --name test_unless_stopped --restart unless-stopped alpine sleep 300

## Verificamos que esté corriendo correctamente
docker ps | grep test_unless_stopped

## reiniciamos nuestro sistema 
sudo reboot

## 4. Verificamos el estado del contenedor después del reinicio, y vemos que efectivmante este arranca de manera automatica, por que lo detuvimos manualmente

docker ps | grep test_unless_stopped

# Ejercicio 9:

## Creamos la red dbnet
docker network create dbnet

## Creamos el volumen dbdata
docker volume create dbdata

## Ejecutamos el contenedor de MariaDB conectado a la red y volumen, sin exponer puertos
docker run -d --name mariadb -v dbdata:/var/lib/mysql --network dbnet -e MARIADB_ROOT_PASSWORD=mysecretpassword -e MARIADB_DATABASE=mydb -e MARIADB_USER=myuser -e MARIADB_PASSWORD=mypassword mariadb:latest

# Ejercicio 10:

# Ejecutamos el contenedor de PHPMyAdmin, y colocamos como host a mariadb 
docker run -d --name phpmyadmin --network dbnet -v phpmyadmin_config:/etc/phpmyadmin -e PMA_HOST=mariadb -p 8080:80 phpmyadmin:latest


## en este ultimo ejericio me salio recien a la tercer, donde revie configuracion, de red, volumnes los logs y no entendi porque me salia un error de autenticacion, asi que al final termine haciendo todo nuevamente, pero me salio, incluso hice la prueba levantando el contendor de phpmyadmin ya con un usuario logueado, porque no entendi porque, cuando lo hcie, y me funciono ya ude deternelo eliminarlo y ejecutar nuevmante con la confugracion sin espeficiar los dats de un usuario especifico y funcino, hice la prueba tanto con root como con mi usuario.