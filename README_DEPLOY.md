# WeWe RSS 部署说明

## 数据库持久化

本项目使用 SQLite 数据库存储订阅源和账号信息，默认存储在 `apps/server/data/wewe-rss.db`。

### 重要说明

每次在 Web 页面修改订阅源后，需要手动备份数据库到 git 仓库，否则重新部署时数据会丢失。

## 使用流程

### 1. 本地开发

```bash
# 启动开发服务
pnpm dev
```

### 2. 部署到云端

```bash
# 推送到 git，触发自动部署
git add .
git commit -m "你的提交信息"
git push origin main
```

### 3. 数据维护

在 Web 页面上添加/修改订阅源后，必须执行以下命令备份数据：

```bash
# 方式一：使用提供的脚本
./save-db.sh

# 方式二：手动执行
git add -f apps/server/data/wewe-rss.db
git commit -m "chore: 更新数据库"
git push origin main
```

## 数据库备份

数据库文件会自动在以下情况下保留：
- 构建时如果数据库已存在，不会覆盖
- 部署包会包含最新的数据库文件

## 故障恢复

如果数据丢失，可以从 git 历史恢复：

```bash
# 查看数据库文件历史
git log --oneline apps/server/data/wewe-rss.db

# 恢复指定版本
git checkout <commit-hash> -- apps/server/data/wewe-rss.db
```
