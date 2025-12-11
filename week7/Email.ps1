function SendAlertEmail($Body){

$From = "hannelore.sanokklis@mymail.champlain.edu"
$To = "hannelore.sanokklis@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "xxxx xxxx xxxx xxxx" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}

SendAlertEmail "give em the ol'razzle dazzle"

