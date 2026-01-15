#!/bin/sh
set -e

PROJECT_PREFIX="demo"

echo "Stopping and removing containers..."
docker ps -a --filter "name=${PROJECT_PREFIX}-" --format "{{.ID}}" | xargs -r docker rm -f

echo "Removing images for project..."
docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}" \
  | grep "^${PROJECT_PREFIX}-" \
  | awk '{print $2}' \
  | xargs -r docker rmi -f

echo "Cleanup completed successfully."
