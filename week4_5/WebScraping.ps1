function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.37/courses.html

#Get all the tr elements of the HTML page 
$trs= $page.ParsedHtml.body.getElementsByTagName("tr")

#Empty array to hold results 
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ #going over every tr element
    
    #Get every td element of each tr element 
    $tds = $trs[$i].getElementsByTagName("td")
    
    # Want to seperate start time and end time into different fields
    $Times = $tds[5].innerText.Split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innertext;
                                    "Title"      = $tds[1].innertext;
                                    "Days"       = $tds[4].innertext;
                                    "Time Start" = $Times[0];
                                    "Instructor" = $tds[6].innertext;
                                    "Location"   = $tds[9].innertext;
                                    }
} #end of for loop
return $FullTable
}

# call function to test that it works! 
# gatherClasses

# -----------------------------------------------------------------------------------------------------------------

#Funcation to turn days property into an array

function daysTranslator($FullTable){

# Go over every record in the table 
for($i=0; $i -lt $FullTable.length; $i++){

    #Empty array to hold days for every record
    $Days = @()

    #If you see "M" --> Monday 
    if($FullTable[$i].Days -ilike "*M*") {$Days += "Monday"}

    #If you see "T" followed by T,W or F --> Tuesday 
    if($FullTable[$i].Days -ilike "*T[W,F]*") {$Days += "Tuesday"}


    #If you see "W" --> Wednesday 
    if($FullTable[$i].Days -ilike "*W*") {$Days += "Wednesday"}

    #If you see "TH" --> Thursday  
    if($FullTable[$i].Days -ilike "*TH*") {$Days += "Thursday"}


    #If you see "F" --> Friday 
    if($FullTable[$i].Days -ilike "*F") {$Days += "Friday"}

    
    #Switch from abbreviation to full name
    $FullTable[$i].Days = $Days

} #end of for loop
return $FullTable
}
    