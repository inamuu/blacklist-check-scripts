#!/bin/bash

LIST=$(cat ./list.txt)

RED=FALSE

for IP in ${LIST}
do
  SERVERIP=$(dig ${IP} +short | awk -F"." '{print $4"."$3"."$2"."$1}')
  SPAMCOPCHK=$(dig ${SERVERIP}.bl.spamcop.net +short @8.8.8.8 +time=5 )   
  
  if [ "${SPAMCOPCHK}" = "127.0.0.2" ];then
    IPLIST+="${IP}がspamcopに登録されています:no_good:\n"
    RED=TRUE
  fi
done

if [ "${RED}" = FALSE ];then
  IPLIST="Spamcopに登録されているサーバーはありませんでした :ok_woman:"
  GREEN=TRUE
fi

source ./slack.sh
