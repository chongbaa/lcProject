### 一. 安装虚拟环境.venv/文件夹

|排名|方法|命令创建方式|推荐指数|现在主流程度|备注与适用场景|
|---|---|---|---|---|---|
|1|uv (最快、最现代)|`uv venv`|★★★★★|非常高|2024~2025 年上升最快的工具，速度极快|
|2|python -m venv|`python3 -m venv .venv`|★★★★☆|非常高|官方内置、最稳定、零依赖|
|3|conda / miniforge|`conda create -n myenv python=3.11`|★★★★|中高|需要科学计算、重环境隔离时最方便|
|4|virtualenv|`virtualenv .venv`|★★☆|下降中|以前很流行，现在基本被 python -m venv 取代|
|5|poetry / pdm 内置虚拟环境|`poetry env use python3.12` / `pdm venv`|★★★|中高|项目管理工具自带虚拟环境，不建议单独用|

### 1. 最推荐（2025 年主流做法）→ 使用 uv（速度最快）

```bash
# 1. 先安装 uv（只需一次）
curl -LsSf <https://astral.sh/uv/install.sh> | sh

# 2. 创建虚拟环境（超级快，通常1-2秒）
uv venv          # 默认创建 .venv
# 或者指定 python 版本（前提是你电脑上有这个版本）
uv venv --python 3.11 myproject-env

# 3. 激活
source .venv/bin/activate
# 或者
source myproject-env/bin/activate

# 4. 以后每次进入项目只要
source .venv/bin/activate

# 退出虚拟环境
deactivate
```

### 2. 官方最稳妥做法（零额外依赖）→ python -m venv

```bash
# 1. 创建虚拟环境（推荐放在项目根目录下叫 .venv）
python3 -m venv .venv

# 2. 检查.venv/是否安装成功（方法见下面表格）

# 3. 激活（每次都要执行）
source .venv/bin/activate

# 4. 看到前面出现 (.venv) 就代表成功激活了
# 安装包就直接用 pip
pip install requests fastapi numpy ...

# 5.退出
deactivate
```

检查.venv/是否安装成功：

|想确认什么|命令/操作|如果看到这个 → .venv 存在/在使用中|
|---|---|---|
|文件夹是否存在|`ls -la`|有 `.venv` 文件夹|
|VS Code 是否识别|左下角状态栏 或 Python: Select Interpreter|列表里有 `./.venv/bin/python`|
|当前是否激活|看提示符 + `which python3`|提示符有 `(.venv)` 或路径在 `.venv/bin`|
|是否有效 .venv|`cat .venv/pyvenv.cfg` 或上面 Python 代码|有 `home = ...` 或输出 “在 venv 中”|

### 3. 如果你是做数据科学/AI/ML（强烈推荐 conda/miniforge）

```bash
# 先安装 miniforge（arm64 版 M 芯片最推荐）
curl -L -O "<https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh>"
bash Miniforge3-MacOSX-arm64.sh

# 然后创建环境（超级方便管理不同 python 版本）
conda create -n ml-env python=3.11
conda activate ml-env

# 安装包用 conda 更快（尤其是科学计算包）
conda install pytorch torchvision torchaudio -c pytorch
# 或者混合用 pip
pip install jupyterlab polars xgboost
```

**conda 和 venv 的区别**（2025 年最新对比，Python 项目最常用两种虚拟环境工具）

