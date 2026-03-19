#!/bin/bash
set -e

# 设置环境变量
# 使用绝对路径指向项目内的数据目录
export DATABASE_URL="file:/opt/bytefaas/apps/server/data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

echo "=== Installing dependencies ==="
pnpm install --no-frozen-lockfile

echo "=== Generating Prisma client ==="
npx prisma@5 generate --schema apps/server/prisma/schema.prisma

# 确保数据目录存在
mkdir -p apps/server/data

echo "=== Running database migrations ==="
npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
