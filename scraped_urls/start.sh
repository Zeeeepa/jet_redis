# Get the directory where the script is located
FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

redis-server "${FILE_DIR}/redis.conf" &
echo "Started redis server at port 3102"
