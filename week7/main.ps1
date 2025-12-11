# Dot source the required script files
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\Event-Logs.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\Email.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\scheduler.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\configuration.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\String-Helper.ps1"

# Obtaining configuration
$configuration = readConfiguration

# Obtaining at risk users
$failed = atRiskUsers $configuration.Days

# Sending at risk users as email
SendAlertEmail ($failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun $configuration.ExecutionTime