### 📂 文件与目录操作

|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|显示目录内容|`dir`|`Get-ChildItem` / `ls`|
|切换目录|`cd <目录>`|`Set-Location <目录>` / `cd`|
|创建目录|`md <目录>` / `mkdir <目录>`|`New-Item -ItemType Directory -Name <目录>`|
|删除目录|`rd <目录>` / `rmdir <目录>`|`Remove-Item <路径>`|
|删除文件|`del <文件>`|`Remove-Item <文件>`|
|复制文件|`copy <源> <目标>`|`Copy-Item <源> <目标>`|
|移动文件|`move <源> <目标>`|`Move-Item <源> <目标>`|

### ⚙️ 系统与环境

|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|清屏|`cls`|`Clear-Host` / `cls`|
|输出文本|`echo 内容`|`Write-Output "内容"`|
|查看环境变量|`echo %PATH%`|`$env:PATH`|
|设置环境变量|`set 变量=值`|`$env:变量 = "值"`|
|退出|`exit`|`Exit`|

### 🔍 文件查看与搜索

|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|查看文件内容|`type <文件>`|`Get-Content <文件>`|
|查找字符串|`find "字符串" <文件>`|`Select-String "字符串" <文件>`|
|文件比较|`fc <文件1> <文件2>`|`Compare-Object (Get-Content f1) (Get-Content f2)`|

### 📡 网络相关

|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|测试网络|`ping <地址>`|`Test-Connection <地址>`|
|查看 IP 配置|`ipconfig`|`Get-NetIPAddress`|
|查看端口占用|`netstat -an`|`Get-NetTCPConnection`|
|域名解析|`nslookup <域名>`|`Resolve-DnsName <域名>`|

### 🔧 进程与服务

|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|查看进程|`tasklist`|`Get-Process`|
|结束进程|`taskkill /IM 进程名 /F`|`Stop-Process -Name 进程名`|
|查看服务|无|`Get-Service`|
|启动服务|无|`Start-Service 服务名`|
|停止服务|无|`Stop-Service 服务名`|

### 🧑‍💻 帮助与脚本
|功能|CMD 命令|PowerShell 命令|
|---|---|---|
|查看帮助|`命令 /?`|`Get-Help 命令 -Full`|
|查看可用命令|无|`Get-Command`|
|导入模块|无|`Import-Module 模块名`|
|查看已加载模块|无|`Get-Module`|
|设置脚本策略|无|`Set-ExecutionPolicy RemoteSigned`|