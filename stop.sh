sh search/stop.sh
sh scraped_urls/stop.sh
sh local_search/stop.sh
sh ollama_models/stop.sh

launchctl stop homebrew.mxcl.redis
kill -9 $(lsof -ti:6379)
kill -9 $(ps aux | grep '[r]edis-server' | awk '{print $2}')