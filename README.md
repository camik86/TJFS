# 网页服务器控制台项目文档

## 项目结构
```
A00/
├── build.bat         —— 打包构建脚本
├── install.bat       —— 环境安装脚本
├── start_server.bat  —— 服务器启动脚本
├── 素材/             —— 界面素材资源
│   ├── Startbackground*.png
│   └── 矢量插图.png
└── 网页内容/         —— 小说文本内容
    ├── 宝石-第〇章.txt
    ├── 宝石-第一章.txt
    └── ...
```

## 安装指南
1. 右键install.bat选择【以管理员身份运行】
2. 脚本将自动完成：
   - Python 3.11运行环境安装
   - Node.js 20.13运行时配置
   - 创建桌面/开始菜单快捷方式
   - 设置开机自启动

## 打包流程
```bash
# 安装打包工具
pip install pyinstaller

# 执行构建（生成单文件可执行程序）
build.bat
```
生成的`网页服务器控制台.exe`将自动出现在项目根目录，同时生成version.txt记录构建时间戳。

## 服务器控制台功能
- 可视化界面启动本地服务
- 快捷方式管理系统
- 运行状态监控
- 自动更新检测（预留）

## 扩展说明
// 此处预留未来功能扩展描述位置