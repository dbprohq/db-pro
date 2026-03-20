#!/bin/sh
set -e

# DB Pro Cloud installer
# Usage: curl -fsSL https://install.dbpro.cloud | sh

IMAGE="ghcr.io/dbprohq/dbpro-studio:latest"
CONTAINER_NAME="dbpro-studio"
PORT="${PORT:-4000}"

echo ""
echo "  DB Pro Cloud Installer"
echo "  ========================"
echo ""

# Install Docker if not present
if ! command -v docker >/dev/null 2>&1; then
  echo "  Docker not found. Installing Docker..."
  echo ""
  curl -fsSL https://get.docker.com | sh
  echo ""
fi

# Check if Docker daemon is running
if ! docker info >/dev/null 2>&1; then
  echo "  Error: Docker is not running."
  echo ""
  echo "  Start Docker and try again."
  echo ""
  exit 1
fi

# Remove existing container if present
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "  Pulling latest image..."
docker pull "$IMAGE"

echo "  Starting DB Pro Cloud on port $PORT..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p "$PORT:4000" \
  "$IMAGE" >/dev/null

echo ""
echo "  DB Pro Cloud is running!"
echo ""
echo "  Open http://localhost:$PORT in your browser."
echo ""
echo "  Useful commands:"
echo "    docker logs $CONTAINER_NAME     View logs"
echo "    docker stop $CONTAINER_NAME     Stop"
echo "    docker start $CONTAINER_NAME    Start"
echo ""
