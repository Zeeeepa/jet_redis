sh search/start.sh
sh scraped_urls/start.sh
sh local_search/start.sh
sh ollama_models/start.sh

# # Start redis server at 3103 for Tavily search cache
# redis-stack-server --port 3103 --daemonize yes

# # Start redis server at 6379 for playwright cache
# redis-stack-server --port 6379 --daemonize yes

sh start-redis.sh
