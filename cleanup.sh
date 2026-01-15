#!/bin/sh

echo "Cleaning up existing containers"
docker rm -f demo-backend demo-frontend 2>/dev/null || true

echo "Removing existing images"
docker rmi demo-backend:v1 demo-frontend:v1 2>/dev/null || true

echo "Cleanup completed."