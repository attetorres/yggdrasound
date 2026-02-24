## 🛠️ Stack

![React](https://img.shields.io/badge/React-20232A?logo=react&logoColor=61DAFB)
![Zustand](https://img.shields.io/badge/Zustand-443e38?logo=react&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-646CFF?logo=vite&logoColor=white)
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=flat-square&logo=node.js&logoColor=white)
![Express](https://img.shields.io/badge/Express-000000?logo=express&logoColor=white)
![Sequelize](https://img.shields.io/badge/Sequelize-52B0E7?logo=sequelize&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?logo=docker&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-000000?logo=json-web-tokens&logoColor=white)
![Netlify](https://img.shields.io/badge/Netlify-00C7B7?logo=netlify&logoColor=white)
![Render](https://img.shields.io/badge/Render-46E3B7?logo=render&logoColor=white)


# Yggdrasound 

Plataforma full-stack de e-commerce de vinilos con búsqueda de conciertos en tiempo real.

 **Demo:** [Frontend](https://yggdrasound.netlify.app/) | [Backend](https://yggdrasound-backend.onrender.com/)

---

##  Características

- **Catálogo** de vinilos con filtros y tracklists
- **"Buscar Shows"** - scraping en Bandcamp para encontrar conciertos
- **Carrito, wishlist e historial** de pedidos
- **Panel admin** para gestionar catálogo y comentarios
- **Auth segura** con JWT y bcrypt

---

## 🚀 Despliegue rápido con Docker
### Opción A: Docker (recomendada)
1. Clonar el repositorio: `git clone https://github.com/attetorres/yggdrasound.git`
2. Entrar a la carpeta: `cd yggdrasound`
3. Crear archivo `./backend/.env` con:
   - DB_NAME=ygdrasound_db
   - DB_USER=postgres
   - DB_PASSWORD=ygdrasound_password
   - DB_HOST=postgres
   - JWT_SECRET=tu_secreto
4. Ejecutar: `docker-compose up --build`
5. Acceder a: `http://localhost:5173`

### Opción B: Manual

**Base de datos**
- Ejecutar: `psql -U usuario -d yggdrasound_db -f yggdrasound_dump.sql`

**Backend**
- `cd backend`
- `npm install`
- Configurar `.env` con DB_HOST=localhost
- `npm start` (puerto 3000)

**Frontend**
- `cd frontend`
- `npm install`
- Crear `.env` con VITE_API_URL=http://localhost:3000
- `npm run dev` (puerto 5173)