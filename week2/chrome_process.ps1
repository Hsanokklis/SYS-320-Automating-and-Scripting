# Check if Chrome is running
$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($crome) {
    # Chrome is running, so stop it
    Write-Host "Chrome is running. Stopping all Chrome processes..."
    Stop-Process -Name "chrome" -Force
    Write-Host "Chrome stopped."
} else {
    # Chrome is not running, so start it
    Write-Host "Chrome is not running. Starting Chrome with Champlain.edu..."
    Start-Process "chrome.exe" "https://champlain.edu"
    Write-Host "Chrome started."
}