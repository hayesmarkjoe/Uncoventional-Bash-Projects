#!/usr/bin/env bash

while true; do
    read -rp "Enter username: " user
    if grep -q "^${user}/" pass-data.txt; then
        printf "%s\n" "Username exists, choose another!"
        continue
    else
        break
    fi
done
while true; do
    read -r -s -p "Enter a password: " passwd
    echo
    read -r -s -p "Enter password again: " passwd1
    echo
    if [[ "$passwd" != "$passwd1" ]]; then
        printf "%s\n" "Passwords don't match, please re-enter"
        continue
    fi

    stored_hash=$(printf "%s" "$passwd" |openssl passwd -6 -stdin)
  

    printf "%s/%s\n" "${user}" "${stored_hash}" >> pass-data.txt
        printf "%s\n" "Success!"
        break
done
