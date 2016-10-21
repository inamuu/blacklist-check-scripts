#!/bin/bash

LIST=$(cat ./list.txt)

RED=FALSE

for IP in ${LIST}
do
  SERVERIP=$(dig ${IP} +short | awk -F"." '{print $4"."$3"."$2"."$1}')
  SPAMCOPCHK=$(dig ${SERVERIP}.bl.spamcop.net +short @8.8.8.8 +time=5 )   
  ABUSEATCHK=$(dig ${SERVERIP}.cbl.abuseat.org +short @8.8.8.8 +time=5 )   
  PBLSPAMCHK=$(dig ${SERVERIP}.pbl.spamhaus.org +short @8.8.8.8 +time=5 )   
  SBLSPAMCHK=$(dig ${SERVERIP}.sbl.spamhaus.org +short @8.8.8.8 +time=5 | grep 127.0.0.2 )   

  if [ "${SPAMCOPCHK}" = "127.0.0.2" ];then
    IPLIST+="${IP}がspamcopに登録されています:no_good:\n"
    RED=TRUE
  fi

  if [ "${ABUSEATCHK}" = "127.0.0.2" ];then
    IPLIST+="${IP}がabuseatに登録されています:no_good:\n"
    RED=TRUE
  fi

  if [ "${PBLSPAMCHK}" = "127.0.0.11" ];then
    IPLIST+="${IP}がpbl.spamhausに登録されています:no_good:\n"
    RED=TRUE
  fi

  if [ "${SBLSPAMCHK}" = "127.0.0.11" ];then
    IPLIST+="${IP}がsbl.spamhausに登録されています:no_good:\n"
    RED=TRUE
  fi
done

if [ "${RED}" = FALSE ];then
  IPLIST="ブラックリストに登録されているサーバーはありませんでした :ok_woman:"
  GREEN=TRUE
fi

source ./slack.sh
