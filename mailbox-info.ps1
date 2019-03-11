Import-Module ActiveDirectory

$mailboxes = Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox
$(Foreach ($mailbox in $mailboxes){

$user=$mailbox | Get-User
$temp=Get-ADUser -Filter 'sAMAccountName -eq $user.SamAccountName'

if ($temp.Enabled -ne $true) {$isEnabled = "Not Enabled"} Else {$isEnabled = "Enabled"}

$Stat = $mailbox | Get-MailboxStatistics | Select TotalItemSize,ItemCount,LastLogonTime

New-Object PSObject -Property @{
FirstName = $mailbox.FirstName
LastName = $mailbox.LastName
DisplayName = $mailbox.DisplayName
TotalItemSize = $Stat.TotalItemSize
ItemCount = $Stat.ItemCount
PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
ForwardingAddress = $mailbox.ForwardingAddress
ForwardingSmtpAddress = $mailbox.ForwardingSmtpAddress
DeliverToMailboxAndForward = $mailbox.DeliverToMailboxAndForward
Alias = $mailbox.Alias
LastLogon = $Stat.LastLogonTime
Status = $isEnabled
Database = $mailbox.Database
}

}) | Select FirstName,LastName,DisplayName,TotalItemSize,ItemCount,PrimarySmtpAddress,ForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward,Alias,LastLogon,Status,Database |Export-CSV C:\temp\MailboxReport.csv -NTI
