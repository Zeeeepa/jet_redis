# Get the directory where the script is located
FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Start Redis server using local config
redis-server "${FILE_DIR}/redis.conf" &
echo "Started redis server at port 6380"

# Check for existing container and remove if found
CONTAINER_NAME="searxng"
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
  echo "Removing existing container: ${CONTAINER_NAME}"
  docker rm -f ${CONTAINER_NAME}
fi

# Start Docker Compose services
colima start
docker-compose -f "${FILE_DIR}/docker-compose.searxng.yaml" up -d
# docker compose -f "${FILE_DIR}/docker-compose.searxng.yaml" up -d
