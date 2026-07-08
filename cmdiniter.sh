#!/bin/bash
version="1.0 beta"
par0="$0"
initCommand() {
    fileName="${1%.sh}"
    echo "$1  $fileName"
    mv "$1" "$fileName"
    chmod a+x "$fileName"
    cp "$fileName" "$PREFIX/bin/"
    chmod a+x "$PREFIX/bin/$fileName"
    echo -e "\e[92mSuccessfully installed command $fileName\e[0m"
}
initCommandAndAutoRemove() {
    initCommand "$1"
    rm -- "${1%.sh}"
    rm -- "$par0" "${par0%.sh}"
}

if [[ $1 == "-h" ]]; then
    echo -e "cmdiniter param1 value/void\n-h - command help (does not support parameter value and other parameters).\n-i - initialize the .sh file into a command (argument does not support value).\n-ar - automatic removal of the installer and the .sh file after initialization (does not support parameter value and other parameters).\n-v - program version.\n\nparameters -h, -v do not support additional parameters!"
elif [[ $1 == "-v" ]]; then
    echo "Command Initer V$version"
elif [[ $1 == "-i" && $2 != "-ar" ]]; then
    read -p "Enter path file with inited on command: " FILE
    initCommand "$FILE"
elif [[ $1 == "-ar" && $2 == "-i" || $1 == "-i" && $2 == "-ar" ]]; then
    read -p "Enter path file with inited on command: " FILE
    initCommandAndAutoRemove "$FILE"
else 
    echo -e "\e[91mArgument not valid!\e[0m"
fi

