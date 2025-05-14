from fastapi import FastAPI
from routes.task import task
from fastapi.middleware.cors import CORSMiddleware
from decouple import config
import socket

app = FastAPI()

frontend_urls = config("FRONTEND_URL")
origins = [url.strip() for url in frontend_urls.split(",")]
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