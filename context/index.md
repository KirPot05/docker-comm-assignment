# Project Overview

This project describes a "React (Nginx) + FastAPI (Docker)" application setup, identified as "Iteration 1". The goal is to run a decoupled frontend and backend using Docker containers.

## High-Level Architecture

- **Frontend**: A React application using Vite as the build tool. It is served in production mode using Nginx.
- **Backend**: A Python FastAPI application providing REST API endpoints.

## Docker Setup

The project uses individual `Dockerfile` configurations for each service to build container images.

### Backend Container (`/backend/Dockerfile`)

- **Base Image**: `python:3.11-slim`.
- **Setup**:
  - Installs dependencies from `requirements.txt`.
  - Copies the application source code (`main.py`).
- **Networking**:
  - Exposes port `8000`.
  - Runs the application using `uvicorn` bound to `0.0.0.0` to allow external access.
- **Application Logic**:
  - Exposes two endpoints: `/health` and `/predict`.
  - Configured with generous CORS settings (`allow_origins=["*"]`) to facilitate easy communication during development.

### Frontend Container (`/frontend/Dockerfile`)

Uses a **multi-stage build** optimization:

1.  **Build Stage** (`node:20-alpine`):

    - Installs Node.js dependencies (`npm install`).
    - Builds the React application for production (`npm run build`), generating static assets in `dist/`.

2.  **Runtime Stage** (`nginx:alpine`):
    - Uses the lightweight Alpine-based Nginx image.
    - **Configuration**: Copies a custom `nginx.conf` to `/etc/nginx/conf.d/default.conf`.
    - **Assets**: Copies the built static files from the build stage (`/app/dist`) to the Nginx web root (`/usr/share/nginx/html`).
    - **Networking**: Exposes port `80`.
    - **Command**: starts Nginx in the foreground.

### Nginx Configuration (`/frontend/nginx.conf`)

- Listens on port `80`.
- Serves the static files produced by the React build.
- Includes a fallback strategy (`try_files $uri $uri/ /index.html`) to support Client-Side Routing (SPA functionality), ensuring that direct navigation to sub-routes is handled by the React app's router rather than returning 404s.
