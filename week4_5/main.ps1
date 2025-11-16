# Dot source the function
. C:\Users\champuser\SYS-320-Automating-and-Scripting\week4_5\apache-log.ps1

# Get user input
$page = Read-Host "Enter the page visited (index.html,page1.html,pag2.html,page3.html)"
$code = Read-Host "Enter the HTTP response number (404,200,400,304)"
$browsername = Read-Host "Enter the name of the browser (Chrome or Mozilla)"

# Call your function
$ips = Get-ApacheLogs -page_visited_ $page -http_code $code -browser_name $browsername

# Count IPs starting with "10."
$ipsoftens = $ips | Where-Object { $_ -like "10.*" }
$counts = $ipsoftens | Group-Object | Select-Object Count, Name
$counts