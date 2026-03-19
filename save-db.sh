#!/bin/bash
# 数据库备份脚本
# 用于在本地将数据库变更提交到 git

cd "$(dirname "$0")"

if [ ! -f "apps/server/data/wewe-rss.db" ]; then
  echo "错误: 数据库文件不存在"
  exit 1
fi

# 备份数据库
echo "=== 备份数据库 ==="
cp apps/server/data/wewe-rss.db apps/server/data/wewe-rss.db.backup

# 提交数据库变更
echo "=== 提交数据库变更 ==="
git add -f apps/server/data/wewe-rss.db
git commit -m "chore: 更新数据库 $(date '+%Y-%m-%d %H:%M:%S')"

echo "=== 数据库已备份并提交 ==="
echo "请执行 'git push origin main' 推送变更"
