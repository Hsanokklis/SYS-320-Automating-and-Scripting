# Funciton that parses Apache log files and filters for internal network traffic (and when called outputs it into a table)

function ApacheLogs(){
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    #creates an empty array to store parsed log records
    $tableRecords = @()
    
    for($i=0; $i -lt $logsNotFormatted.Length; $i++) {
        # split a string into words 
        $words = $logsNotFormatted[$i].Split(" ");
        
        # parse each word into a structred pscustomobject and add it to the table
        $tableRecords += [pscustomobject]@{
            "IP" = $words[0];
            "Time" = $words[3].Trim('[');
            "Method" = $words[5].Trim('"');
            "Page" = $words[6];
            "Protocol" = $words[7].Trim('"');
            "Response" = $words[8];
            "Referrer" = $words[10];
            "Client" = $words[11..($words.Count -1)] -join ' '
        }
    }
    
    #Filters the records to only return entires where the IP starts with "10"
    return $tableRecords | Where-Object {$_.IP -ilike "10.*"}
}

#Calls the function and display result if we were to run it from this script. 
#$tableRecords = ApacheLogs
#$tableRecords | Format-Table -AutoSize -Wrap