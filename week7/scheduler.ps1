#---------------------------------------------------------------------------------------------------------------
# function ChooseTimeToRun 
# Description: This function checks if a task named "myTask" already exists, if it does, it will call 
# DisableAutoRun to remote it. It will then create a new schuled task that runs daily, at a specifed time. 
# It is also configured to only run when there is a network connection
#---------------------------------------------------------------------------------------------------------------
function ChooseTimeToRun($Time){

$scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

#checks to see if task already exists
if($scheduledTasks -ne $null){
    Write-Host "the task already exists." | Out-String
    DisableAutoRun #removes existing task
}

Write-Host "Creating new task." | Out-String

$action = New-ScheduledTaskAction -Execute "powershell.exe" `
          -argument "-File `"C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\main.ps1`""

$trigger = New-ScheduledTaskTrigger -Daily -At $Time #task tiggers daily 
$principal = New-ScheduledTaskPrincipal -UserId 'champuser' -RunLevel Highest #run unders highest privledges 
$settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun #only runs if there is a network connection
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

Register-ScheduledTask 'myTask' -InputObject $task

Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask"}
}

#-----------------------------------------------------------------------------------------------
#function DisableAutoRun
# Description: This function is called on by ChooseTimeToRun to delete a task if it already 
# exists. 
#-----------------------------------------------------------------------------------------------

function DisableAutoRun(){ 

$scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask"}

if($scheduledTasks -ne $null){
    Write-Host "Unregistering the task." | Out-String
    Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false
}
else{
    Write-Host "The task is not registered." | Out-String
}
}