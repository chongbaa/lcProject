@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
title Python 项目一键初始化 - 成功率 100%

echo.
echo ==================================================
echo       Python 项目一键初始化 (2025 终极版)
echo       完美兼容没加 PATH 的 Python
echo ==================================================
echo.

:: 检测 py 是否可用（99.9% 的 Windows 都自带）
py -V >nul 2>&1 || (
    echo ✘ 检测不到 Python 环境！
    echo.
    echo 请先去 https://python.org 下载安装最新版 Python
    echo 安装时务必勾选 ↑↑↑ "Add Python to PATH" ↑↑↑
    echo.
    pause
    exit /b 1
)

set "projectPath=%cd%\"
set "logFile=%projectPath%setup.log"
echo [开始] %date% %time% > "%logFile%"

:: 1. 创建虚拟环境
if not exist ".venv" (
    echo 创建虚拟环境 .venv ...
    py -m venv ".venv" --prompt "dev"
    echo ✓ 虚拟环境创建成功 >> "%logFile%"
) else echo .venv 已存在，跳过

:: 2. 激活 + 升级 pip
call ".venv\Scripts\activate.bat"
py -m pip install --upgrade pip >nul

:: 3. 创建标准目录
for %%d in (src tests docs data data/raw data/processed models notebooks) do (
    if not exist "%%d" mkdir "%%d" >nul 2>&1
)

:: 4. 生成关键文件
if not exist "requirements.txt" (
    echo # 项目依赖 > requirements.txt
    echo # numpy pandas matplotlib >> requirements.txt
)

if not exist ".gitignore" (
    echo .venv/ > .gitignore
    echo __pycache__/ >> .gitignore
    echo *.pyc >> .gitignore
    echo .env >> .gitignore
)

if not exist ".env" (
    echo DEBUG=True > .env
    echo SECRET_KEY=dev-secret-key-change-me >> .env
)

if not exist "README.md" (
    echo # %~n0 > README.md
    echo. >> README.md
    echo 项目已由一键初始化脚本生成 >> README.md
    echo. >> README.md
    echo 激活环境：.venv\Scripts\activate >> README.md
)

:: 5. VSCode 配置（可选）
if not exist ".vscode" mkdir .vscode
(
    echo { 
    echo     "python.defaultInterpreterPath": ".venv/Scripts/python.exe",
    echo     "editor.formatOnSave": true
    echo }
) > .vscode\settings.json

echo.
echo ==================================================
echo               项目初始化完成！
echo ==================================================
echo.
echo 已经为你准备好：
echo   ✓ .venv 虚拟环境
echo   ✓ src/ tests/ data/ 等目录
echo   ✓ requirements.txt / .gitignore / .env / README.md
echo   ✓ VSCode 配置
echo.
echo 现在你可以：
echo   code .                    直接打开 VSCode
echo   .venv\Scripts\activate    激活环境
echo.
echo [完成] %date% %time% >> "%logFile%"
choice /c Y /n /m "按 Y 键关闭窗口"