#!/bin/bash

while read line1 line2 line3; do
    line3=${line3%$'\r'}
    line2=${line2%$'\r'}
    line=${line1%$'\r'}
    echo -e "\n\nVirus Total\n\n"
    if [[ $line2 == 'hash' ]];then
       /home/mike/VirusTotal_API_Tool/vtlite.py -s -v $line1
    else
       echo -e "\nNot a hash - skipping Virus Total lookup for now"
    fi

    echo -e "\n-------------------------------------------"

    echo -e "\nAlien Vault OTX\n"

    #IP Lookup
    if [[ $line2 == 'ip' ]];then
       echo "test"
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/ip/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/ip/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa"
       fi
    #URL Lookup
    elif [[ $line2 == 'url' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/url/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/url/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa"
       fi
    #Domain Lookup
    elif [[ $line2 == 'domain' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/domain/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/domain/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa"
       fi
    #Hash Lookup
    elif [[ $line2 == 'hash' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/file/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/file/${line1}/general --silent --show-error -H "X-OTX-API-KEY: 30e580f051675bcab2ebcb7d8d55bc875d35a60438bb9bc5b1327e586d34dcaa"
       fi
    else
       echo "Invalid Lookup"
    fi

done
