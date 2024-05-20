#!/bin/bash

echo "Welcome to the LowlandMC Server Shell"
echo "Type 'exit' to quit."

while true; do
    echo -n "LowlandSh >>> "

    read -r cmd

    if [[ "$cmd" == "exit" ]]; then
        echo "Goodbye!"
        break
    fi

    echo "$cmd" > input.io
    sleep 1
    tail -n 1 "./output.txt"
    echo "Done"
done
