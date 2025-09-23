#!/bin/zsh
# stop-redis.sh: Cleanly stop Redis
set -e

# Define paths
REDIS_DIR="$HOME/src/redis-8.0.0"
PID_FILE="$REDIS_DIR/run/redis_6379.pid"
REDIS_CLI="$REDIS_DIR/build_dir/bin/redis-cli"

# Check if Redis is running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE" 2>/dev/null)
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Stopping Redis (PID $PID)..."
        "$REDIS_CLI" SHUTDOWN
        # Wait for Redis to stop
        for i in {1..5}; do
            if ! ps -p "$PID" > /dev/null 2>&1; then
                echo "Redis stopped successfully."
                rm -f "$PID_FILE"
                exit 0
            fi
            sleep 1
        done
        echo "Redis did not stop gracefully. Killing process $PID..."
        kill -9 "$PID" 2>/dev/null
        rm -f "$PID_FILE"
    else
        echo "Stale PID file found. Removing $PID_FILE..."
        rm -f "$PID_FILE"
    fi
else
    echo "Redis is not running (no PID file found)."
fi

# Check if port is still in use
if nc -z 127.0.0.1 6379 > /dev/null 2>&1; then
    echo "Port 6379 is still in use. Please check for other Redis instances."
    exit 1
fi

echo "Redis is stopped."