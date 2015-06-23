$PlainPassword = "Passw)rd!"
$SecurePassword = ConvertTo-SecureString "Passw)rd!" -AsPlainText -Force

$Credentials = New-Object System.Management.Automation.PSCredential("ad.example.com\saltad",$SecurePassword)

Add-Computer -DomainName ad.example.com -NewName {{ compname }} -Credential $Credentials -ComputerName . `
  -OUPath "OU=Servers,OU=WORKGROUP,DC=ad,DC=example,DC=com"