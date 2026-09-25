#!/usr/bin/env bash

read -p "Enter userame: " username
read -s -p "Enter password: " passwd
echo

. ./stored_hash
stored_hash=$(openssl passwd -6 -salt xyz "$psswd")

typed_hash=$(openssl passwd -6 -salt xyz "$passwd")

if [[ $username == "admin" && $typed_hash == "$stored_hash" ]]; then
    printf "%s\n" "valid user"
else
    printf "%s\n" "invalid user"
fi
