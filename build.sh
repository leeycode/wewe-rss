#!/bin/bash
set -e

# 设置环境变量 - 使用绝对路径避免相对路径解析歧义
# /tmp 是 FaaS 环境中唯一可写的目录
export DATABASE_URL="file:/tmp/wewe-rss.db"
export DATABASE_TYPE="sqlite"

echo "=== Installing dependencies ==="
pnpm install --no-frozen-lockfile

echo "=== Generating Prisma client ==="
npx prisma@5 generate --schema apps/server/prisma/schema.prisma

echo "=== Running database migrations ==="
npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
