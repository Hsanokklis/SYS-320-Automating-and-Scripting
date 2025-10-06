# Define the function
function Get-LoginEvents {
    param(
        [int]$Days  # Input parameter: number of days 
    )
    
    # Get login and logoff records from Windows Events
    $loginouts = Get-EventLog system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Days)
    
    # Check if any events were found before looping
    if ($loginouts) {
        $loginoutsTable = @() # Empty Array to fill customly
        for ($i=0; $i -lt $loginouts.Count; $i++) {
            # creating event property value 
            $event = ""
            if ($loginouts[$i].InstanceId -eq "7001") { $event="Logon" }
            if ($loginouts[$i].InstanceId -eq "7002") { $event="Logoff" }
            
            # Creating user Property value - Translate SID to Username
            $sid = $loginouts[$i].ReplacementStrings[1]
            try {
                $user = (New-Object System.Security.Principal.SecurityIdentifier($sid)).Translate([System.Security.Principal.NTAccount]).Value
            }
            catch {
                $user = $sid  # If translation fails, keep the SID
            }
            
            # Adding each new line (in form of a custom object) to our empty array
            $loginoutsTable += [pscustomobject]@{
                "Time"  = $loginouts[$i].TimeGenerated; `
                "Id"    = $loginouts[$i].InstanceId; `
                "Event" = $event; `
                "User"  = $user;
            }
        } # End of for loop
        
        return $loginoutsTable  # Return the results
    }
    else {
        Write-Host "No Winlogon events found in the last $Days days."
        return $null
    }
}

# Call the function with 14 days as the parameter and print results
$results = Get-LoginEvents -Days 100
$results