# React (Nginx) + FastAPI (Docker) — Iteration 1

## Goal

- Run React frontend in one container (served by Nginx)
- Run FastAPI in another container
- Browser calls FastAPI at `http://localhost:8000`
- Frontend served at `http://localhost:3000`

---

## 1) Build images

### Backend

```bash
cd backend
docker build -t demo-backend:1 .
```

```bash
cd ../frontend
docker build -t demo-frontend:1 .
```
