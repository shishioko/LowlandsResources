#!/bin/bash

#Configuration:
application=~/minecraft/development/

#Code:
echo "Welcome to Shishishell!"
echo "Use empty inputs to refresh the console."
line=$(wc -l < "${application}/output.txt")
while true; do
    echo -n "> "
    read -r command
    output=$(tail -n +$((line+1)) "${application}/output.txt")
    echo -n ${output}
    newlines=0
    if [ "${output}" != "" ]; then
        newlines=$(echo "${output}" | wc -l)
        echo ""
    fi
    line=$[${line} + ${newlines}]
    if [ "${command}" != "" ]; then
        echo "${command}" > "${application}/input.io"
    fi
done
