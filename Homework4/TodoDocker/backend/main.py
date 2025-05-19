import logging
import os
from fastapi import FastAPI
from routes.task import task
from fastapi.middleware.cors import CORSMiddleware
from decouple import config
import socket

app = FastAPI()

# carpeta donde se guardan los logs
LOG_DIR = "/app/data/logs"

os.makedirs(LOG_DIR, exist_ok=True)
logging.basicConfig(
    filename=f"{LOG_DIR}/api.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Configurcacion para el registro de las peticiones
@app.middleware("http")
async def log_requests(request, call_next):
    response = await call_next(request)
    logging.info(f"{request.method} {request.url.path} - Status: {response.status_code}")
    return response

# Configuracion desde variables, ya no env
origins = os.getenv("FRONTEND_URL", "").split(",")
print("Orígenes permitidos (CORS):", origins)

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/info")
def get_info():
    return {
        "hostname": socket.gethostname(),
        "ip": socket.gethostbyname(socket.gethostname()),
        "message": "¡Endpoint de información del contenedor!"
    }

@app.get("/")
def welcome():
    return {"message": "Welcome to the API!"}

app.include_router(task)