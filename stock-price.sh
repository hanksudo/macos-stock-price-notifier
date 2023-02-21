#!/bin/bash
# macos-stock-price-notifier

STOCK_URLS=(
    'https://invest.cnyes.com/twstock/TWG/2646'
    'https://invest.cnyes.com/twstock/TWS/3443'
)
while :
do
    MESAGE=""
    for STOCK_URL in "${STOCK_URLS[@]}"
    do
        JSON=$(http "$STOCK_URL" | pup 'script#__NEXT_DATA__ text{}')
        NAME=$(jq -n "$JSON" | jq -r '.props.pageProps.initialProps.quote."200009"')
        PRICE=$(jq -n "$JSON" | jq -r '.props.pageProps.initialProps.quote."6"')
        MESSAGE+="$NAME: $PRICE\n"
    done
    osascript -e "display notification \"$MESSAGE\" with title \"Stock Price Notifier\""
    sleep 600
done
