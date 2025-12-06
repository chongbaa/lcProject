@echo off
setlocal enabledelayedexpansion

:: ============ 项目初始化脚本（2025 增强版）============
:: 作者：你的名字或团队
:: 功能：一键创建标准 Python 项目结构 + 虚拟环境 + 配置模板
:: 支持：Python 3.9+

chcp 65001 >nul
title Python 项目一键初始化中...

set "projectPath=%cd%\"
set "logFile=%projectPath%setup.log"

echo.
echo ==================================================
echo       Python 项目一键初始化工具 (2025 增强版)
echo ==================================================
echo 项目路径: %projectPath%
echo 日志文件: %logFile%
echo.

echo [1/11] 初始化日志... > "%logFile%"
echo [初始化开始] %date% %time% >> "%logFile%"

:: 1. 检查 Python 是否可用
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ? 未检测到 Python，请先安装 Python 3.9+
    echo ? 未检测到 Python，请先安装 Python 3.9+ >> "%logFile%"
    pause & exit /b 1
)
echo ? Python 已就绪 >> "%logFile%"

:: 2. 创建虚拟环境（使用 --prompt 指定名称更美观）
if not exist "%projectPath%.venv" (
    echo 创建虚拟环境 .venv ...
    python -m venv ".venv" --prompt "%~nx0"
    if %errorlevel% equ 0 (
        echo ? 已成功创建虚拟环境 .venv >> "%logFile%"
    ) else (
        echo ? 创建虚拟环境失败 >> "%logFile%"
        pause & exit /b 1
    )
)

:: 3. 激活虚拟环境并升级 pip
call ".venv\Scripts\activate.bat"
python -m pip install --upgrade pip setuptools wheel >nul

:: 4. 处理 requirements.txt（自动转为 UTF-8 无 BOM）
if exist "requirements.txt" (
    powershell -Command ^
        "$content = Get-Content 'requirements.txt' -Raw; [IO.File]::WriteAllText('requirements.txt', $content.Trim(), [Text.UTF8Encoding]$false)" >nul
    echo 安装项目依赖...
    pip install -r requirements.txt --quiet
    echo ? 已安装依赖（共 !pip_list_count! 个） >> "%logFile%"
) else (
    echo 创建空白 requirements.txt
    echo # 项目依赖文件 > "requirements.txt"
    echo ? 已生成空白 requirements.txt >> "%logFile%"
)

:: 5. 创建标准目录结构
for %%d in (src tests docs data data/raw data/processed models notebooks .github/workflows) do (
    if not exist "%%d" mkdir "%%d" >nul
)
echo ? 已创建完整目录结构 >> "%logFile%"

:: 6. 生成 __init__.py
for %%d in (src tests) do (
    if not exist "%%d\__init__.py" echo. > "%%d\__init__.py"
)

:: 7. 生成现代 .gitignore（基于 gitignore.io）
if not exist ".gitignore" (
    echo 正在下载推荐的 Python .gitignore...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.toptal.com/developers/gitignore/api/python,windows,macos,linux,vscode,pycharm,jupyternotebooks' -OutFile '.gitignore'" >nul 2>&1
    if not exist ".gitignore" (
        echo 网络下载失败，使用内置模板
        (
            echo .venv/
            echo __pycache__/
            echo *.pyc
            echo .env
            echo .env.local
            echo *.egg-info/
            echo dist/
            echo build/
            echo .pytest_cache/
            echo .coverage
            echo htmlcov/
            echo notebooks/*.html
        ) > ".gitignore"
    )
    echo ? 已生成 .gitignore >> "%logFile%"
)

:: 8. 生成 .env 示例
if not exist ".env" (
    (
        echo # 环境变量配置
        echo APP_NAME=%~n0
        echo ENV=development
        echo DEBUG=True
        echo PORT=8000
        echo 
        echo # 数据库
        echo DATABASE_URL=sqlite:///dev.db
        echo 
        echo # API 密钥（请自行替换）
        echo OPENAI_API_KEY=sk-...
        echo SECRET_KEY=your-super-secret-key-here
    ) > ".env"
    echo ? 已生成 .env 示例（请修改后使用） >> "%logFile%"
)

:: 9. 生成 README.md（更专业版）
if not exist "README.md" (
    (
        echo # %~n0
        echo.
        echo ![Python](https://img.shields.io/badge/python-3.9+-blue.svg)
        echo ![License](https://img.shields.io/badge/license-MIT-green)
        echo.
        echo ## 项目简介
        echo 由 `setup_project.bat` 自动初始化，采用标准布局和最佳实践。
        echo.
        echo ## 快速开始
        echo ```bash
        echo # 激活虚拟环境
        echo .venv\Scripts\activate
        echo # 安装依赖
        echo pip install -r requirements.txt
        echo # 运行测试
        echo python -m unittest discover tests
        echo ```
        echo.
        echo ## 目录说明
        echo - `src/`      主源码
        echo - `tests/`     单元测试
        echo - `data/`      数据文件
        echo - `notebooks/` Jupyter 实验
        echo - `models/`    训练好的模型
        echo.
        echo Made with ?? using one-click setup
    ) > "README.md"
    echo ? 已生成专业 README.md >> "%logFile%"
)

:: 10. VSCode 工作区配置（强烈推荐）
if not exist ".vscode" mkdir ".vscode"
(
    echo {
    echo     "python.defaultInterpreterPath": ".venv/Scripts/python.exe",
    echo     "python.formatting.provider": "black",
    echo     "python.linting.enabled": true,
    echo     "python.linting.pylintEnabled": false,
    echo     "python.linting.flake8Enabled": true,
    echo     "editor.formatOnSave": true,
    echo     "files.exclude": {
    echo         "**/.venv": true,
    echo         "**/__pycache__": true
    echo     }
    echo }
) > ".vscode\settings.json"

:: launch.json 支持更多场景
(
    echo {
    echo     "version": "0.2.0",
    echo     "configurations": [
    echo         {
    echo             "name": "Run Current File",
    echo             "type": "python",
    echo             "request": "launch",
    echo             "program": "${file}",
    echo             "console": "integratedTerminal"
    echo         },
    echo         {
    echo             "name": "Run Tests",
    echo             "type": "python",
    echo             "request": "launch",
    echo             "module": "pytest",
    echo             "args": ["-v"],
    echo             "console": "integratedTerminal"
    echo         }
    echo     ]
    echo }
) > ".vscode\launch.json"
echo ? 已生成 VSCode 推荐配置 >> "%logFile%"

:: 11. 初始化 git（可选）
git init >nul 2>&1 && git add . >nul 2>&1 && git commit -m "Initial commit by setup_project.bat" >nul 2>&1
if %errorlevel% equ 0 echo ? 已初始化 git 仓库并提交首次提交 >> "%logFile%"

:: 结束
echo.
echo ==================================================
echo           项目初始化完成！
echo ==================================================
echo.
echo 下一步操作建议：
echo   1. code .                 # 打开 VSCode
echo   2. 修改 .env 文件
echo   3. 在 src/ 下开始编码
echo   4. 运行测试验证环境
echo.
echo 查看详细日志：setup.log
echo.
echo [完成] %date% %time% >> "%logFile%"
deactivate >nul 2>&1
pause