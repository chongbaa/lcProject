| 命令                           | 作用                    |
| ---------------------------- | --------------------- |
| `git init`                   | 初始化一个新的 Git 仓库        |
| `git clone`                  | 克隆远程仓库到本地             |
| `git status`                 | 查看当前仓库状态（修改、暂存、未跟踪文件） |
| `git add .`                  | 添加所有修改到暂存区            |
| `git commit -m "说明文字"`       | 提交暂存区的修改              |
| `git push origin main`       | 推送到远程仓库的 main 分支      |
| `git pull origin main`       | 拉取远程仓库最新代码            |
| `git log`                    | 查看提交历史                |
| `git diff`                   | 查看未暂存的修改差异            |
| `git branch`                 | 查看分支列表                |
| `git checkout -b new_branch` | 创建并切换到新分支             |
| `git merge branch_name`      | 合并指定分支到当前分支           |
| `git rm -r folder_name`      | 删除文件/目录并提交到 Git       |

## 🧠 小提示

- **git**：建议每次提交前先 `git status` 看清楚修改内容。
- `.gitignore` 要提前写好，避免把 `.venv`、`.env` 等敏感或无用文件提交。