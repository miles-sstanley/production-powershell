$ProgressPreference="SilentlyContinue"
Add-PSSnapin Microsoft.Exchange.Management.Powershell.Admin -ErrorAction SilentlyContinue|out-null
Add-PSSnapin Microsoft.Exchange.Management.Powershell.E2010 -ErrorAction SilentlyContinue|out-null
Add-PSSnapin Microsoft.Exchange.Management.Powershell.SnapIn -ErrorAction SilentlyContinue|out-null
Get-MailboxDatabase -status | select ServerName,Name,@{Name="DatabaseSize";Expression={ $_.DatabaseSize.ToGB() }} | where {$_.DatabaseSize -gt 200}
