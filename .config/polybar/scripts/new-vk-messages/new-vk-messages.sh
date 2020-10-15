#!/usr/bin/bash

TOKEN="f44151fea8ff2f14a8ca0e4f0e359748ba7eb58ffb3836db4ea459fc44e0855bdf6ab091e19a1c6002511"

NEW_MESSAGE=4
MESSAGE_READ=6

getServerRequest=$(curl --silent --max-time 20 \
    "https://api.vk.com/method/messages.getLongPollServer?access_token=$TOKEN&v=5.122&lp=3"
)

SERVER=$(echo $getServerRequest | jq -r .response.server)
KEY=$(echo $getServerRequest | jq -r .response.key)
TS=$(echo $getServerRequest | jq -r .response.ts)

echo "https://$SERVER?key=$KEY"

while true; do
    longPollRequest=$(curl --silent --max-time 26 \
        "https://$SERVER?act=a_check&key=$KEY&ts=$TS&wait=25&version=3"
    )

    TS=$(echo $longPollRequest | jq -r .ts)
    updates=$(echo $longPollRequest | jq -r .updates)
    
    for ((i=0;;i++)); do
        if [ "$(echo $longPollRequest | jq -r .updates[$i])" == "null" ]; then
            break
        fi
        updateType=$(echo $longPollRequest | jq -r .updates[$i][0])
        if [ "$updateType" == "$NEW_MESSAGE" ]; then
            # Need to work with $flags to get exactly incoming messages
            flags="$(echo $longPollRequest | jq -r .updates[$i][1])"
            let "isIncomingMessage1 = $flags & 1"
            let "isIncomingMessage = $flags & 2"
            let "isIncomingMessage3 = $flags & 4"
            # echo "1. $isIncomingMessage1"
            # echo "2. $isIncomingMessage2"
            # echo "3. $isIncomingMessage3"
            # echo "start full upd (1)"
            text="$(echo $longPollRequest | jq -r .updates[$i])"
            # echo "$text"
            # echo "end full upd (2)"
            text="$(echo $longPollRequest | jq -r .updates[$1][3])"
            # echo "$text"
            # echo "end msg (3)"
            if [ "$isIncomingMessage" != 0 ]; then
                echo "Incoming message"
            fi
        fi
        # echo "skip (4)"
        # echo $longPollRequest | jq -r .updates[$1][0]
    done
done
