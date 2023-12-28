#!/bin/bash


FILE_NAME="users.json"

echo "[]" > "$FILE_NAME"

while IFS=':' read -r USERNAME x x x x HOME SHELL
do
   # If the home or shell details are empty, assign "NotDefined"
   if [ -z "$HOME" ]
    then
        HOME="NotDefined"
    fi

    if [ -z "$SHELL" ]
    then
        SHELL="NotDefined"
    fi
    

echo "$(jq -n --arg username "$USERNAME" --arg home "$HOME" --arg shell "$SHELL" '{username: $username, home: $home, shell: $shell}' $FILE_NAME)" >> $FILE_NAME









