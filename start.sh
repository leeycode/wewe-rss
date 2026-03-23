#!/bin/bash

# Railway 持久化数据目录
RAILWAY_DATA_DIR="${RAILWAY_VAR_DATA_DIR:-/var/data}"
mkdir -p "$RAILWAY_DATA_DIR"

# 设置数据库环境变量 - 使用持久化目录
export DATABASE_URL="file:${RAILWAY_DATA_DIR}/wewe-rss.db"
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
if [ ! -f "${RAILWAY_DATA_DIR}/wewe-rss.db" ]; then
  echo "=== Copying database to persistent storage ==="
  cp apps/server/data/wewe-rss.db "${RAILWAY_DATA_DIR}/wewe-rss.db" 2>/dev/null || true
  cp apps/server/data/wewe-rss.db.template "${RAILWAY_DATA_DIR}/wewe-rss.db.template" 2>/dev/null || true
fi

# 确保数据库文件可写
chmod 666 "${RAILWAY_DATA_DIR}/wewe-rss.db" 2>/dev/null || true
chmod 666 "${RAILWAY_DATA_DIR}/wewe-rss.db.template" 2>/dev/null || true

echo "=== Starting server with DATABASE_URL: $DATABASE_URL ==="
node apps/server/dist/main.js
