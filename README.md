# whoishashlookup
Set-up to search for hashing from a local "whois server"

#Requirements

vtlite.py

xinetd

cd /etc/xinetd.d/
vim whois

#edit the file and add

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

    while read line; do
        ./home/mike/VirusTotal_API_Tool/vtlite.py -s $line
        break
    done
</code>

#How to query from remote host

#Linux

whois -h [server.com] [hash]

#Example results:

        Results for MD5:  733a48a9cb49651d72fe824ca91e8d00

        Detected by:  55 / 59

        Sophos Detection: Troj/Agent-HNY

        Kaspersky Detection: Backdoor.Win32.Hijack.e

        ESET Detection: Win32/TrojanDownloader.FakeAlert.JK

        Scanned on: 2017-03-06 02:50:53
