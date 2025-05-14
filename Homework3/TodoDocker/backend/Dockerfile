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

# Asegura que las dependencias estén en el PATH
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Puerto expuesto (solo para documentación, el acceso se controla en compose)
EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]