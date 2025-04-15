@echo off
setlocal

:: 安装打包依赖
pip install pyinstaller

:: 执行打包操作
pyinstaller --onefile --noconsole --name "网页服务器控制台" --add-data "index.html;." --add-data "novel.html;." --add-data "素材;素材" gui_launcher.py

:: 移动生成文件到项目根目录
move dist\网页服务器控制台.exe .
rmdir /s /q build dist

:: 生成版本信息
echo 构建完成时间：%date% %time% > version.txt