#!/bin/bash

#--------------------------------------------------------------------
# Challenge-3: Convert report.txt to HTML format
# Creates an HTML table from the report and moves it to /var/www/html
#-------------------------------------------------------------------

# creating the HTML file - print opening tags
echo "<html>" > report.html
echo "<body>" >> report.html
echo "Access logs with IOC indicators:" >> report.html
echo "<table border='1'>" >> report.html

#  Loop through report.txt line 
while IFS= read -r line; do
    # extract the three fields (IP, datetime, page)
    ip=$(echo "$line" | awk '{print $1}')
    datetime=$(echo "$line" | awk '{print $2}')
    page=$(echo "$line" | awk '{$1=""; $2=""; print $0}' | sed 's/^[ \t]*//')
    
    #create table row with table data cells
    echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>" >> report.html
done < report.txt

# close the HTML tags
echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

# move the report to web server directory
mv report.html /var/www/html/

echo "HTML report generated. You can find it at /var/www/html/report.html"
