@echo off
setlocal enabledelayedexpansion

:: 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 正在请求管理员权限...
    PowerShell Start -WindowStyle Hidden -Verb RunAs -ArgumentList '%~f0'
    exit /b
)

:: 环境检查
set PYTHON_URL=https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe
set NODE_URL=https://npmmirror.com/mirrors/node/v20.13.1/node-v20.13.1-x64.msi

:: 安装Python环境
where python >nul 2>&1
if %errorLevel% neq 0 (
    echo 正在安装Python运行时...
    curl -Lo python-installer.exe !PYTHON_URL!
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python-installer.exe
)

:: 安装Node.js环境
where npm >nul 2>&1
if %errorLevel% neq 0 (
    echo 正在安装Node.js运行时...
    curl -Lo node-installer.msi !NODE_URL!
    msiexec /i node-installer.msi /quiet /norestart
    del node-installer.msi
)

:: 创建快捷方式
set SCRIPT_PATH=%~dp0gui_launcher.exe
set LINK_NAME=网页服务器控制台

:: 桌面快捷方式
PowerShell "$ws=New-Object -ComObject WScript.Shell; $lnk=$ws.CreateShortcut('%USERPROFILE%\Desktop\%LINK_NAME%.lnk'); $lnk.TargetPath='%SCRIPT_PATH%'; $lnk.Save()"

:: 开始菜单快捷方式
PowerShell "$ws=New-Object -ComObject WScript.Shell; $lnk=$ws.CreateShortcut('$env:APPDATA\Microsoft\Windows\Start Menu\Programs\%LINK_NAME%.lnk'); $lnk.TargetPath='%SCRIPT_PATH%'; $lnk.Save()"

:: 设置开机启动
copy /y "%SCRIPT_PATH%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" >nul

echo 安装完成，按任意键启动程序...
pause >nul
start "" "%SCRIPT_PATH%"