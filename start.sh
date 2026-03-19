#!/bin/bash

# 设置数据库环境变量 - 使用绝对路径指向项目内的数据目录
export DATABASE_URL="file:/opt/bytefaas/apps/server/data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

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
