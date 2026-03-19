#!/bin/bash
set -e

echo "=== Installing dependencies ==="
pnpm install --no-frozen-lockfile

echo "=== Generating Prisma client ==="
# 使用 prisma@5 版本，避免 npx 自动安装最新的 7.x 版本
npx prisma@5 generate --schema apps/server/prisma/schema.prisma

echo "=== Running database migrations ==="
npx prisma@5 migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
