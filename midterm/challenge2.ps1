function apacheLogs (){

   $logFile = Get-Content -Path "C:\Users\champuser\SYS-320-Automating-and-Scripting\midterm\access.log"

   $LogArray = @()

   #loop through each line in the log file
   for($i=0; $i -lt $logFile.Length; $i++){
    
    $line = $logFile[$i].Split(' ') #Split the lin by spaces

    $LogArray += [pscustomobject]@{
                "IP" = $line[0]
                "Time" = $line[3].Trim('[')
                "Method" = $line[5].Trim('"')
                "Page" = $line[6]
                "Protocol" = $line[7]
                "Response" = $line[8]
                "Referrer" = $line[10].Trim('"')
            }

}
return $LogArray
}

#apacheLogs