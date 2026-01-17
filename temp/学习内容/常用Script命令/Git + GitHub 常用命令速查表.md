## 🌱 本地 Git 操作

|命令|作用|
|---|---|
|`git init`|初始化一个新的 Git 仓库|
|`git clone`|克隆远程仓库到本地|
|`git status`|查看当前仓库状态|
|`git add .`|添加所有修改到暂存区|
|`git commit -m "说明文字"`|提交暂存区的修改|
|`git log`|查看提交历史|
|`git diff`|查看未暂存的修改差异|
|`git branch`|查看分支列表|
|`git checkout -b new_branch`|创建并切换到新分支|
|`git merge branch_name`|合并指定分支到当前分支|
|`git rm -r folder_name`|删除文件/目录并提交到 Git|

## ☁️ GitHub 远程操作

|操作|步骤|
|---|---|
|**Fork 仓库**|在 GitHub 页面点击 **Fork**，将仓库复制到自己账号下|
|**Clone 仓库**|使用 `git clone` 将 fork 下来的仓库克隆到本地|
|**Push 修改**|使用 `git push origin main` 将本地修改推送到远程 fork 仓库|
|**Pull Request**|在 GitHub 页面点击 **New Pull Request**，选择分支并提交合并请求|
|**同步上游仓库**|添加上游仓库：`git remote add upstream <原始仓库URL>`拉取更新：`git pull upstream main`推送到自己的 fork：`git push origin main`|

## 🧠 小提示

- **分支管理最佳实践**：在本地创建新分支开发，完成后再合并到 `main`。
- **保持 fork 更新**：定期从上游仓库拉取更新，避免冲突。
- **提交信息规范**：使用简洁明了的 commit message，例如 `fix: 修复登录 bug`。
- **PR 流程**：先 fork → clone → 修改 → push → 提交 PR。

✅ 总结：这份速查表把 **本地 Git 命令** 和 **GitHub 常用流程** 整合在一起，适合你在日常开发中快速查阅。