## 1. 底层逻辑

|步骤|命令示例|底层在做什么？|为什么要这么做？（核心目的）|不做会怎样？|
|---|---|---|---|---|
|1）检查 Git 是否安装|`git --version`|询问操作系统：你有 Git 这个程序吗？版本是多少？|确认基本工具存在，避免后面全部命令都报「`command not found`」|后面所有 git 命令都会失败|
|2）全局配置用户名 & 邮箱|`git config --global user.name/email`|把你的身份信息永久保存在 `~/.gitconfig` 这个文件里|每次 `commit` 都会自动记录「谁做的改动」，GitHub 显示提交者也是靠这个信息|`commit` 会显示「未知用户」，GitHub 认不出你|
|3）生成 SSH key|`ssh-keygen -t ed25519 -C "邮箱"`|在你电脑上生成一对加密钥匙（私钥+公钥），公钥可以安全给人看，私钥必须自己保密|让 GitHub 以后能「认出」这台电脑是授权的，而不需要每次都输入账号密码|每次 push 都要手动输入密码/令牌，很痛苦|
|4）把公钥加到 GitHub|复制公钥 → GitHub 设置里添加|把你的「公钥」登记到 GitHub 服务器的「已授权钥匙列表」里|建立信任关系：以后这台电脑连上来时，GitHub 会用公钥验证「你就是钥匙的主人」|SSH 认证失败，push/pull 都会被拒绝|
|5）测试 SSH 连接|`ssh -T git@github.com`|真的去敲 GitHub 的门，看看门卫（服务器）会不会放行|验证整个 SSH 信任链路是否打通（最容易出问题的环节）|没打通的话后面 push 会报 Permission denied|
|6）`git init`|在项目文件夹执行|在当前目录创建隐藏的 .git 文件夹，正式把这个目录变成「Git 仓库」|告诉 Git：「从现在开始你要开始跟踪这个文件夹里的文件变化了」|Git 根本不认识这个文件夹，什么都干不了|
|7）创建 `.gitignore`|手动创建或 `curl` 下载|告诉 Git：「这些文件/文件夹永远不要跟踪、不要上传」|防止把垃圾文件（日志、缓存、node_modules、.DS_Store、虚拟环境等）上传到远程，保持仓库干净|仓库会变得巨大、混乱，很多不该传的东西也被传上去|
|8）`git add . / git add` 文件|添加文件到「暂存区」|把你刚刚修改的文件快照先搬到「准备室」（`staging area/index`）|让你有最后一次检查/选择的机会：「我真的要提交这些改动吗？」|直接 commit 会把所有改动（包括没改好的）都打包|
|9）`git commit -m "xxx"`|创建一个提交（`commit`）|把暂存区里的文件快照永久保存成一个「版本」（带 hash 值、作者、时间、说明）|这是 Git 的核心：版本控制的本质就是「保存一个个有意义的快照」|没有 commit → 什么都没保存，后面 push 也没东西可推|
|10）在 GitHub 网站建空仓库|—|在服务器上创建一个空的「远程仓库」|给你的代码找一个「官方备份/展示/协作」的家|没有地方可以 push，代码只能留在你本地|
|11）`git remote add origin URL`|添加远程仓库地址，别名叫 origin|在本地仓库里登记：「以后提到 origin 就代表这个 URL」|避免每次 push 都要写一长串 URL，origin 是业界默认的「主远程仓库」别名|每次 push 都要写完整 URL，很麻烦|
|12）`git branch -M main`|把当前分支改名叫 main|更改本地默认分支名称（Git 从 2020 年后逐渐把默认分支从 master 改成 main）|与 GitHub 现在的默认分支名保持一致，避免后续各种「分支名不匹配」的困惑|可能导致 push 时「找不到对应分支」|
|13）`git push -u origin main`|第一次推送 + 设置上游跟踪|把本地 main 分支的所有 commit 推送到远程 origin 的 main 分支，并建立跟踪关系|1. 把代码真正备份到云端||

1. 建立「本地分支 ↔ 远程分支」的关联，以后可以直接 `git push / git pull` | 代码没备份到远程，等于没上传成功 |

更形象的类比，把整个流程想像成你要搬家：

- 不想带走的东西列清单扔掉（`.gitignore`）
- 把要带的东西打包整理好（`git add`）
- 把打包好的箱子封好并贴标签（`git commit`）
- 在新家（GitHub）先租个空房子（新建空仓库）
- 告诉搬家公司新家的地址，并起个昵称「origin」（`git remote add`）
- 叫搬家公司把所有箱子都运过去（`git push`）
- 以后每次想再送东西过去就不用重新写地址了，直接说「送到 origin 就好」（后续直接 `git push`）

## **2. Fork 和 Clone 的区别（GitHub + Git 命令行完整解析）**

一句话记忆法： Fork = 复制一份仓库到你自己账户 （服务器端，网页/CLI）

Clone = 下载一份仓库到你本地电脑 （纯本地，git命令）

### 1）**视觉对比表**（最直观）

