#---------------------------------------------------------------------------------------------------------------
# function ChooseTimeToRun 
# Description: This function checks if a task named "myTask" already exists, if it does, it will call 
# DisableAutoRun to remove it. It will then create a new scheduled task that runs daily, at a specified time. 
# It is also configured to only run when there is a network connection
#---------------------------------------------------------------------------------------------------------------
function ChooseTimeToRun($Time){
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }
    
    # checks to see if task already exists
    if($scheduledTasks -ne $null){
        Write-Host "The task already exists."
        DisableAutoRun  # removes existing task
    }
    
    Write-Host "Creating new task."
    
    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
          -Argument "-File `"C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\main.ps1`""
    
    $trigger = New-ScheduledTaskTrigger -Daily -At $Time  # task triggers daily 
    
    $principal = New-ScheduledTaskPrincipal -UserId 'champuser' -RunLevel Highest  # run under highest privileges 
    
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun  # only runs if there is a network connection
    
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
    
    Register-ScheduledTask 'myTask' -InputObject $task
    
    # Display the task in a table format
    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" } | Format-Table -Property TaskPath, TaskName
}

#-----------------------------------------------------------------------------------------------
# function DisableAutoRun
# Description: This function is called on by ChooseTimeToRun to delete a task if it already 
# exists. 
#-----------------------------------------------------------------------------------------------
function DisableAutoRun(){ 
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask"}
    
    if($scheduledTasks -ne $null){
        Write-Host "Unregistering the task."
        Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false
    }
    else{
        Write-Host "The task is not registered."
    }
}