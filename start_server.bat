@echo off
set ROOT_DIR=%~dp0
set PORT=5050

echo 正在检测Python环境...
py --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo 使用Python启动HTTP服务器...
    start "" cmd /k "cd /d %ROOT_DIR% && py -m http.server %PORT%"
    exit /b
)

echo 正在检测Node.js环境...
npm --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 正在安装http-server...
    npx --yes http-server@14.1.1 -g
)

echo 使用Node.js http-server启动...
start "" cmd /k "cd /d %ROOT_DIR% && npx http-server -p %PORT% -c-1"