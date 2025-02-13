redis-server search/redis.conf &
echo "Started redis server at port 3101"

redis-server scraped_urls/redis.conf &
echo "Started redis server at port 3102"

redis-server ollama_models/redis.conf &
echo "Started redis server at port 3103"

redis-server local_search/redis.conf &
echo "Started redis server at port 6380"
sh local_search/start.sh
