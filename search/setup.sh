#!/bin/bash

# Check if .env already exists
if [ ! -f .env ]; then
  # Copy .env.example to .env if .env doesn't exist
  cp -RPp .env.example .env
  echo "Copied .env.example to .env"
else
  echo ".env file already exists. Skipping copy."
fi

# Define the redis paths relative to the project directory
REDIS_PATH="/Users/jethroestrada/redis/search"
# Dirs
REDIS_TMP="$REDIS_PATH/tmp"
REDIS_DATA="$REDIS_PATH/data"
REDIS_RUN="$REDIS_PATH/run"
REDIS_LOGS="$REDIS_PATH/logs"
# Files
REDIS_LOG_FILE="$REDIS_LOGS/redis.log"
REDIS_PID_FILE="$REDIS_RUN/redis.pid"
# Define temporary IPC socket file
REDIS_IPC_SOCKET="$REDIS_TMP/redis.sock"

# Create redis paths if they do not exist
mkdir -p "$REDIS_DATA"
mkdir -p "$REDIS_LOGS"
mkdir -p "$REDIS_RUN"
mkdir -p "$REDIS_TMP"

# Create log file if it does not exist
if [ ! -e "$REDIS_LOG_FILE" ]; then
  touch "$REDIS_LOG_FILE"
  echo "Created log file at $REDIS_LOG_FILE"
fi

# Create pid file if it does not exist
if [ ! -e "$REDIS_PID_FILE" ]; then
  touch "$REDIS_PID_FILE"
  echo "Created pid file at $REDIS_PID_FILE"
fi

# Create temporary IPC socket file if it does not exist
if [ ! -e "$REDIS_IPC_SOCKET" ]; then
  touch "$REDIS_IPC_SOCKET"
  echo "Created temporary IPC socket file at $REDIS_IPC_SOCKET"
fi

# Set permissions to make directories and the IPC socket accessible by everyone (ownerless)
chmod -R 777 "$REDIS_PATH"   # Grants read/write/execute to everyone

# Optionally, set ownership to "nobody" and "nogroup" (uncomment if needed)
# chown -R nobody:nogroup "$REDIS_PATH"

echo "Redis directories, files and IPC socket are created, and permissions are set."
