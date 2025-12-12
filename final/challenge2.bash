#!/bin/bash

#-----------------------------------------------------------------------
# Challenge-2: Script to search Apache logs for indicators of compromise
# 1. Takes two inputs: log file and IOC file
# 2. Outputs: IP, date/time, and page accessed for matching entries
# 3. Saves output to report.txt
#-----------------------------------------------------------------------

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

LOG_FILE=$1
IOC_FILE=$2

# clear/create the report file
> report.txt

#read each IOC pattern and search for it in the log file
while IFS= read -r pattern; do
    # Search for the pattern in the log file
    grep -F "$pattern" "$LOG_FILE" | while IFS= read -r line; do
        # extract IP (first field)
        ip=$(echo "$line" | awk '{print $1}')
        
        # extract date/time and remove timezone
        datetime=$(echo "$line" | grep -o '\[[^]]*\]' | tr -d '[]' | sed 's/ [+-][0-9]*//')
        
        # extract page path
        page=$(echo "$line" | grep -o '"[^"]*"' | head -1 | sed 's/"//g' | awk '{print $2}')
        
        # Output to report.txt
        echo "$ip $datetime $page" >> report.txt
    done
done < "$IOC_FILE"

echo "Report generated: report.txt"
