# 🐍 Backend - FastAPI + MongoDB
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)

**API desarrollada con FastAPI para TodoDocker**

## ⚙️ Configuración Inicial
### 1. Crear entorno virtual (recomendado)
```bash
python -m venv venv
```
**Activar entorno:**


| Servicio | URL de Acceso |
|:-----|------:|
| Linux/Mac   | `venv/bin/activate` |
| Windows   |  `.\venv\Scripts\activate` |


### 2. Instalar dependencias
```bash
pip install -r requirements.txt
```

## 🔐 Variables de Entorno (.env)
Crea un archivo .env basado en .env.example:

```env
# 🛑 ¡Obligatorias!
MONGO_URL=mongodb://localhost:27017  # MongoDB local
# MONGO_URL=mongodb+srv://user:pass@cluster.mongodb.net/db?retryWrites=true&w=majority  # MongoDB Atlas

# 🌐 Configuración CORS (permite conexión desde frontend)
FRONTEND_URL=http://localhost:5173,http://localhost:4174
```

## 🚀 Ejecutar el Servidor
```bash
uvicorn main:app --reload
```
📌 Endpoints clave:

- Info del contenedor: _http://localhost:8000/info_
- Listado de Tareas: _http://localhost:8000/api/tasks_

## 🔧 Troubleshooting
### ❌ Error: "ModuleNotFoundError"
Asegúrate de:
- Tener el entorno virtual activado.
- Haber instalado las dependencias (`pip install -r requirements.txt`).

### ❌ MongoDB no conecta
- Local: Verifica que el servicio esté corriendo
- Atlas: Revisa la URI y que la IP esté en la lista de permitidas.

### ❌ Problemas con CORS
Si el frontend no puede acceder:
- Revisa que FRONTEND_URL en .env tenga las URLs correctas.
