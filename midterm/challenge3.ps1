. "C:\Users\champuser\SYS-320-Automating-and-Scripting\midterm\challenge1.ps1"
. "C:\Users\champuser\SYS-320-Automating-and-Scripting\midterm\challenge2.ps1"

function matchIOCWithLogs(){
    # Get the IOCs from the web page
    $IOCs = scrapedIOC
    
    # Get the Apache logs
    $logs = apacheLogs
    
    # Empty array to hold matching logs
    $matchedLogs = @()
    
    # Loop through each log entry
    for($i=0; $i -lt $logs.Length; $i++){
        
        # Loop through each IOC pattern
        for($j=0; $j -lt $IOCs.Length; $j++){
            
            # Check if the Page contains the IOC pattern
            if($logs[$i].Page -like "*$($IOCs[$j].Pattern)"){
                $matchedLogs += $logs[$i]
                break  # No need to check other IOCs for this log
            }
        }
    }
    
    return $matchedLogs
}


matchIOCWithLogs