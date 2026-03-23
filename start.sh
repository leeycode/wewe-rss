#!/bin/bash

# Railway 持久化数据目录 - 尝试多个可能的路径
# 按优先级尝试，找到可写的目录

# 定义可能的持久化目录
POSSIBLE_DATA_DIRS=(
    "${RAILWAY_DATA_DIR:-}"          # Railway 自定义变量
    "${RAILWAY_VAR_DATA_DIR:-}"      # Railway 变量格式
    "/data"                           # Railway Volume 常用路径
    "/tmp/data"                       # 临时目录
    "$(pwd)/.data"                    # 工作目录下
)

# 找到第一个可写的目录
DATA_DIR=""
for dir in "${POSSIBLE_DATA_DIRS[@]}"; do
    if [ -n "$dir" ] && [ -d "$dir" ] && [ -w "$dir" ]; then
        DATA_DIR="$dir"
        break
    fi
done

# 如果没有找到可写目录，在工作目录下创建
if [ -z "$DATA_DIR" ]; then
    DATA_DIR="$(pwd)/.data"
    mkdir -p "$DATA_DIR"
fi

# 设置数据库环境变量
export DATABASE_URL="file:${DATA_DIR}/wewe-rss.db"
export DATABASE_TYPE="sqlite"

# 获取域名
if [ -n "$COZE_PROJECT_DOMAIN_DEFAULT" ]; then
  export SERVER_ORIGIN_URL="$COZE_PROJECT_DOMAIN_DEFAULT"
else
  export SERVER_ORIGIN_URL="http://localhost:5000"
fi

# 设置端口
export PORT=5000

# 如果持久化目录没有数据库，从构建目录复制
if [ ! -f "${DATA_DIR}/wewe-rss.db" ]; then
  echo "=== Copying database to: ${DATA_DIR} ==="
  cp apps/server/data/wewe-rss.db "${DATA_DIR}/wewe-rss.db" 2>/dev/null || true
  cp apps/server/data/wewe-rss.db.template "${DATA_DIR}/wewe-rss.db.template" 2>/dev/null || true
fi

echo "=== Starting server with DATABASE_URL: $DATABASE_URL ==="
node apps/server/dist/main.js