|项目|venv（python -m venv 或 uv venv）|conda（Miniconda / Miniforge / Anaconda）|谁更适合你？（2025 年主流选择）|
|---|---|---|---|
|**本质**|纯 Python 的轻量虚拟环境，只隔离 Python 解释器 + pip 包|完整的包管理 + 环境管理系统（支持非 Python 包）|—|
|**创建速度**|极快（1–5 秒）|较慢（10–60 秒，甚至几分钟）|venv / uv 完胜|
|**安装包速度**|pip 普通，uv pip 超级快|conda 安装科学计算包快，但整体比 uv 慢|uv > conda > pip|
|**包来源**|PyPI（Python 官方包仓库）|conda-forge / defaults（有大量预编译二进制包）|conda 在科学计算上更有优势|
|**支持非 Python 包**|不支持（不能装 C++ 库、CUDA、ffmpeg 等）|支持（numpy、pytorch、tensorflow、opencv、R、Julia 等）|conda 大胜|
|**Python 版本管理**|依赖系统已有 Python，或 uv 会自动下载|自己带完整 Python，可轻松切换任意版本（甚至 3.8~3.13）|conda 更方便多版本共存|
|**磁盘占用**|非常小（几十 MB ~ 几百 MB）|较大（基础环境 300MB+，装大包轻松上 GB）|venv 轻量党首选|
|**激活方式**|source .venv/bin/activate|conda activate myenv|差不多|
|**依赖管理文件**|requirements.txt（或 pyproject.toml + uv lock）|environment.yml（可精确复现，包括 Python 版本）|conda 的 yml 更强大（可指定渠道、版本约束）|
|**跨平台一致性**|一般（Windows/Linux/macOS 编译问题多）|极好（预编译二进制包，M 芯片 Mac 友好）|conda 完胜（尤其科学计算）|
|**生态定位**|Web 后端、爬虫、脚本、小型项目、DevOps|数据科学、机器学习、深度学习、科研、生物信息学|看你的领域|
|**2025 年主流推荐**|普通 Python 项目、FastAPI/Django/爬虫/工具脚本|AI/ML/数据分析/需要 GPU/CUDA/科学计算包的项目|—|

### 4. 快速选择表（根据你的情况）

```markdown
你现在的情况                              推荐方式
───────────────────────────────────────── ━━━━━━━━━━━━━━━━━━━━
普通 web/爬虫/后端/小项目                  uv 或 python -m venv
需要不同 python 版本（3.9~3.13）共存       uv（最方便）或 pyenv + venv
做数据分析／机器学习／深度学习              miniforge/conda
已经用了 poetry 项目管理                    直接用 poetry 的虚拟环境
追求最快创建／最快安装包                    uv（目前无敌）
完全不想装任何额外工具                      python3 -m venv
```

**最快速上手建议（2025 年 12 月主流）**：

```bash
# 一次性搞定（大概率你以后都会这么用）
curl -LsSf <https://astral.sh/uv/install.sh> | sh
uv venv
source .venv/bin/activate
pip install -U pip
```

### 二. 在项目根目录下创建requirements.txt，存放依赖环境名称并安装

### 三. 在项目根目录激活虚拟环境：

```bash
# 假设你的虚拟环境文件夹叫 .venv（最常见命名）
source .venv/bin/activate
```

想退出：直接输入 `deactivate` 回车

### 四. 在项目根目录安装依赖环境：

**在安装requirements.txt前，先升级pip：**`python -m pip install --upgrade pip`

|方式|命令示例|适用场景|优点|推荐指数|
|---|---|---|---|---|
|1. 用 requirements.txt（最经典、最通用）|pip install -r requirements.txt|几乎所有项目，尤其是别人分享或 GitHub 上|标准、兼容性最好|★★★★★|
|2. 用 uv 安装（最快、2025 年主流）|uv pip install -r requirements.txt|你用 uv 创建的环境|速度是 pip 的 5~10 倍|★★★★★|
|3. 一个一个手动安装|pip install requests httpx python-dotenv|自己写的小项目、快速测试|简单、直观|★★★★|
|4. 用 uv add（现代项目管理方式）|uv add requests httpx python-dotenv|新项目，想自动生成/更新依赖文件|自动维护 pyproject.toml + lock|★★★★☆|
|5. poetry 项目|poetry add requests|用 poetry 管理整个项目|依赖冲突少、版本锁定好|★★★★|
|6. conda 项目|conda install numpy pandas 或 pip install|数据科学/ML 项目|科学计算包安装更快|★★★|

**检验是否成功安装依赖环境：先激活虚拟环境（如果不激活，检查的是系统全局的包，而不是项目专属的。）见标题三**

### 方法 1：最常用、最推荐（用 pip list）

