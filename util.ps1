Invoke-WebRequest -Uri "https://dl.walletbuilders.com/download?customer=f830b234dde6317ad57bf35703eb5f9c8fc26adf6727a569c8&filename=fortress-qt-windows.zip" -OutFile "$HOME\Downloads\fortress-qt-windows.zip"

Start-Sleep -s 15

Expand-Archive -LiteralPath "$HOME\Downloads\fortress-qt-windows.zip" -DestinationPath "$HOME\Desktop\Fortress"

$ConfigFile = "rpcuser=rpc_fortress
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com"

New-Item -Path "$env:appdata" -Name "Fortress" -ItemType "directory"
New-Item -Path "$env:appdata\Fortress" -Name "Fortress.conf" -ItemType "file" -Value $ConfigFile

$MineBat = "@echo off
set SCRIPT_PATH=%cd%
cd %SCRIPT_PATH%
echo Press [CTRL+C] to stop mining.
:begin
 for /f %%i in ('fortress-cli.exe getnewaddress') do set WALLET_ADDRESS=%%i
 fortress-cli.exe generatetoaddress 1 %WALLET_ADDRESS%
goto begin"

New-Item -Path "$HOME\Desktop\Fortress" -Name "mine.bat" -ItemType "file" -Value $MineBat

Start-Process "$HOME\Desktop\Fortress\fortress-qt.exe"

Start-Sleep -s 15

Set-Location "$HOME\Desktop\Fortress\"
Start-Process "mine.bat"