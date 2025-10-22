$scraped_page = Invoke-WebRequest -Uri http://10.0.17.37/ToBeScraped.html

#Get a count of the links in the page
$linkCount = $scraped_page.Links

Write-Host "Number of links on the page: $linkCount"
 

