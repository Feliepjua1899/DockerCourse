# ⚡ Frontend - Vite + React
![Vite](https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![React](https://img.shields.io/badge/React-61DAFB?style=for-the-badge&logo=react&logoColor=black)
![Ant Design](https://img.shields.io/badge/Ant%20Design-0170FE?style=for-the-badge&logo=ant-design&logoColor=white)

**Frontend de TodoDocker desarrollado con Vite, React y Ant Design**

## 🚀 Configuración Inicial
### 1. Instalar dependencias

```bash
npm install
```
### 2. Configurar variables de entorno
Crea un archivo .env en la raíz del frontend (basado en .env.example):

```env
# URL de la API (Backend)
VITE_API_URL=http://localhost:8000
```
## 💻 Comandos principales

| Comando | Descripción |
|:-----|------:|
| `npm run dev`   | Inicia servidor de desarrollo (_localhost:5173_) |
| `npm run build`   |  Genera versión para producción (en _/dist_) |
| `npm run preview`  | Sirve el build de producción (_localhost:4174_) |


## 🔧 Troubleshooting
### ❌ "Invalid API URL"

- Verifica que el backend esté corriendo.
- Revisa que no haya errores en .env (sin espacios alrededor de =).

## 💡 Tips de Desarrollo
- ✅ En desarrollo, Vite recarga automáticamente los cambios.
- ✅ Para producción:

```bash
npm run build && npm run preview
```
¡Listo! El frontend debería funcionar en:

- Desarrollo: http://localhost:5173
- Preview: http://localhost:4174