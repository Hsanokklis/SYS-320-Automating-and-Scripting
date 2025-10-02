cd C:\Users\champuser\SYS-320-Automating-and-Scripting\week2

$files=(Get-ChildItem)
for ($j=0; $j -le $files.Length; $j++){
    #Write-Host $files[$j].Name
    
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}