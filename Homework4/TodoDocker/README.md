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



## 🚀 Despliegue en un solo paso
1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/Feliepjua1899/DockerCourse.git
cd Homework4/TodoDocker
docker compose up -d
```

## 🔧 Comandos Útiles

| Comando | Descripción |
|:-----|------:|
| `docker compose logs -f`   | Ver logs en tiempo real |
| `docker compose down`   |  Detener y eliminar contenedores |
| `docker compose ps`  | Listar contenedores en ejecución |

## 🌐 Servicios Disponibles

| Servicio | URL de Acceso |
|:-----|------:|
| Frontend   |  _http://localhost:4173_ |
| Backend   |  _http://localhost:8000_ |
| MongoDB  | _mongodb://admin:password@localhost:27017_ |


## 📦 Estructura del Proyecto
```
Proyecto/
├── frontend/            # 🎨 Vite + React
│   ├── Dockerfile       # Config. Docker para frontend
│   ├── package.json     # Dependencias JS
│   └── src/             # Código fuente
├── backend/             # 🐍 FastAPI
│   ├── Dockerfile       # Config. Docker para backend
│   ├── requirements.txt # Dependencias Python
│   ├── main.py          # 🚀 Punto de entrada de la API FastAPI
│   └── routes/          # 🔄 Definición de las rutas de la API
└── docker-compose.yml   # 🐳 Orquestación de contenedores
```
## 💡 Troubleshooting
### ❌ Error: Puerto en Uso
Si falla al iniciar, verifica que los puertos 4174 y 8000 estén libres.

### ❌ Problemas con Docker Cache
Si hay cambios y no se reflejan:

```bash
docker compose down && docker compose up -d --force-recreate
```
## ⚡ Acceso a la Aplicación
¡Listo! El frontend debería funcionar en:
- frontend Info : http://localhost:4174/info
![Info](image.png)

- frontend Tasks : http://localhost:4174
![Tasks](image-1.png)