# --- Etapa de construcción ---
FROM node:18-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# --- Etapa de producción ---
FROM node:18-alpine
WORKDIR /app

# Copia solo los archivos necesarios
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

# Instala vite globalmente para el preview
RUN npm install vite -g

# Configuración crítica para Docker
ENV HOST=0.0.0.0
EXPOSE 4173

CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0"]