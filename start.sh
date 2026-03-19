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

# 运行数据库迁移 (确保数据库存在)
# 注意：Prisma CLI 的 migrate 命令从 schema 文件所在目录解析相对路径
# 所以这里使用 file:../data/wewe-rss.db (相对于 apps/server/prisma/)
echo "=== Running database migrations ==="
DATABASE_URL="file:../data/wewe-rss.db" npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma

# 启动服务
echo "=== Starting server ==="
node apps/server/dist/main.js
