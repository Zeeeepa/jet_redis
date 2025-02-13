redis-server redis.conf &
echo "Started redis server at port 6380"

# Start Docker Compose services
docker compose -f /Users/jethroestrada/Desktop/External_Projects/Jet_Projects/local-search/docker-compose.searxng.yaml up -d