|维度|**Fork** 🌐（服务器复制）|**Clone** 💻（本地下载）|
|---|---|---|
|**操作位置**|GitHub **服务器端**（你的账户下创建新仓库）|**本地电脑**（下载到硬盘）|
|**命令**|`gh repo fork owner/repo`（无纯git命令）|`git clone <https://github.com/owner/repo.git`>|
|**结果**|你的GitHub上多一个**独立仓库**（可改名、加文件）|本地文件夹（.git历史完整，但**不属于你**）|
|**改代码**|可以随意改，**独立存在**，可发PR给原仓库|可以改，但**只是本地副本**，推不上去原仓库|
|**体积**|只复制**仓库结构+代码**（无历史? 有完整历史）|**完整下载**：代码+全部提交历史+分支（大仓库慢）|
|**多人协作**|**你的fork**可分享给别人，他们再clone你的fork|每个人clone一份，各自本地独立|
|**常见场景**|开源贡献（Linux内核fork→改→PR）|日常开发（clone公司仓库→本地写代码→push）|
|**删除后**|GitHub上删fork，本地clone不受影响|本地删clone，GitHub仓库还在|
|**体积影响**|GitHub多存一份（免费无限fork）|本地硬盘占空间（可删.git减小90%体积）|

```markdown
仓库原版：torvalds/linux (10GB历史)
├── Fork → chong/linux (你的GitHub，独立仓库)
│   └── Clone → /Users/chong/linux (本地文件夹)
└── Clone → /Users/chong/linux-readonly (只读本地)

```

### 2）**实际操作演示**（复制粘贴就能跑）

**场景**：贡献 microsoft/vscode（VSCode源码）

```bash
# 【1. Fork 先干这个】（服务器端创建你的仓库）
gh repo fork microsoft/vscode --clone  # 一键：fork + clone到本地
cd vscode
git remote -v
# origin  <https://github.com/chong/vscode.git> (你的fork) ← 能push!
# upstream  <https://github.com/microsoft/vscode.git> (原版) ← 同步更新

# 【2. Clone 只是下载（传统方式）】
git clone <https://github.com/microsoft/vscode.git> vscode-readonly
cd vscode-readonly
git remote -v
# origin  <https://github.com/microsoft/vscode.git> (原版) ← 不能push！

```

**关键差异验证**：

```bash
# Fork后的本地仓库 ✅ 可以推自己的改动
cd vscode          # (fork+clone的目录)
echo "我的修改" >> README.md
git add . && git commit -m "feat: add my feature"
git push origin main  # ✅ 成功推到 chong/vscode

# 纯clone的仓库 ❌ 推不了（无push权限）
cd vscode-readonly
git push origin main  # ✗ ERROR: Permission denied

```

### 3）**内存误区终结者**（90%人踩过的坑）

|❌ **常见误解**|✅ **真相**|
|---|---|
|"Fork就是clone到本地"|Fork是**服务器复制**，clone才下载本地|
|"Clone后就能push原仓库"|**无权限**！clone默认只读，fork后origin才可写|
|"Fork后本地就独立了"|Fork+clone才完整，本地origin指向**你的fork**|
|"大仓库clone很慢"|是的（完整历史），用 git clone --depth=1 只下最新版|
|"Fork删了本地就没了"|**互不影响**，fork是云端，clone是本地|

### 4）**完整工作流**（贡献开源标配，2026版）

```bash
# 1. Fork（服务器创建你的仓库）
gh repo fork owner/repo --clone
cd repo

# 2. 配置upstream（同步原仓库更新）
git remote add upstream <https://github.com/owner/repo.git>

# 3. 开发→提交→推你的fork
git checkout -b my-feature
# ... 写代码 ...
git add . && git commit -m "feat: xxx"
git push origin my-feature  # 推到你的fork

# 4. 网页创建PR（从你的fork → 原仓库）
# GitHub自动提示：<https://github.com/chong/repo/compare/my-feature>

# 5. 同步原仓库最新代码（别人合入了你的PR）
git fetch upstream
git checkout main
git merge upstream/main
git push origin main  # 同步到你的fork

```

### 5）**高级用法**（CLI一键全搞定）

```bash
# 一键fork+clone+upstream（gh 2.40+，2026默认）
gh repo fork microsoft/vscode --clone --remote=origin --upstream

# 批量fork多个仓库
gh repo fork torvalds/linux
gh repo fork python/cpython
gh repo fork --clone --remote-batch  # 批量clone你的forks

# Fork后直接创建PR模板
gh repo fork owner/repo
gh pr create --fill  # 从你的fork创建PR

```

### 6）**体积/性能优化**（大仓库必备）

```bash
# 浅克隆（只下最新代码，省90%空间，10GB→100MB）
git clone --depth=1 <https://github.com/torvalds/linux.git>  # 5秒搞定

# 后续拉完整历史（需要时）
git fetch --unshallow

# 清理无用历史（本地瘦身）
git gc --aggressive --prune=now

```

**🚀 终极记忆口诀**： **F**ork → **F**rom GitHub **服务器** **F**actory（云端造仓库） **C**lone → **C**opy to **本地** **C**omputer（硬盘拷贝）

**99%场景**：**先Fork再Clone**（gh repo fork --clone），一条命令天下我有！