#!/bin/sh

echo "Cleaning up existing containers"
docker rm -f demo-backend demo-frontend 2>/dev/null || true

echo "Removing existing images"
docker rmi demo-backend:1 demo-frontend:1 2>/dev/null || true

echo "Cleanup completed."