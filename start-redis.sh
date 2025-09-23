#!/bin/zsh
# start-redis.sh: Safely start Redis with all modules
set -e

# Set environment variables
export HOMEBREW_PREFIX="$(brew --prefix)"
export PATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin:$HOMEBREW_PREFIX/opt/llvm@18/bin:$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm@18/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm@18/include"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Define paths
REDIS_DIR="$HOME/src/redis-8.0.0"
PID_FILE="$REDIS_DIR/run/redis_6379.pid"
REDIS_SERVER="$REDIS_DIR/build_dir/bin/redis-server"
CONFIG_FILE="$REDIS_DIR/redis-full.conf"
PORT=6379

# Check if Redis is already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE" 2>/dev/null)
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Redis is already running with PID $PID. Stopping it..."
        "$REDIS_DIR/stop-redis.sh" || {
            echo "Failed to stop Redis. Please check manually."
            exit 1
        }
    else
        echo "Stale PID file found. Removing $PID_FILE..."
        rm -f "$PID_FILE"
    fi
fi

# Check if port is in use
if nc -z 127.0.0.1 "$PORT" > /dev/null 2>&1; then
    echo "Port $PORT is in use. Please ensure no other process is using it."
    exit 1
fi

# Ensure run directory exists
mkdir -p "$REDIS_DIR/run"

# Start Redis
echo "Starting Redis..."
"$REDIS_SERVER" "$CONFIG_FILE" || {
    echo "Failed to start Redis. Check $REDIS_DIR/redis.log for details."
    exit 1
}

# Wait for Redis to start
sleep 1
if "$REDIS_DIR/build_dir/bin/redis-cli" ping > /dev/null 2>&1; then
    echo "Redis started successfully."
else
    echo "Redis failed to start. Check $REDIS_DIR/redis.log for details."
    exit 1
fi