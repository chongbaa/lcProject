`pyproject.toml` 是 **现代 Python 项目的核心配置文件**。 如果说 `.env` 是“运行时配置”，那 `pyproject.toml` 就是“工程配置 + 构建配置 + 依赖管理”的大脑。

你现在正在构建工程化结构，这个文件正是你会长期接触、甚至会喜欢的那种“统一配置中心”。

# 🧩 **pyproject.toml 是什么？一句话概括**

**它是 Python 官方推荐的项目配置文件，用来统一管理：构建、依赖、工具配置、项目元数据。**

换句话说： 以前散落在 `setup.py`、`requirements.txt`、`setup.cfg`、`MANIFEST.in` 的东西，现在都可以放进一个文件里。

# 📦 pyproject.toml 主要负责什么？

## 1. **项目元数据（项目名、版本、作者）**
```toml
[project]
name = "my_project"
version = "0.1.0"
description = "A cool Python project"
```

## 2. **依赖管理（取代 requirements.txt）**

如果你用 Poetry 或 PDM：
```toml
[project]
dependencies = [
    "requests",
    "fastapi",
]
```

## 3. **构建系统（告诉 Python 如何构建你的项目）**
```toml
[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"
```

## 4. **工具配置（黑科技：所有工具都能放进这里）**

例如：

### Black（代码格式化）
```toml
[tool.black]
line-length = 88
```

### Ruff（lint）
```toml
[tool.ruff]
select = ["E", "F"]
```

### pytest
```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
```

你会发现： **所有工具都可以在这里集中配置，不再散落在几十个文件里。**

# 🧱 pyproject.toml 在工程化项目中的位置

标准结构：

代码

```
project/
│
├── pyproject.toml      ← 工程配置中心
├── .env
├── main.py
├── package_name/
│   ├── __init__.py
│   ├── app.py
│   └── modules/
└── tests/
```

它属于“项目根目录”，和 `.env`、`main.py` 同一层。

# 🎯 为什么你一定要用 pyproject.toml？

因为你现在追求的是：

- 可维护
    
- 可扩展
    
- 工程化
    
- 规范化
    
- 未来兼容
    

而 `pyproject.toml` 正是 Python 官方推动的未来标准。

你现在正在构建的项目结构（入口、包结构、环境变量、模块化）和 `pyproject.toml` 完全契合。