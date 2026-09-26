#!/usr/bin/env bash


read -rp "Enter username: " uname
if grep -q "^$uname/" pass-data.txt; then
    :        
    else
        printf "%s\n" "Username doesn't exist"
    exit 1
    fi

attempts=0
while [[ attempts -lt 3 ]]; do
    read -sp "Enter password: " pass
    echo
    (( attempts++ ))
    
    # store the line we're looking for, then save everything after user in var stored_hash    
    stored_line=$(grep "^$uname/" pass-data.txt)
    stored_hash="${stored_line#*/}"


    salt=$(cut -d'$' -f3 <<< "$stored_hash")
    computed=$(openssl passwd -6 -salt "$salt" "$pass")

    if [[ "$computed" == "$stored_hash" ]]; then
        printf "%s\n" "WELCOME!!"
        break
    else 
        printf "%s\n" "Invaid password, try again: "
        
    fi
done
    
    


