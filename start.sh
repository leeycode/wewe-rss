#!/bin/bash

# 使用 /tmp 作为数据目录（Railway 容器中唯一保证可写的目录）
DATA_DIR="/tmp/wewe-data"
mkdir -p "$DATA_DIR"

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

# 如果 /tmp 目录没有数据库，从构建目录复制
if [ ! -f "${DATA_DIR}/wewe-rss.db" ]; then
  echo "=== Copying database to: ${DATA_DIR} ==="
  cp apps/server/data/wewe-rss.db "${DATA_DIR}/wewe-rss.db"
fi

echo "=== Starting server with DATABASE_URL: $DATABASE_URL ==="
node apps/server/dist/main.js
