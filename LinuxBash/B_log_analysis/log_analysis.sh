#!/bin/bash
# ./log_analysis.sh example_log.log

# BASIC REQUIREMENTS & INFO:
# Using Apache log example create a script to answer the following questions:
# 1. From which ip were the most requests?
# 2. What is the most requested page?
# 3. How many requests were there from each ip?
# 4. What non-existent pages were clients referred to?
# 5. What time did site get the most requests?
# 6. What search bots have accessed the site? (UA + IP)

echo $'\n'"1.a - Number of mentions & IP address:"
awk '{ print $1}' $1 | sort | uniq -c | sort -nr | head -n 1

## In the command above - awk command prints the log file’s 1st column which contains IP address

echo "1.b - Number of mentions & IP address:" #same
cat $1 | cut -f1 -d" " | sort | uniq -c | sort -nr | head -n 1

## uniq -c - add the number of occurrences of each line
### sort -n -r :
### -n, --numeric-sort - compare according to string numerical value
### -r, --reverse - reverse the result of comparisons
#### head -n 1 - shows top1 result

echo $'\n'"2 - Top  requested page:"
cat $1 | cut -d'"' -f2 | cut -d" " -f2 | sort | uniq -c | sort -nr | head -n 1
MRP=$(cat $1 | cut -d'"' -f2 | cut -d" " -f2 | sort | uniq -c | sort -nr | head -n 1 | awk '{ print $2}')

echo $'\n'"3 - How many requests were there from each ip:"
cat $1 | cut -d" " -f-1,7 | grep $MRP | sort | uniq -c | sort -nr

echo $'\n'"4 - Non-existent pages (404):"
cat $1 | grep 404 | cut -d'"' -f2 | cut -d" " -f2 | sort | uniq -c | sort -nr 

echo $'\n'"5 - Most requests PER date/time"
awk '{ print $4}' $1 | sort | cut -d"[" -f2 | cut -d":" -f1-3 | uniq -c | sort -nr | head -n 10

echo $'\n'"6 - Search bots have accessed the site (UA + IP)"
cat $1 | cut -d" " -f-1,12-19 | sort | uniq -c | grep bot | sort -nr