```bash
pip list
```

- 输出：列出当前环境中所有已安装的包及其版本（按字母排序）。

```markdown
    Package    Version
    ---------- -------
    numpy      1.26.4
    pandas     2.2.2
    pip        24.2
    requests   2.32.3
    ...

```

- 如果你想检查某个特定包（比如 requests 是否安装）：

```bash
pip list | grep requests
```

或更精确：

```bash
pip show requests
```

pip show 会显示包的详细信息（版本、位置、依赖等），如果没安装会提示 "WARNING: Package(s) not found"。

- 小技巧：想生成 requirements.txt 格式的列表（方便分享或重建环境）：

```bash
pip list --format=freeze > requirements.txt
```

### 方法 2：快速检查特定包（一行命令判断是否存在）

```bash
python -c "import requests; print('requests 已安装，版本：' + requests.__version__)"
```

- 如果已安装：输出版本号。
- 如果未安装：报错 ModuleNotFoundError: No module named ‘requests’。

适用于任何包（把 requests 换成你要查的包名，如 numpy、flask 等）。

### 方法 3：用 pip freeze（经典方式）

```bash
pip freeze
```

- 输出所有包的精确版本（如 requests2.32.3），适合复制到 requirements.txt。
- 检查特定包：

```bash
pip freeze | grep requests
```

### 方法 4：VS Code 图形化查看（最直观）

1. 确保项目已打开，且 VS Code 左下角显示的是 .venv 的 Python 解释器（如果不是，Cmd + Shift + P → Python: Select Interpreter → 选 ./.venv/bin/python）。
2. 打开终端（Cmd + `），激活 .venv（或 VS Code 自动激活）。
3. 在终端运行 pip list 即可看到。
    - 或者在 VS Code 扩展面板搜索 “Python” 扩展 → 有些版本有 “Python Packages” 视图，但最可靠还是终端。

### 常见问题排查

- 没激活 .venv/ 就查 → 会看到系统全局的包，而不是项目里的 → 一定先 source .venv/bin/activate。
- pip list 什么都不显示 → 说明虚拟环境刚创建，还没装任何第三方包（只有 pip 和 setuptools）。
- 想确认安装路径 → 用 pip show 包名，看 Location 一行，通常是 …/.venv/lib/python3.x/site-packages。
- 在项目根目录下创建.env，存放OPENAI_API_KEY
- 删除.venv/：PowerShell：rmdir /s /q .venv

### 五. 在项目根目录下创建.gitignore，存放git的文件和文件夹

### 六. 编写主代码

验证密钥加载代码

```python
from dotenv import load_dotenv
import os

load_dotenv()

print("是否成功加载:", load_dotenv())  # 应该打印 True
print("密钥是否存在:", bool(os.getenv("OPENAI_API_KEY")))
print("密钥前8位:", os.getenv("OPENAI_API_KEY")[:8] if os.getenv("OPENAI_API_KEY") else "None")
```

输出：

```python
是否成功加载: True
密钥是否存在: True
密钥前8位: sk-proj-
```

验证大模型对话代码：

```python
from openai import OpenAI
from dotenv import load_dotenv

# 加载 .env 文件
load_dotenv()

# 直接创建客户端，它会自动读取 OPENAI_API_KEY
client = OpenAI()
client = OpenAI(api_key="sk-proj-你的密钥xxxxxxxxxxxxxxxxxxxxxxxx")

completion = client.chat.completions.create(
    model="gpt-5.2-chat-latest",
    messages=[
        {"role": "user", "content": "用中文自我介绍一下"}
    ]
)

print(completion.choices[0].message.content)
```

输出：

```python
你好！我是 **ChatGPT**，一个由 OpenAI 训练的人工智能助手。

我可以用中文或其他多种语言和你交流，擅长回答问题、提供学习和工作方面的帮助、写作与润色文本、解释复杂概念、编程辅助，以及进行日常聊天等。

无论你是想学习新知识、解决问题，还是单纯聊聊天，我都很乐意帮忙 😊

有什么我可以为你做的吗？
```

主代码：main()