## 🐍 venv（Python 内置虚拟环境）

|命令|作用|
|---|---|
|`python -m venv .venv`|在当前目录创建虚拟环境|
|`.\\.venv\\Scripts\\activate` (Windows)|激活虚拟环境|
|`source .venv/bin/activate` (Linux/Mac)|激活虚拟环境|
|`deactivate`|退出虚拟环境|
|`pip install -r requirements.txt`|安装依赖|
|`pip freeze > requirements.txt`|导出依赖清单|

## 📦 conda（Anaconda/Miniconda）

|命令|作用|
|---|---|
|`conda create -n myenv python=3.10`|创建名为 `myenv` 的虚拟环境并指定 Python 版本|
|`conda activate myenv`|激活虚拟环境|
|`conda deactivate`|退出虚拟环境|
|`conda list`|查看已安装的包|
|`conda install package_name`|安装包|
|`conda remove package_name`|删除包|
|`conda env export > environment.yml`|导出依赖环境|
|`conda env create -f environment.yml`|根据配置文件创建环境|

## 📗 pipenv（更高级的依赖管理）

|命令|作用|
|---|---|
|`pipenv install`|创建虚拟环境并安装依赖|
|`pipenv install package_name`|安装指定包并写入 `Pipfile`|
|`pipenv uninstall package_name`|卸载包并更新 `Pipfile`|
|`pipenv shell`|激活虚拟环境|
|`exit`|退出虚拟环境|
|`pipenv lock`|生成 `Pipfile.lock`（锁定依赖版本）|
|`pipenv install --dev package_name`|安装开发依赖|
|`pipenv graph`|查看依赖树|

## 🧠 小提示

- **venv**：轻量、内置，适合小项目。
- **conda**：功能强大，适合科学计算和跨语言依赖。
- **pipenv**：更现代化，自动管理 `Pipfile` 和依赖锁定。
- 建议：日常项目用 `venv`，数据科学用 `conda`，团队协作用 `pipenv`。

✅ 总结：这份速查表把三种常见虚拟环境工具的命令放在一起，你可以快速查阅和对比，选择最适合的工具。