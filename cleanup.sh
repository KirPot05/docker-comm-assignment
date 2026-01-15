#!/bin/sh
set -e

PROJECT_PREFIX="demo"
NETWORK_NAME="${PROJECT_PREFIX}-net"

echo "Stopping and removing containers..."
docker ps -a --filter "name=${PROJECT_PREFIX}-" --format "{{.ID}}" | xargs -r docker rm -f

echo "Removing images for project..."
docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}" \
  | grep "^${PROJECT_PREFIX}-" \
  | awk '{print $2}' \
  | xargs -r docker rmi -f

echo "Removing network (if exists): ${NETWORK_NAME} ..."
docker network rm "${NETWORK_NAME}" 2>/dev/null || true

echo "Cleanup completed successfully."
