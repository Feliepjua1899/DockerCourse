# 🐳 TodoDocker - Despliegue con Docker
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)

## Proyecto FullStack contenerizado:
- ✅ Backend: Python + FastAPI (API REST)
- ✅ Frontend: Vite + React (Ant Design)
- ✅ Base de datos: MongoDB (local o Atlas)

## 📋 Requisitos Previos

| Tecnología |  Versión Mínima  | Comando de Verificación |
|:-----|:--------:|------:|
| Docker   | _v24.0+_ | `docker --version` |
| Docker Compose   |  _v2.0+_  |  `docker compose version`  |
| Node.js   | _v22.0+_ |    `node --version` |
| Node.js   | _v3.13+_ |    `python --version` |



## 🚀 Despliegue Paso a Paso
1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/Feliepjua1899/DockerCourse.git
cd Homework3/TodoDocker
```

2️⃣ Configurar Variables de Entorno
📂 Crear .env (basado en .env.example)
```env
# 🖥️ Frontend (Vite)
VITE_API=http://localhost:8000  # URL del backend

# ⚙️ Backend (FastAPI)
MONGO_URL=mongodb://localhost:27017  # MongoDB local
# MONGO_URL=mongodb+srv://user:pass@cluster.mongodb.net/db?retryWrites=true&w=majority  # MongoDB Atlas
FRONTEND_URL=http://localhost:5173,http://localhost:4174
```
3️⃣ Construir las Imágenes de Docker
```bash
docker compose build
```
(Esto creará las imágenes para frontend y backend según sus Dockerfile)

4️⃣ Levantar los Contenedores
```bash
docker compose up -d
```
(El flag -d ejecuta en segundo plano, si quieres ver los logs quitalo)

5️⃣ Verificar que Todo Funcione

| Servicio | URL de Acceso |
|:-----|------:|
| Frontend (Vite)   | _http://localhost:5173_ (Dev) |
| Frontend (Preview)   |  _http://localhost:4174_ (Build) |
| Backend (FastAPI)  | _http://localhost:8000_ |


## 🔧 Comandos Útiles

| Comando | Descripción |
|:-----|------:|
| `docker compose logs -f`   | Ver logs en tiempo real |
| `docker compose down`   |  Detener y eliminar contenedores |
| `docker compose ps`  | Listar contenedores en ejecución |


## 📦 Estructura del Proyecto
```
Proyecto/
├── frontend/            # 🎨 Vite + React
│   ├── Dockerfile       # Config. Docker para frontend
│   ├── package.json     # Dependencias JS
│   ├── .env             # 🔐 Variables de entorno para frontend
│   └── src/             # Código fuente
├── backend/             # 🐍 FastAPI
│   ├── Dockerfile       # Config. Docker para backend
│   ├── requirements.txt # Dependencias Python
│   ├── main.py          # 🚀 Punto de entrada de la API FastAPI
│   ├── .env             # 🔐 Variables de entorno para backend
│   └── routes/          # 🔄 Definición de las rutas de la API
└── docker-compose.yml   # 🐳 Orquestación de contenedores
```
## 💡 Troubleshooting
### ❌ Error: Puerto en Uso
Si falla al iniciar, verifica que los puertos 5173, 4174 y 8000 estén libres.

### ❌ MongoDB no Conecta
- Si usas MongoDB local, asegúrate de tener el servicio corriendo.
- Si usas Atlas, verifica que la URL tenga el formato correcto, ademas de agregar tu ip a **_Network Access_** de tu Cluster, para que te permita los request.

### ❌ Problemas con Docker Cache
Si hay cambios y no se reflejan:

```bash
docker compose build --no-cache && docker compose up -d
```
## ⚡ Revisemos
¡Listo! El frontend debería funcionar en:
- frontend Info : http://localhost:4174/info
![Info](image.png)

- frontend Tasks : http://localhost:4174
![Tasks](image-1.png)