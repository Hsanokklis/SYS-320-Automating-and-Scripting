#!/bin/bash

# Challenge-1: Script to scrape IOC patterns from web page
# Fetches IOC.html and extracts Pattern column to IOC.txt

# get the webpage
curl -s http://10.0.17.6/IOC.html > /tmp/ioc_page.html

# extract only the Pattern column (first <td> in each row)
# get all <td> tags, extract text, and take every other line (first column only)
grep "<td>" /tmp/ioc_page.html | \
sed 's/<[^>]*>//g' | \
sed 's/^[[:space:]]*//g' | \
sed 's/[[:space:]]*$//g' | \
awk 'NR % 2 == 1' > IOC.txt

# cleanup
rm -f /tmp/ioc_page.html

echo "IOC patterns saved to IOC.txt"
