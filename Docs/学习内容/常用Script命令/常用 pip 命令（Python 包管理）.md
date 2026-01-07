|命令|作用|
|---|---|
|`pip install package_name`|安装指定包|
|`pip install package_name==1.2.3`|安装指定版本的包|
|`pip install -r requirements.txt`|根据依赖清单安装所有包|
|`pip uninstall package_name`|卸载包|
|`pip list`|查看当前环境已安装的包|
|`pip show package_name`|查看某个包的详细信息|
|`pip freeze > requirements.txt`|导出当前环境的依赖清单|
|`pip install --upgrade package_name`|升级某个包到最新版本|
|`pip install --upgrade pip`|升级 pip 自身|

## 🧠 小提示

- **pip**：每个项目独立的虚拟环境里运行，避免依赖冲突。