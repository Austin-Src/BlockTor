# BlockTor
A Powershell script for blocking all TOR nodes using windows defender
NOTE: TOR will no longer function in your network after running this!

Blocking TOR on your network is as simple as downloading the powershell script above and running a schtasks job as the Admin user on your computer. Open cmd.exe as an Administrator and run the command below: 

schtasks /Create /SC HOURLY /TR "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ep Bypass -File C:\PATH-TO-SCRIPT\tor.ps1" /TN TorBlock
