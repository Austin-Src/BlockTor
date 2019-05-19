# BlockTor
A Powershell script for blocking all TOR nodes using windows defender
NOTE: TOR will no longer function in your network after running this!
NOTE 2: Improper setup of the script can create firewall rules that block ALL IP's, so be prepared for this during setup

Follow the steps below to enable the block:
1. Download tor.ps1 and change the three C:\PATH-TO-DOWNLOAD entries to a filepath your script will have read/write access to.
2. From an Admin prompt, run the following command to enable the script to run hourly. Again, change C:\PATH-TO-DOWNLOAD

schtasks /Create /SC HOURLY /TR "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ep Bypass -File C:\PATH-TO-DOWNLOAD\tor.ps1" /TN TorBlock

3. From Task Scheduler change the scheduled task to have full permissions
4. Lastly, attempt to run the task manually to ensure no permissions are blocking it from performing correctly.
