. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week6\Event-Logs.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\Email.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\scheduler.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\configuration.ps1"

#Obtaining Configuration 

$configuration = Get-Content "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\configuration.txt"

#Obtaining at risk users 
$Failed = at_risk_users($configuration[0])

#Sending at risk users as email
SendAlertEmail($Failed | Format-Table | Out-String)

#Setting the script to run daily
ChooseTimeToRun($configuration[1])