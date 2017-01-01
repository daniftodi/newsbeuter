#!/bin/bash
IFS=$'\n' # make newlines the only separator

INPUT_FILE="urls"
OUTPUT_FILE="urls"

#check each url if HTTP header is 2xx or 3xx
for url in $(cat $INPUT_FILE)    
do
	#skip line comments
 	if [[ "$url" =~ \#.* ]];then
		echo $url >> "$OUTPUT_FILE"
		continue
	fi
	echo "Checking $url..."	
	curl --max-time 5 -s --head "$url" | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
  	if [ "$?" -eq "0" ];then
		echo "$url" >> "$OUTPUT_FILE"
	fi
done
