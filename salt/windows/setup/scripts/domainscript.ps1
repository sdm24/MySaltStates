$PlainPassword = "{{ pillar['domainJoinPass'] }}"
$SecurePassword = ConvertTo-SecureString "{{ pillar['domainJoinPass'] }}" -AsPlainText -Force

$Credentials = New-Object System.Management.Automation.PSCredential("prod.{{ pillar['domain'] }}\{{ pillar['domainJoinUser'] }}",$SecurePassword)

Add-Computer -DomainName prod.{{ pillar['domain'] }} -NewName {{ compname }} -Credential $Credentials -ComputerName . `
  -OUPath "OU=Servers,DC=prod,DC=example,DC=com"