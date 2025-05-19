# --- Etapa de construcción ---
FROM python:3.13-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# --- Etapa final ---
FROM python:3.13-slim
WORKDIR /app

# Copia dependencias instaladas
COPY --from=builder /root/.local /root/.local
COPY . .

# Configura PATH para pip
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Crea directorio para logs (como root, sin cambiar owner)
RUN mkdir -p /app/data/logs

# ¡Ejecuta como root! (solo para esta tarea)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]