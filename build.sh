#!/bin/bash
set -e

# 设置环境变量 - 使用动态绝对路径
export DATABASE_URL="file:$(pwd)/apps/server/data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

echo "=== Installing dependencies ==="
pnpm install --no-frozen-lockfile

echo "=== Generating Prisma client ==="
npx prisma@5 generate --schema apps/server/prisma/schema.prisma

# 确保数据目录存在并设置正确权限
mkdir -p apps/server/data
chmod -R 666 apps/server/data/
chmod -R 755 apps/server/data/

# 只有当数据库文件不存在时才运行迁移
if [ ! -f "apps/server/data/wewe-rss.db" ]; then
  echo "=== Creating new database and running migrations ==="
  npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma
else
  echo "=== Database already exists, skipping migrations ==="
fi

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
