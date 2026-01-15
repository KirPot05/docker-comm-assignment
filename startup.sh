#!/bin/sh
set -e

BACKEND_IMAGE="demo-backend:1"
FRONTEND_IMAGE="demo-frontend:1"

BACKEND_CONTAINER="demo-backend"
FRONTEND_CONTAINER="demo-frontend"

echo "Stopping existing containers (if any)..."
docker rm -f $BACKEND_CONTAINER $FRONTEND_CONTAINER 2>/dev/null || true

echo "Building backend image..."
docker build -t $BACKEND_IMAGE ./backend

echo "Building frontend image..."
docker build -t $FRONTEND_IMAGE ./frontend

echo "Starting backend container..."
docker run -d \
  --name $BACKEND_CONTAINER \
  -p 8000:8000 \
  $BACKEND_IMAGE

echo "Starting frontend container..."
docker run -d \
  --name $FRONTEND_CONTAINER \
  -p 3000:80 \
  $FRONTEND_IMAGE

echo ""
echo "System is up:"
echo "Frontend → http://localhost:3000"
echo "Backend  → http://localhost:8000"
