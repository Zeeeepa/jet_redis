if [ ! -f .env ]; then
  cp -RPp .env.example .env
  echo "Copied .env.example to .env"
else
  echo ".env file already exists. Skipping copy."
fi
REDIS_PATH="/Users/jethroestrada/redis/scraped_urls"
REDIS_TMP="$REDIS_PATH/tmp"
REDIS_DATA="$REDIS_PATH/data"
REDIS_RUN="$REDIS_PATH/run"
REDIS_LOGS="$REDIS_PATH/logs"
REDIS_LOG_FILE="$REDIS_LOGS/redis.log"
REDIS_PID_FILE="$REDIS_RUN/redis.pid"
REDIS_IPC_SOCKET="$REDIS_TMP/redis.sock"
mkdir -p "$REDIS_DATA"
mkdir -p "$REDIS_LOGS"
mkdir -p "$REDIS_RUN"
mkdir -p "$REDIS_TMP"
if [ ! -e "$REDIS_LOG_FILE" ]; then
  touch "$REDIS_LOG_FILE"
  echo "Created log file at $REDIS_LOG_FILE"
fi
if [ ! -e "$REDIS_PID_FILE" ]; then
  touch "$REDIS_PID_FILE"
  echo "Created pid file at $REDIS_PID_FILE"
fi
if [ ! -e "$REDIS_IPC_SOCKET" ]; then
  touch "$REDIS_IPC_SOCKET"
  echo "Created temporary IPC socket file at $REDIS_IPC_SOCKET"
fi
chmod -R 777 "$REDIS_PATH"
echo "Redis directories, files and IPC socket are created, and permissions are set."
