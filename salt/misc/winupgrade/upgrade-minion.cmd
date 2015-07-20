C:\salt\upgrade.exe /S /master=salt.{{ pillar['domain'] }} /minion-name:%COMPUTERNAME%
sleep 60
net start salt-minion
exit
