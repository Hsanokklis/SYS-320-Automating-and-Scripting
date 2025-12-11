
function scrapedIOC(){

    #Get the Web page
    $page = Invoke-WebRequest -Uri http://10.0.17.6/IOC.html

    #Get all tr elements of the HTML page
    $trs = $page.ParsedHtml.body.GetElementsByTagName("tr")

    $IOCTable = @() # empty array


    for($i=1; $i -lt $trs.length; $i++){
    
        $tds = $trs[$i].getElementsByTagName("td")

        $IOCTable += [pscustomobject]@{
            "Pattern" = $tds[0].innertext;
            "Description" = $tds[1].innertext;  
           }
  }
    return $IOCTable

 }


#scrapedIOC

