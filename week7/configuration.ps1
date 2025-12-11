
#--------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------
# For this assignment we are creating 3 functions to create a configuration menu that allows a user to view a configuration file 
# that shows how long logs will be kept. The user will also be able to change the configuration of that file. 
# Function 1: readConfiguration
# Fucntion 2: changeConfiguration
# Function 3: configurationMenu
#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

#defines path for config file in a variable

$configFile="C:\Users\champuser\SYS-320-Automating-and-Scripting\week7\configuration.txt"

#------------------------------------------------------------------------------------------------------------------------

function readConfiguration {
    # Check if configuration file exists
    if (Test-Path "$configFile") {
        # Read all lines from the file
        $lines = Get-Content "$configFile"
        
        # Create a custom object with Days and Execution Time properties
        $configObject = [PSCustomObject]@{
            Days = $lines[0]
            ExecutionTime = $lines[1]
        }
        
        # Return the object
        return $configObject
    }
    else {
        # File doesn't exist
        Write-Host "Error: Configuration file not found!"
        return $null
    }
}

#-----------------------------------------------------------------------------------------------

function changeConfiguration {
    Write-Host "`nChanging Configuration..."
    
    # Step 1: Get and validate Days
    $daysValid = $false
    
    while (-not $daysValid) {
        $newDays = Read-Host "Enter the number of days for which the logs will be obtained"
        
        # Validate: only digits
        if ($newDays -match '^\d+$') {
            $daysValid = $true
        }
        else {
            Write-Host "Invalid input! Days must contain only digits. Please try again."
        }
    }
    
    # Step 2: Get and validate Execution Time
    $timeValid = $false
    
    while (-not $timeValid) {
        $newTime = Read-Host "Enter the daily execution time of the script"
        
        # Validate: H:MM AM/PM format
        if ($newTime -match '^\d{1,2}:\d{2}\s(AM|PM)$') {
            $timeValid = $true
        }
        else {
            Write-Host "Invalid input! Time must be in format H:MM AM/PM (e.g., 1:30 PM). Please try again."
        }
    }
    
    # Step 3: Write to configuration file
    $newConfig = @($newDays, $newTime)
    Set-Content -Path "$configFile" -Value $newConfig
    
    # Step 4: Confirm success
    Write-Host "`nConfiguration Changed Successfully!" 
}

#-----------------------------------------------------------------------------------------------------------------------

function configurationMenu {
    $continue = $true
    
    while ($continue) {
        # Display menu
        Write-Host "`n"
        Write-Host "Welcome to the configuration change menu! Choose your option:"
        Write-Host "------------------------------------------------"
        Write-Host "1.Show Configuration"
        Write-Host "2.Change Configuration"
        Write-Host "3.Exit"
        Write-Host "`n"
        
        # Get user input
        $choice = Read-Host "Enter your choice (1, 2, or 3)"
        
        # Validate input
        if ($choice -match '^[1-3]$') {
            # Valid input - process it
            switch ($choice) {
                "1" {
                    # Call the function
                     $readingConfig = readConfiguration
                    
                    if ($readingConfig -ne $null) {
                        # Display the configuration
                        Write-Host "`nDays ExecutionTime"
                        Write-Host "---------------"
                        Write-Host "$($readingConfig.Days)   $($readingConfig.ExecutionTime)"
                        
                        # Wait for user to press Enter
                        Write-Host "`nPress Enter to continue..."
                        Read-Host
                    }
                }
                "2" {
                    # Call changeConfiguration
                    changeConfiguration
                    
                    # Pause before returning to menu
                    Write-Host "`nPress Enter to continue..." 
                    Read-Host
                }
                "3" {
                    Write-Host "`nI guess all good things come to an end :("
                    $continue = $false  # This exits the loop
                }
            }
        }
        else {
            # invalid input
            Write-Host "`nInvalid choice! Please enter only 1, 2, or 3."
    }
}}


configurationMenu