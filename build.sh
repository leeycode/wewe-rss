#!/bin/bash
set -e

# 设置环境变量
# Prisma CLI 的 migrate 命令会从 schema 文件所在目录解析相对路径
# schema 在 apps/server/prisma/，所以 ../data/ 指向 apps/server/data/
export DATABASE_URL="file:../data/wewe-rss.db"
export DATABASE_TYPE="sqlite"

echo "=== Installing dependencies ==="
pnpm install --no-frozen-lockfile

# 确保 data 目录存在
mkdir -p apps/server/data

echo "=== Generating Prisma client ==="
npx prisma@5 generate --schema apps/server/prisma/schema.prisma

echo "=== Running database migrations ==="
npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
