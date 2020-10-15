#!/usr/bin/bash

# If you have "Weather 🌐" message:
# 1. Check your network connectin
# 2. Check your API token

if [ -z $1 ]; then
    echo "No latitude specified"
    exit 1
elif [ -z $2 ]; then
    echo "No longtitude specified"
    exit 1
elif [ -z $3 ]; then
    echo "No openweathermap token specified"
    exit 1
fi

testCommand() {
    $1 > /dev/null 2>&1
    if (($(echo $?) == 127)); then
        return 1
    else
        return 0
    fi
}

if testCommand "jq --version"; then :; else
    echo "No jq installed"
    echo "Run: sudo pacman -S jq"
    exit 1
fi

if testCommand "bc --version"; then :; else
    echo "No bc installed"
    echo "Run: sudo pacman -S bc"
    exit 1
fi

round() {
    echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
}

currentTimestamp=$(date +%s)
targetTimestamp=$(($currentTimestamp + 60 * 60 * 2))

currentWeather="null"
futureWeather="null"

res=$(curl --silent --max-time 20 \
    "https://api.openweathermap.org/data/2.5/onecall?lat=$1&lon=$2&exclude=minutely,daily&appid=$3"
)

if [ -n "$res" ]; then
    currentWeather=$(echo $res | jq .current)
    for ((i = 0; ; i++)); do
        if [ "$(echo $res | jq .hourly[$i])" = "null" ]; then
            futureWeather="null"
            break
        fi
        futureWeather=$(echo $res | jq .hourly[$i])
        if [ "$(echo $futureWeather | jq .dt)" -ge "$targetTimestamp" ]; then
            break
        fi
    done
fi

if [ "$currentWeather" != "null" ]; then
    currentTemp=$(round $(echo "scale=2; $(echo $currentWeather | jq .temp)-273.15" | bc) 0)
    futureTemp=$(round $(echo "scale=2; $(echo $futureWeather | jq .temp)-273.15" | bc) 0)
    echo "$currentTemp°C — $futureTemp°C"
else
    echo "Weather 🌐"
fi

