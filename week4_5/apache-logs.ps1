# Function called Apache-Logs that takes 3 inputs, page visited, http code returned, and name of web browser

function Get-ApacheLogs {
    param(
        $page_visited_,
        $http_code,
        $browser_name
    )

    #Store log content from access.log
    $logContent = Get-Content C:\xampp\apache\logs\access.log

    #Filter Logs
    $filteredLogs = $logContent | Where-Object {
        $_ -like "*$page_visited*" -and
        $_ -like "*$http_code*" -and
        $_ -like "*$browser_name*"
    }

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
    $ips = $regex.Matches($filteredLogs)

    #Extract and return IP address
    $ips.Value
}



