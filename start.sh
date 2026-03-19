#!/bin/bash

# 设置数据库环境变量 - 使用绝对路径避免相对路径解析歧义
# /tmp 是 FaaS 环境中唯一可写的目录
export DATABASE_URL="file:/tmp/wewe-rss.db"
export DATABASE_TYPE="sqlite"

# 如果数据库不存在，从模板复制
if [ ! -f /tmp/wewe-rss.db ]; then
  echo "=== Initializing database from template ==="
  cp apps/server/data/wewe-rss.db.template /tmp/wewe-rss.db
fi

# 获取域名
if [ -n "$COZE_PROJECT_DOMAIN_DEFAULT" ]; then
  export SERVER_ORIGIN_URL="$COZE_PROJECT_DOMAIN_DEFAULT"
else
  export SERVER_ORIGIN_URL="http://localhost:5000"
fi

# 设置端口
export PORT=5000

# 启动服务
echo "=== Starting server ==="
node apps/server/dist/main.js
