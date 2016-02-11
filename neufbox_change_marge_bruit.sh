#!/bin/bash

NOISE_RATE="$1"
CREDENTIALS="/home/rapha/bin/neufbox_change_bruit/.credentials"
IP="192.168.1.1"
PHANTOM="/home/rapha/bin/neufbox_change_bruit/phantomjs-1.9.7-linux-x86_64/bin/phantomjs"
TMP="/home/rapha/bin/neufbox_change_bruit//tmp"
COOKIES_FILE="$TMP/cookies"
GET_IP_URL="http://myip.leveugle.net"
TEMPLATES_DIR="/home/rapha/bin/neufbox_change_bruit/templates"
FILE_HASH="getHash.js"
PAGE_REF="/maintenance/dsl/config"

getCurrentIp ()
{
    wget -q -O - $GET_IP_URL
}

waitfor () 
{
    LIMIT=$1
    i=0
    while [ $i -lt $LIMIT ]
    do
        echo -n '.'
        sleep 1
        i=$((i+1))
    done
}

copyAndReplaceTemplate()
{
    FILE="$TMP/$1"
    cp $TEMPLATES_DIR/$1.tpl $FILE
    sed -i 's/%%IP%%/'$IP'/' $FILE
    sed -i 's/%%challenge%%/'$ZSID'/' $FILE
    sed -i 's/%%login%%/'$WEBLOGIN'/' $FILE
    sed -i 's/%%password%%/'$WEBPASS'/' $FILE
}

clean()
{
    rm -rf $TMP/
}

init()
{
    if [ -e $CREDENTIALS ]
    then
        WEBLOGIN="$(cat $CREDENTIALS | cut -d: -f1)"
        WEBPASS="$(cat $CREDENTIALS | cut -d: -f2)"
    else
        echo -e "Erreur: Le fichier $CREDENTIALS est manquant.\nIl contient les login et mot de passe utlisés pour se connecter à l'interface Web.\nSon format est:\nlogin:password"
        exit 1
    fi
    
    mkdir -p $TMP
}

main()
{
    # Vérifie si la 'marge de bruit' donnée en argument est comprise entre 1 et 100
    echo " $(echo {1..100}) " | grep -q " $NOISE_RATE " || { echo "La 'marge de bruit' doit être un nombre compris entre 1 et 100"; exit 1; }

    # marge de bruit temporaire (permettra d'éviter de rentrer un MdB égal à celle déjà en cours)
    NOISE_RATE_2=$((NOISE_RATE+1))
    
    clean
    init
   
    echo -n "Authentication..."
    wget -q -O /dev/null \
         --keep-session-cookies --save-cookies=$COOKIES_FILE \
         --referer=http://$IP/login \
         --post-data='action=challenge' \
         --header='Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
         --header='X-Requested-With: XMLHttpRequest' \
         http://$IP/login
    [[ $? ]] &&  echo OK || echo ECHEC
    ZSID=$(cat $COOKIES_FILE | grep sid | cut -f7)
    
    # création du hash
    copyAndReplaceTemplate $FILE_HASH
    HASH=$($PHANTOM $TMP/$FILE_HASH)

    echo -n "Connection..."
    POST_AUTH="method=passwd&page_ref=$PAGE_REF&zsid=$ZSID&hash=$HASH&login=&password="
    wget -q -O /dev/null \
         --load-cookies $COOKIES_FILE \
         --referer=http://$IP/login \
         --post-data="$POST_AUTH" \
         --header='Content-Type: application/x-www-form-urlencoded' \
         http://$IP/login
    [[ $? ]] && echo "OK" || echo ECHEC
    
    echo -n "Changement de la Marge de Bruit temporaire à $NOISE_RATE_2 ..."
    POST_AUTH="dsl_mod_p=p&dsl_mod_e=e&dsl_mod_v=v&dsl_lpair=inner&dsl_trellis=on&dsl_snr=$NOISE_RATE_2&dsl_bitswap=on&dsl_sesdrop=off&dsl_sra=off&dsl_diag=off&submit="
    wget -q -O /dev/null \
         --load-cookies $COOKIES_FILE \
         --referer=http://$IP$PAGE_REF \
         --post-data="$POST_AUTH" \
         --header='Content-Type: application/x-www-form-urlencoded' \
         http://$IP$PAGE_REF
    [[ $? ]] &&  echo OK || echo ECHEC
    
    sleep 3
    
    echo  -n "Changement de la Marge de Bruit à $NOISE_RATE ..."
    POST_AUTH="dsl_mod_p=p&dsl_mod_e=e&dsl_mod_v=v&dsl_lpair=inner&dsl_trellis=on&dsl_snr=$NOISE_RATE&dsl_bitswap=on&dsl_sesdrop=off&dsl_sra=off&dsl_diag=off&submit="
    wget -q -O /dev/null \
         --load-cookies $COOKIES_FILE \
         --referer=http://$IP$PAGE_REF \
         --post-data="$POST_AUTH" \
         --header='Content-Type: application/x-www-form-urlencoded' \
         http://$IP$PAGE_REF
    [[ $? ]] &&  echo -e "OK\n\t------ Internet sera à nouveau disponible d'ici une trentaine de secondes ------" || echo ECHEC
}

main
