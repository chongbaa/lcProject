### 将本地项目正确推送至 GitHub 的标准流程（2026 年最新推荐）

以下是最规范、安全、适用于新手的完整流程，避免之前遇到的各种错误（如 unrelated histories、no tracking 等）。

#### 推荐前提：使用 HTTPS + Personal Access Token（或最好用 SSH）

- HTTPS 简单，但第一次推送需要 token。
- SSH 一劳永逸，以后不用输入任何凭证（强烈推荐）。

#### 完整步骤

**第 1 步：在 GitHub 上创建远程仓库（推荐空仓库）**

1. 登录 GitHub → 右上角 + → New repository
2. 填写仓库名（如 MyProject）
3. **重要**：**不要**勾选 “Add a README file”、“.gitignore” 或 “License”（保持完全为空！）
    - 这样可以避免 “unrelated histories” 错误。
4. 点击 Create repository
5. 复制仓库 URL（HTTPS 或 SSH）
    - HTTPS 示例：https://github.com/你的用户名/MyProject.git
    - SSH 示例：git@github.com:你的用户名/MyProject.git

**第 2 步：在本地项目文件夹初始化 Git（如果还没初始化）** 打开终端（Bash / CMD / VS Code Terminal），进入项目文件夹：

Bash

```
cd /c/路径/到/你的项目文件夹
```

初始化并做第一次提交：

Bash

```
git init                     # 初始化 Git 仓库
git add .                    # 添加所有文件
git commit -m "Initial commit"  # 第一次提交
```

**第 3 步：关联远程仓库（添加 origin）**

Bash

```
git remote add origin https://github.com/你的用户名/MyProject.git
```

（替换成你自己的 URL）

检查是否添加成功：

Bash

```
git remote -v
```

**第 4 步：设置分支名为 main（GitHub 默认是 main）**

Bash

```
git branch -M main          # 把当前分支重命名为 main
```

**第 5 步：推送代码到 GitHub 并设置上游跟踪**

Bash

```
git push -u origin main
```

- -u 会自动设置跟踪关系，以后直接 git push / git pull 就行。
- 第一次推送：
    - 如果用 HTTPS：会提示输入用户名和密码 → 密码处填 **Personal Access Token**（不是账号密码！）
        - 生成 Token：GitHub → 右上角头像 → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token → 选 repo 权限 → 生成后复制。
    - 如果用 SSH：直接成功，无需输入。

**成功后**：刷新 GitHub 页面，就能看到你的代码了！

#### 以后日常操作（超级简单）

在项目文件夹内：

Bash

```
git add .                    # 添加修改
git commit -m "描述本次修改" 
git push                     # 推送（因为之前用了 -u，不用再写 origin main）
```

拉取远程更新：

Bash

```
git pull                     # 自动拉取并合并
```

#### 常见错误避免小贴士

|问题|原因|避免方法|
|---|---|---|
|unrelated histories|远程仓库有初始文件（如 README），本地也有提交|创建仓库时保持为空|
|no tracking information|没用 -u 推送|第一次推送加 -u origin main|
|non-fast-forward|远程有新提交，本地没拉取|先 git pull 再 push|
|origin 不存在|没添加 remote|必须执行 git remote add origin ...|

#### 强烈推荐：切换到 SSH（以后永不输入密码）

1. 生成 SSH 密钥（只需一次）：
    
    Bash
    
    ```
    ssh-keygen -t ed25519 -C "你的邮箱"
    ```
    
    一路回车即可。
2. 把公钥添加到 GitHub：Settings → SSH and GPG keys → New SSH key → 复制 cat ~/.ssh/id_ed25519.pub 的内容粘贴。
3. 把远程 URL 改成 SSH：
    
    Bash
    
    ```
    git remote set-url origin git@github.com:你的用户名/MyProject.git
    ```
    

这样就完全搞定了一个项目从本地到 GitHub 的完美推送流程！ 照着这个步骤来，下次再建新项目就一气呵成了。需要我帮你检查某个具体命令的输出，随时贴过来！🚀