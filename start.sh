#!/bin/bash

# 设置数据库环境变量 (Prisma 运行时必需)
# 注意：DATABASE_URL 相对于当前工作目录（项目根目录）
export DATABASE_URL="file:apps/server/data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

# 确保 data 目录存在
mkdir -p apps/server/data

# 获取域名
if [ -n "$COZE_PROJECT_DOMAIN_DEFAULT" ]; then
  export SERVER_ORIGIN_URL="$COZE_PROJECT_DOMAIN_DEFAULT"
else
  export SERVER_ORIGIN_URL="http://localhost:5000"
fi

# 设置端口
export PORT=5000

# 启动服务
node apps/server/dist/main.js
