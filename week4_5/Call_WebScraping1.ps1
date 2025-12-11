# Dot Notation 
. C:\Users\champuser\SYS-320-Automating-and-Scripting\week4_5\WebScraping.ps1

# REMINDER, we have assigned functions to varibales but we still have to call the variable. If you want to run 
# one of the variables you will need to call it. 
# Make sure to uncomment any of the block comments i.e <#, if you want to run any of the code below!

#-----------------------------------------------------------------------------------------------------------

# Assigning the gatherClasses function to the variable $classes   
$classes = gatherClasses

#varibale call (uncomment below)
#$classes

#-----------------------------------------------------------------------------------------------------------

#Assigning the daysTranslator function to the variable $DaysTranslator to call it with the $classes variable
$DaysTranslator = daysTranslator $classes

#variable call (uncomment below) 
#$DaysTranslator

#-----------------------------------------------------------------------------------------------------------

<#

# List all the classes with the Instructor Furkan Paligu
$DaysTranslator | select "Class Code", Instructor, Location, Days, "Time Start"|`
where {$_."Instructor" -ilike "Furkan Paligu"}

#>

#---------------------------------------------------------------------------------------------------

<#

#List all classes of JOYC 310 on Mondays, only display Class Code and Time. Sort by Start Time. 
$DaysTranslator | Where-Object {($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday")} |`
Sort-Object "Time Start" | `
Select-Object "Time Start", "Class Code" 

#>

#-----------------------------------------------------------------------------------------------------

# 1. Make a list of all instructors that teach at least 1 course in SYS, SEC, NET, FOR, CSI, DAT
# 2. Sort by name 
# 3. make it unique

$Instructors = $DaysTranslator | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                                ($_."Class Code" -ilike "NET*") -or `
                                                ($_."Class Code" -ilike "FOR*") -or `
                                                ($_."Class Code" -ilike "CSI*") -or `
                                                ($_."Class Code" -ilike "DAT*")`
                                                }`
                                                 | Sort-Object "Instructor"`
                                                 | Select-Object "Instructor" -Unique 
#variable call (uncomment below)
#$Instructors

#------------------------------------------------------------------------------------------------------

<# 

# 1. Group all instructors by the number of classes they are teaching 
# 2. sort by the number of classes they are teaching

$DaysTranslator | Where-Object { $_.Instructor -in $Instructors.Instructor}`
                | Group-Object "Instructor"| Select-Object Count, Name | Sort-Object Count -Descending
#>

#------------------------------------------------------------------------------------------------------



