#!/bin/sh
set -e

# ===== Config =====
NETWORK_NAME="demo-net"

BACKEND_IMAGE="demo-backend:dev"
FRONTEND_IMAGE="demo-frontend:dev"

BACKEND_CONTAINER="demo-backend"
FRONTEND_CONTAINER="demo-frontend"

# ===== Cleanup =====
echo "Stopping existing containers (if any)..."
docker rm -f $BACKEND_CONTAINER $FRONTEND_CONTAINER 2>/dev/null || true

# ===== Network =====
echo "Ensuring Docker network exists..."
docker network create $NETWORK_NAME 2>/dev/null || true

# ===== Build Images =====
echo "Building backend image..."
docker build -t $BACKEND_IMAGE ./backend

echo "Building frontend image..."
docker build -t $FRONTEND_IMAGE ./frontend

# ===== Run Backend (NO port exposure) =====
echo "Starting backend container (internal only)..."
docker run -d \
  --name $BACKEND_CONTAINER \
  --network $NETWORK_NAME \
  $BACKEND_IMAGE

# ===== Run Frontend (public) =====
echo "Starting frontend container..."
docker run -d \
  --name $FRONTEND_CONTAINER \
  --network $NETWORK_NAME \
  -p 3000:80 \
  $FRONTEND_IMAGE

# ===== Info =====
echo ""
echo "System is up:"
echo "Frontend → http://localhost:3000"
echo "Backend  → internal (reachable via Nginx at /api)"
