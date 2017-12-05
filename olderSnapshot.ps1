Param([parameter(Mandatory = $true)] [alias("s")] $server,
      [parameter(Mandatory = $true)] [alias("u")] $user,
      [parameter(Mandatory = $true)] [alias("p")] $password,
      [parameter(Mandatory = $true)] [alias("d")] $days)

Import-Module DataONTAP

$passwd = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $user, $passwd
$nctlr = Connect-NcController $server -Credential $cred
$olderthan = (get-date).adddays(-$days) 
Get-Ncvol | Get-NcSnapshot  | where-object { $_.created -lt $olderthan } | Format-Table -Property Vserver,Volume,Name,Created,Dependency -AutoSize
