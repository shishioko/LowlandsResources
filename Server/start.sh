#!/bin/bash
latest_version=$(curl "https://api.purpurmc.org/v2/purpur" | jq -r ".versions[-1]")
latest_build=$(curl "https://api.purpurmc.org/v2/purpur/${latest_version}" | jq -r ".builds.latest")
if [ ! -e "./version.txt" ]; then echo "0.0" > "./version.txt"; fi
if [ ! -e "./build.txt" ]; then echo "0" > "./build.txt"; fi
current_version=$(<"./version.txt")
current_build=$(<"./build.txt")
if [ ${latest_version} != ${current_version} ] || [ ${latest_build} != ${current_build} ]; then
    if [ $(curl "https://api.purpurmc.org/v2/purpur/${latest_version}/${latest_build}" | jq -r ".result") = "SUCCESS" ]; then
        curl "https://api.purpurmc.org/v2/purpur/${latest_version}/${latest_build}/download" > "./server.jar"
        echo ${latest_version} > "./version.txt"
        echo ${latest_build} > "./build.txt"
    fi
fi
{
    mkfifo "./input.io" 2> "/dev/null"
    tail -n +1 -f "./input.io" | java -Xmx16G -Xms1G -jar "./server.jar" nogui > "./output.txt" &
    pid=$!
    echo ${pid} > "./pid.txt"
    wait ${pid}
    rm "./pid.txt"
} &> "/dev/null" &
disown
