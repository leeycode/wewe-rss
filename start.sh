#!/bin/bash

# 设置数据库环境变量 - 使用动态绝对路径
CURRENT_DIR=$(pwd)
export DATABASE_URL="file:${CURRENT_DIR}/apps/server/data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

# 获取域名
if [ -n "$COZE_PROJECT_DOMAIN_DEFAULT" ]; then
  export SERVER_ORIGIN_URL="$COZE_PROJECT_DOMAIN_DEFAULT"
else
  export SERVER_ORIGIN_URL="http://localhost:5000"
fi

# 设置端口
export PORT=5000

# 确保数据库文件和目录有写入权限 (Railway 容器需要)
chmod -R 666 ${CURRENT_DIR}/apps/server/data/
chmod -R 755 ${CURRENT_DIR}/apps/server/data/

# 启动服务
echo "=== Starting server with DATABASE_URL: $DATABASE_URL ==="
node apps/server/dist/main.js
