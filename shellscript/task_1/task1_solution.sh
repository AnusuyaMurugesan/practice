#!/bin/bash


#1 Create files with 4 different extensions

EXTENSIONS=("txt" "json" "yml" "yaml")
DATE=$(date)

for number in {1..5}
do
	for extensions in ${EXTENSIONS[@]}
	do
    	FILE_NAME=file-${number}.${extensions}
    	touch $FILE_NAME
    	echo "File created successfully on $DATE" > $FILE_NAME
   	done
done

#2 List files with .json and .yaml extensions
echo "List of .json files:"
ls *.json

echo "List of .yaml files:"
ls *.yaml

#3 Rename .yaml files to .yml
for file in *.yaml
do
    if [ "${file##*.}" = "yaml" ]
     then
        mv "$file" "${file%.yaml}-renamed.yml"
        echo "Renamed $file to ${file%.yaml}-renamed.yml"
    else
        echo "${file} is already in .yml format. Skipping."
    fi
done


#4 Search for "success" inside files and move them to success folder
if [ ! -d "success" ]
then
    mkdir success
fi

if [ ! -d "archive" ]
then
    mkdir archive
fi

for file in *
do
	if grep -q "success" "$file"
		then
       		 mv "$file" success/
        	echo "Moved $file to success folder."

    	elif [ "$file" != "success" ] 
         	then
         	mv "$file" archive/
         	echo "Moved $file to archive folder."
     	fi
    
done
