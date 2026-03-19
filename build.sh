#!/bin/bash
set -e

echo "=== Installing dependencies ==="
pnpm install

echo "=== Generating Prisma client ==="
npx prisma generate --schema apps/server/prisma/schema.prisma

echo "=== Running database migrations ==="
npx prisma migrate deploy --schema apps/server/prisma/schema.prisma

echo "=== Building project ==="
pnpm run -r build

echo "=== Build completed ==="
