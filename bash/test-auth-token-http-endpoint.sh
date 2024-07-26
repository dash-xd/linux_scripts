#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <port>"
    exit 1
fi

PORT=$1
BASE_URL="http://localhost:$PORT"

echo "Calling /id-token route..."
http POST "$BASE_URL/id-token"

echo "Calling /access-token route..."
http POST "$BASE_URL/access-token"
