redis-cli -p 6380 shutdown
echo "Stopped redis server from port 6380"

docker compose -f docker-compose.searxng.yaml stop