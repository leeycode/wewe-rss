#!/bin/bash
set -e

echo "=== Installing dependencies ==="
# 使用 --no-frozen-lockfile 解决 lockfile 版本兼容问题
pnpm install --no-frozen-lockfile

echo "=== Generating Prisma client ==="
npx prisma generate --schema apps/server/prisma/schema.prisma

echo "=== Running database migrations ==="
npx prisma migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
