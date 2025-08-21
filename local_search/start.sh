# Get the directory where the script is located
FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Start Redis server using local config
redis-server "${FILE_DIR}/redis.conf" &
echo "Started redis server at port 6380"

# Function to check if docker command is available
wait_for_docker() {
  local timeout=30
  local count=0
  echo "Checking for docker command availability..."
  until docker info >/dev/null 2>&1; do
    if [ $count -ge $timeout ]; then
      echo "Error: Docker is not available after ${timeout} seconds"
      exit 1
    fi
    echo "Waiting for Docker to be ready..."
    sleep 1
    ((count++))
  done
  echo "Docker is ready"
}

# Check for existing container and remove if found
CONTAINER_NAME="searxng"
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
  echo "Removing existing container: ${CONTAINER_NAME}"
  docker rm -f ${CONTAINER_NAME}
fi

# Start Colima and wait for Docker to be ready
colima start
# wait_for_docker
docker-compose -f "${FILE_DIR}/docker-compose.searxng.yaml" up -d
# docker compose -f "${FILE_DIR}/docker-compose.searxng.yaml" up -d
