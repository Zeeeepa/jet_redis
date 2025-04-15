# Get the directory where the script is located
FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Start Redis server in the background
redis-server "${FILE_DIR}/redis.conf" &
echo "Started redis server at port 3101"

# PORT=3001
# HOST=127.0.0.1

# exec uvicorn main:app --host "$HOST" --port "$PORT" --forwarded-allow-ips '*' --reload # --reload-dir /Users/jethroestrada/Desktop/External_Projects/AI/chatbot/open-webui/backend/crewAI/apps/search_project/server/main.py