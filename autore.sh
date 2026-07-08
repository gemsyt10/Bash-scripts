#!/bin/bash
version="1.0"

if [[ "$1" == "" || "$1" == "-h" ]]; then
    echo -e "autore parameter\n-h — help on command.\n-init — initilialisation and create autore_conf.txt. (please enter file path on the autore config.)\n-s — start nodejs server or script, on dev mode (auto restart when changes file on config).\n-v — program version."
elif [[ "$1" == "-v" ]]; then
    echo -e "\e[94mNodeJS script Auto Restarter "$version"\e[0m"
elif [[ "$1" == "-init" ]]; then
    read -p "Please enter path to file: " file
    touch autore-conf.txt 
    echo "$file" > autore-conf.txt
    echo -e "\e[92mautore config initilized!\e[0m"
elif [[ "$1" == "-s" ]]; then
    config=$(<autore-conf.txt)
    node "$config" &
    PID=$!
    lastModified=$(stat -c %Y "$config")
    while true; do
        sleep 1
        newModified=$(stat -c %Y "$config")
        if [[ "$newModified" != "$lastModified" ]]; then
            echo "Файл \"$config\" змінено, перезапускаю сервер..."
            kill "$PID"
            node "$config" &
            PID=$!
            lastModified=$newModified
        fi
    done
fi
