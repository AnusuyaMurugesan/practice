#!/bin/bash

# Fetch GitHub repository details and save in a file
curl -s https://api.github.com/users/vigneshsweekaran/repos > repositories.json


total_repos=0
master_branch_repos=0
created_this_year=0
created_last_year=0

# Loop through repositories 
while read -r repo
do
    is_fork=$(jq -r '.fork' <<< "$repo")
    default_branch=$(jq -r '.default_branch' <<< "$repo")
    created_at=$(jq -r '.created_at' <<< "$repo")

    # Count total repos excluding forks
    ((total_repos++))
    
    # Count repos with default branch as 'master' excluding forks
    if [[ $is_fork == "false" && $default_branch == "master" ]]
    then
        ((master_branch_repos++))
    fi
    
    # Count repos created this year and last year excluding forks
    year_created=$(date -d "$created_at" +'%Y')
    if [[ $is_fork == "false" ]]
    then
        if [[ $year_created -eq $(date +'%Y') ]]
         then
            ((created_this_year++))
        elif [[ $year_created -eq $(( $(date +'%Y') - 1 )) ]]
        then
            ((created_last_year++))
        fi
    fi
done <<< "$(jq -c '.[]' < repositories.json)"


echo "Total non-forked repositories: $total_repos"
echo "Repositories with default branch as 'master': $master_branch_repos"
echo "Repositories created this year: $created_this_year"
echo "Repositories created last year: $created_last_year"

