# Docker networks PoC

This project contains a Dockerized application with a React frontend served by Nginx and a FastAPI backend.

## Project Overview

- **Frontend**: Located in `/frontend`. Uses a multi-stage Docker build (Node.js for build, Nginx for serving).
- **Backend**: Located in `/backend`. Python FastAPI application.

For a deeper dive into the architecture and configuration details, see [context/index.md](context/index.md).

## 🛠️ Tech Stack

- **Frontend**: [React](https://reactjs.org/) + [Vite](https://vitejs.dev/) served by [Nginx](https://www.nginx.com/)
- **Backend**: [FastAPI](https://fastapi.tiangolo.com/) (Python 3.11)
- **Containerization**: Docker

<!-- Valid Badges for your stack -->

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)
![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- **Docker** is installed and running.
    - For Desktop: [Download Docker Desktop](https://www.docker.com/products/docker-desktop)
    - For Servers/VMs: Ensure Docker Engine and Docker CLI are installed.
- **Git** is installed.

## 📂 Project Structure

```text
├── backend/            # FastAPI application
│   ├── main.py        # API Entry point
│   └── Dockerfile     # Python runtime setup
├── frontend/          # React application
│   ├── src/           # Component source code
│   ├── nginx.conf     # Nginx server config
│   └── Dockerfile     # Multi-stage build setup
├── context/           # Architecture diagrams and docs
├── startup.sh         # One-click setup script
└── cleanup.sh         # One-click teardown script
```

## Quick Start

We have simplified the setup and teardown process with shell scripts.

### 1. Setup

To build the images and start the containers, simply run:

```bash
./startup.sh
```

This script will:

- Create a docker network `demo-net`.
- Build the `demo-backend:dev` and `demo-frontend:dev` images.
- Start the backend container (internal).
- Start the frontend container, mapped to **host port 3000**.

**Access:**

- Frontend: [http://localhost:3000](http://localhost:3000)

### 2. Cleanup

To stop and remove all containers, images, and networks created by this project:

```bash
./cleanup.sh
```

## 🐛 Troubleshooting

**"Bind for 0.0.0.0:3000 failed: port is already allocated"**

> If you see this error, another service is using port 3000. Stop the other service or edit `startup.sh` to map to a different host port (e.g., `-p 3001:80`).

**"Permission denied" when running scripts**

> If you encounter a permission denied error, run the following command to make the scripts executable:
>
> ```bash
> chmod +x startup.sh cleanup.sh
> ```

**Docker connection issues**

> If commands fail, ensure the Docker daemon is running and accessible:
> ```bash
> docker --version
> docker info
> ```
