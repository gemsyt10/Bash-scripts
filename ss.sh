#!/bin/bash
#список серверів
version="1.0 beta"
declare -A servers

servers[book]="/data/data/com.termux/files/home/downloads/new_Dir1/My_web_book/serv.js"
servers[bot1]="/data/data/com.termux/files/home/downloads/new_Dir1/my_bots/my_bot1/index.js"
servers[ubuntu]="/data/data/com.termux/files/home/FS_UBUNTU/server.js"
#servers[назва]="шлях"

if [[ $1 == "-h" ]]; then 
    echo -e "ss -parametr value/void\n-h - command help (does not support parameters).\n-s - server startup, first parameter name with \"ss -l\".\n-l - shows a list of your available servers (does not support parameters. the list can be edited by you)"
elif [[ $1 == "-s" ]]; then
    if [[ -n "$2" ]]; then
        if [[ -n "${servers[$2]}" ]]; then
            echo "Starting to server..."
            node "${servers[$2]}"
        else
            echo "server not found or invalid name"
        fi
    else 
        echo "you not press two argument, name server for list."
    fi
elif [[ $1 == "-l" ]]; then
    list=""
    for key in "${!servers[@]}"; do
        list="$list $key"
    done
    echo -e "youre servers:\n$list"
elif [[ $1 == "-v" ]]; then
    echo "Start Server V$version"
else
    echo "comnand not found..."
fi
