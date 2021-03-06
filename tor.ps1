# Pull down and store current TOR node IP's
[Net.ServicePointManager]::SecurityProtocol = "Tls12, Tls11, Tls, Ssl3"
Invoke-WebRequest -Uri https://www.dan.me.uk/torlist/ -OutFile C:\PATH-TO-DOWNLOAD\nodes.txt

# Get new data for rules
$lines = 0
$lines = gc C:\PATH-TO-DOWNLOAD\nodes.txt | Measure-Object -Line | Select-Object -expand Lines
$iterations = (($lines-$lines%1000)/1000) + 1

# Quit the program if no data was pulled down
if($lines -lt 5) { 
	Write-Host Server limited to one request every 30 minutes
	exit 
}

# Delete all created TorBlock rules
# Dumps all rules and parses for "TorBlock" and "TorBlocker
$total = Get-NetFireWallRule -All | Select-String TorBlock | Measure-Object -Line | Select-Object -expand Lines
for ($t = 0; $t -lt $total/2; $t++) {
	$name = "TorBlock$t"
	$name2 = "TorBlocker$t"

	Remove-NetFireWallRule -DisplayName $name
	Remove-NetFireWallRule -DisplayName $name2
}

# Set New Firewall rules banning TOR IP's by the 1000's
# (Maximum number of IP's allowed per rule is 1000)
for($i = 0; $i -lt $iterations; $i++) {
	$skip = $i * 1000
	$ips = gc C:\PATH-TO-DOWNLOAD\nodes.txt | Select -First 1000 -Skip $skip
	$name = "TorBlock$i"
	$name2 = "TorBlocker$i"
	New-NetFirewallRule -Direction Outbound -DisplayName $name -Name $name -RemoteAddress $ips -Action Block -ea "SilentlyContinue"
	New-NetFirewallRule -Direction Inbound -DisplayName $name2 -Name $name2 -RemoteAddress $ips -Action Block -ea "SilentlyContinue"
}

# Cleanup program leftovers
rm nodes.txt
