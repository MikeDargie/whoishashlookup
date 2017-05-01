<h2>Information</h2>

<p>This is a simple whois look-up tool for querying hash,ip,domain,url information from popular services like AlienVault OTX and Virus total. Currently it supports OTX and AV but more serivces could be added with with ease.</p>

<h3><u>Requirements</u></h3>
<h4>VirusTotal_API_Tool</h4>
<h4>xinetd</h4>
<h4>jq</h4>

<h3>GUIDE</h3>

<p>cd /etc/xinetd.d</p>
<p>vim whois</p>

<p>#edit the file and add:</p>

<code>

     service whois                                                                                                         
     {                                                                                                                          
        port           = 43                                                                                              
        flags          = REUSE                                                                                           
        socket_type    = stream                                                                                          
        protocol       = tcp                                                                                             
        user           = root                                                                                            
        wait           = no                                                                                              
        type           = UNLISTED                                                                                        
        server         = /location/of/script.sh                                                                      
        disable        = no        
     } 
</code>

cd /script/location/

vim script.sh

<code>

#!/bin/bash

while read line1 line2 line3; do
    line3=${line3%$'\r'}
    line2=${line2%$'\r'}
    line=${line1%$'\r'}
    echo -e "\n\nVirus Total\n\n"
    if [[ $line2 == 'hash' ]];then
       /location/of/VirusTotal_API_Tool/vtlite.py -s -v $line1
    else
       echo -e "\nNot a hash - skipping Virus Total lookup for now"
    fi

    echo -e "\n-------------------------------------------"

    echo -e "\nAlien Vault OTX\n"

    #IP Lookup
    if [[ $line2 == 'ip' ]];then
       echo "test"
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/ip/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/ip/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]"
       fi
    #URL Lookup
    elif [[ $line2 == 'url' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/url/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/url/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]"
       fi
    #Domain Lookup
    elif [[ $line2 == 'domain' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/domain/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/domain/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]"
       fi
    #Hash Lookup
    elif [[ $line2 == 'hash' ]];then
       if [[ $line3 == 'jq' ]];then
          curl https://otx.alienvault.com:443/api/v1/indicators/file/${line1}/general --silent --show-error -H "X-OTX-API-KEY: [API-KEY]" | jq .
       else
          curl https://otx.alienvault.com:443/api/v1/indicators/file/${line1}/general --silent --show-error -H "X-OTX-API-KEY:"[API-KEY]"
       fi
    else
       echo "Invalid Lookup"
    fi

done

</code>

<h2>How to query from remote host</h2>

<h2>Linux</h2>

<h3>Requirement:</h3>

<h4>Whois (default client - you can apt-get install it. apt-get install whois)</h4>

<code>
whois -h [SERVER] [TYPE] [OUTPUT FORMAT]
</code>

<h4>SERVER = shareataxii.com</h4>

<h4>TYPE = [ip | domain | hash | url]</h4>

<h4>OUTPUT FORMAT = json (any other input will give you csv output)</h4>

<h3>Example results:</h3>
<code>
     
     Virus Total



        Results for MD5:  1e1b0d16a16cf5c7f3a7c053ce78f515

        Detected by:  48 / 62

        Sophos Detection: Troj/ItaDuke-A

        Kaspersky Detection: Backdoor.Win32.MiniDuke.h

        ESET Detection: Win32/SandyEva.B

        Scanned on: 2017-04-30 21:51:13

        Verbose VirusTotal Information Output:

        Bkav                    False   None
        MicroWorld-eScan        True    Gen:Variant.MiniDuke.2
        nProtect                False   None
        CMC                     True    Backdoor.Win32.MiniDuke!O
        CAT-QuickHeal           True    Backdoor.Miniduke
        McAfee                  True    BackDoor-FCCM!1E1B0D16A16C
        Malwarebytes            False   None
        VIPRE                   True    Trojan.Win32.Generic!BT
        SUPERAntiSpyware        False   None
        CrowdStrike             True    malicious_confidence_100% (W)
        K7GW                    True    Trojan ( 00471ab31 )
        K7AntiVirus             True    Trojan ( 00471ab31 )
        TheHacker               True    Trojan/SandyEva.b
        Invincea                True    virus.win32.sality.at
        Baidu                   True    Win32.Trojan.WisdomEyes.16070401.9500.9893
        F-Prot                  False   None
        Symantec                True    Backdoor.Miniduke
        TotalDefense            False   None
        TrendMicro-HouseCall    True    TROJ_SPNR.35DG13
        Paloalto                True    generic.ml
        ClamAV                  True    Win.Trojan.Miniduke-3
        Kaspersky               True    Backdoor.Win32.MiniDuke.h
        BitDefender             True    Gen:Variant.MiniDuke.2
        NANO-Antivirus          True    Trojan.Win32.MiniDuke.dekruu
        AegisLab                False   None
        Avast                   True    Win32:MiniDuke-G [Trj]
        Tencent                 True    Win32.Backdoor.Miniduke.Dyqt
        Ad-Aware                True    Gen:Variant.MiniDuke.2
        Sophos                  True    Troj/ItaDuke-A
        Comodo                  True    UnclassifiedMalware
        F-Secure                True    Backdoor:W32/MiniDuke.A
        DrWeb                   True    BackDoor.Miniduke.1
        Zillya                  True    Backdoor.MiniDuke.Win32.2
        TrendMicro              False   None
        McAfee-GW-Edition       True    BackDoor-FCCM!1E1B0D16A16C
        Emsisoft                True    Gen:Variant.MiniDuke.2 (B)
        SentinelOne             False   None
        Cyren                   False   None
        Jiangmin                True    Backdoor/MiniDuke.b
        Webroot                 True    W32.Malware.Gen
        Avira                   True    TR/MiniDuke.BQ
        Fortinet                True    W32/MiniDuke.B!tr.bdr
        Antiy-AVL               True    Trojan[Backdoor]/Win32.MiniDuke
        Kingsoft                False   None
        Endgame                 True    malicious (moderate confidence)
        Arcabit                 True    Trojan.MiniDuke.2
        ViRobot                 True    Trojan.Win32.Z.Miniduke.333824[h]
        ZoneAlarm               True    Backdoor.Win32.MiniDuke.h
        Microsoft               True    TrojanDropper:Win32/Miniduke!rfn
        AhnLab-V3               False   None
        ALYac                   True    Gen:Variant.MiniDuke.2
        AVware                  True    Trojan.Win32.Generic!BT
        VBA32                   True    Backdoor.MiniDuke
        Zoner                   False   None
        ESET-NOD32              True    Win32/SandyEva.B
        Rising                  False   None
        Yandex                  True    Backdoor.MiniDuke!Cbzcg9GF96E
        Ikarus                  True    Backdoor.Win32.MiniDuke
        GData                   True    Gen:Variant.MiniDuke.2
        AVG                     True    Small.EXR
        Panda                   True    Generic Malware
        Qihoo-360               True    Win32/Backdoor.eec

     Alien Vault OTX

     {
       "indicator": "1e1b0d16a16cf5c7f3a7c053ce78f515",
       "sections": [
         "general",
         "analysis"
       ],
       "type_title": "FileHash-MD5",
       "pulse_info": {
         "count": 4,
         "references": [
           "https://app.box.com/s/c95me2uocwoothfnapxrcjwfmynue4ri",
           "https://labs.bitdefender.com/wp-content/uploads/downloads/2013/04/MiniDuke_Paper_Final.pdf",
           "https://kasperskycontenthub.com/wp-content/uploads/sites/43/vlpdfs/themysteryofthepdf0-dayassemblermicrobackdoor.pdf",
           "https://kasperskycontenthub.com/wp-content/uploads/sites/43/vlpdfs/themysteryofthepdf0-dayassemblermicrobackdoor.pdf"
         ],
         "pulses": [
           {
             "pulse_source": "web",
             "subscriber_count": 63,
             "is_following": false,
             "modified_text": "59 days ago ",
             "is_subscribing": false,
             "references": [
               "https://app.box.com/s/c95me2uocwoothfnapxrcjwfmynue4ri"
             ],
             "vote": 0,
             "id": "58b8a46ddae7a90966de13e1",
             "industries": [],
             "author": {
               "username": "nightingale",
               "is_subscribed": false,
               "avatar_url": "https://otx20-web-media.s3.amazonaws.com/media/avatars/user_25380/resized/80/avatar_468b7010b8.png",
               "is_following": false,
               "id": "5882b004b0633d097920c13a"
             },
             "cloned_from": null,
             "comment_count": 0,
             "follower_count": 0,
             "public": true,
             "indicator_type_counts": {
               "hostname": 1,
               "SHA256": 2,
               "SHA1": 1,
               "MD5": 2
             },
             "TLP": "white",
             "description": "",
             "tags": [],
             "in_group": false,
             "is_modified": false,
             "upvotes_count": 0,
             "targeted_countries": [],
             "groups": [],
             "validator_count": 0,
             "is_author": false,
             "adversary": "APT 29",
             "observation": {
               "observation_created": "2017-03-02T23:02:06",
               "description": "",
               "title": "",
               "access_reason": "",
               "is_active": 1,
               "access_type": "public",
               "content": "",
               "pulse_key": "58b8a46ddae7a90966de13e1",
               "role": null,
               "expiration": null
             },
             "locked": false,
             "name": "Analysis of a stage 3 Miniduke sample (2013)",
             "created": "2017-03-02T23:02:05.888",
             "downvotes_count": 0,
             "modified": "2017-03-02T23:02:05.888",
             "export_count": 2,
             "indicator_count": 6,
             "votes_count": 0
           },
           {
             "pulse_source": "web",
             "subscriber_count": 68,
             "is_following": false,
             "modified_text": "60 days ago ",
             "is_subscribing": false,
             "references": [
               "https://labs.bitdefender.com/wp-content/uploads/downloads/2013/04/MiniDuke_Paper_Final.pdf"
             ],
             "vote": 0,
             "id": "58b7f4dbfd95e73876f1a4fd",
             "industries": [],
             "author": {
               "username": "nightingale",
               "is_subscribed": false,
               "avatar_url": "https://otx20-web-media.s3.amazonaws.com/media/avatars/user_25380/resized/80/avatar_468b7010b8.png",
               "is_following": false,
               "id": "5882b004b0633d097920c13a"
             },
             "cloned_from": null,
             "comment_count": 0,
             "follower_count": 0,
             "public": true,
             "indicator_type_counts": {
               "URL": 14,
               "domain": 4,
               "CVE": 2,
               "hostname": 2,
               "MD5": 66
             },
             "TLP": "white",
             "description": "This piece of malware is made of three components: pdf, main, payload. The PDF file embeds exploit code and a dropper that writes the “main” DLL component on the drive. Additionally, the original PDF also contains a clean PDF file used in the social engineering stage",
             "tags": [
               "miniduke",
               "russia"
             ],
             "in_group": true,
             "is_modified": false,
             "upvotes_count": 0,
             "targeted_countries": [],
             "groups": [
               {
                 "name": "MISP FEED",
                 "id": 76
               }
             ],
             "validator_count": 0,
             "is_author": false,
             "adversary": "APT 29",
             "observation": {
               "observation_created": "2017-03-02T10:33:00",
               "description": "",
               "title": "",
               "access_reason": "",
               "is_active": 1,
               "access_type": "public",
               "content": "",
               "pulse_key": "58b7f4dbfd95e73876f1a4fd",
               "role": null,
               "expiration": null
             },
             "locked": false,
             "name": "A Closer Look at MiniDuke (2013)",
             "created": "2017-03-02T10:32:59.819",
             "downvotes_count": 0,
             "modified": "2017-03-02T10:32:59.819",
             "export_count": 6,
             "indicator_count": 88,
             "votes_count": 0
           },
           {
             "pulse_source": "web",
             "subscriber_count": 3,
             "is_following": false,
             "modified_text": "69 days ago ",
             "is_subscribing": false,
             "references": [
               "https://kasperskycontenthub.com/wp-content/uploads/sites/43/vlpdfs/themysteryofthepdf0-dayassemblermicrobackdoor.pdf"
             ],
             "vote": 0,
             "id": "58ab988907a7f105fe2825fa",
             "industries": [
               "Government",
               "Healthcare"
             ],
             "author": {
               "username": "hsd1.tx.comcast.",
               "is_subscribed": false,
               "avatar_url": "https://otx.alienvault.com/static/img/default.png",
               "is_following": false,
               "id": "58ab91a4ac3cdc15332c7b4c"
             },
             "cloned_from": "58ab8350ac3cdc0e642c7b4d",
             "comment_count": 0,
             "follower_count": 0,
             "public": true,
             "indicator_type_counts": {
               "URL": 2,
               "domain": 3,
               "CVE": 1,
               "hostname": 2,
               "MD5": 9
             },
             "TLP": "white",
             "description": null,
             "tags": [
               "Russia"
             ],
             "in_group": false,
             "is_modified": false,
             "upvotes_count": 0,
             "targeted_countries": [
               "Ukraine",
               "Belgium",
               "Portugal",
               "Romania",
               "Czech Republic",
               "Ireland",
               "United States",
               "Hungary"
             ],
             "groups": [],
             "validator_count": 0,
             "is_author": false,
             "adversary": "Miniduke",
             "observation": {
               "observation_created": "2017-02-21T01:31:54",
               "description": "",
               "title": "",
               "access_reason": "",
               "is_active": 1,
               "access_type": "public",
               "content": "",
               "pulse_key": "58ab988907a7f105fe2825fa",
               "role": null,
               "expiration": null
             },
             "locked": false,
             "name": "сТАнЧа",
             "created": "2017-02-21T01:31:53.468",
             "downvotes_count": 0,
             "modified": "2017-02-21T01:31:53.468",
             "export_count": 1,
             "indicator_count": 17,
             "votes_count": 0
           },
           {
             "pulse_source": "web",
             "subscriber_count": 69,
             "is_following": false,
             "modified_text": "55 days ago ",
             "is_subscribing": false,
             "references": [
               "https://kasperskycontenthub.com/wp-content/uploads/sites/43/vlpdfs/themysteryofthepdf0-dayassemblermicrobackdoor.pdf"
             ],
             "vote": 0,
             "id": "58ab8350ac3cdc0e642c7b4d",
             "industries": [
               "Government",
               "Healthcare"
             ],
             "author": {
               "username": "nightingale",
               "is_subscribed": false,
               "avatar_url": "https://otx20-web-media.s3.amazonaws.com/media/avatars/user_25380/resized/80/avatar_468b7010b8.png",
               "is_following": false,
               "id": "5882b004b0633d097920c13a"
             },
             "cloned_from": null,
             "comment_count": 0,
             "follower_count": 0,
             "public": true,
             "indicator_type_counts": {
               "URL": 2,
               "domain": 3,
               "CVE": 1,
               "hostname": 2,
               "MD5": 9
             },
             "TLP": "white",
             "description": "On Feb 12th 2013, FireEye announced the discovery (http://blog.fireeye.com/research/2013/02/the-number-of-thebeast.html)\nof an Adobe Reader 0-day exploit which is used to drop a previously unknown, advanced piece of malware. We\ncalled this new malware “ItaDuke” because it reminded us of Duqu and because of the ancient Italian comments in the\nshellcode copied from Dante Aligheri’s Divine Comedy.",
             "tags": [
               "Russia"
             ],
             "in_group": false,
             "is_modified": true,
             "upvotes_count": 0,
             "targeted_countries": [
               "Ukraine",
               "Belgium",
               "Portugal",
               "Romania",
               "Czech Republic",
               "Ireland",
               "United States",
               "Hungary"
             ],
             "groups": [],
             "validator_count": 0,
             "is_author": false,
             "adversary": "APT 29",
             "observation": {
               "observation_created": "2017-02-21T00:01:21",
               "description": "",
               "title": "",
               "access_reason": "",
               "is_active": 1,
               "access_type": "public",
               "content": "",
               "pulse_key": "58ab8350ac3cdc0e642c7b4d",
               "role": null,
               "expiration": null
             },
             "locked": false,
             "name": "Miniduke (2013)",
             "created": "2017-02-21T00:01:20.108",
             "downvotes_count": 0,
             "modified": "2017-03-07T13:59:13.446",
             "export_count": 2,
             "indicator_count": 17,
             "votes_count": 0
           }
         ]
       },
       "base_indicator": {
         "indicator": "1e1b0d16a16cf5c7f3a7c053ce78f515",
         "description": "",
         "title": "",
         "access_reason": "",
         "access_type": "public",
         "content": "",
         "type": "FileHash-MD5",
         "id": 2657674
       },
       "validation": [],
       "type": "md5"
     }

</code>
<h2>Windows</h2>

<h3>Requirement:</h3>

<h4>-ncat (whois clients will not work on windows)</h4>



