#!/bin/bash

token=$1
# echo $token

IFS='.' read -r -a parts <<< "$token"
if [ ${#parts[@]} -ne 3 ]; then
    echo "Invalid JWT format." >&2
    return 1
fi

payload=${parts[1]}

payload=$(echo "$payload" | tr - '_')
payload=$(echo "$payload" | tr - '_')

case $((${#payload} % 4)) in
    2) payload="${payload}==" ;;
    3) payload="${payload}=" ;;
esac

base64DecodedBytes=$(echo "$payload" | base64 --decode 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "Failed to decode base64." >&2
    return 1
fi

echo $base64DecodedBytes
