#!/bin/bash

source ./.apikey

username='Blacklist Check BOT'
to="#general"
subject="spamcop"
message="$IPLIST"
if [ "${GREEN}" = TRUE ];then
  retcolor=#00ff00
else
  retcolor=#dc143c
fi

payload="payload={
     \"channel\": \"${to}\",
     \"username\": \"${username}\",
     \"text\": \"${subject}\",
     \"icon_emoji\": \"${emoji}\",
     \"attachments\": [
     {
       \"text\": \"${message}\",
       \"color\": \"${retcolor}\"
     }
     ]
}"

curl -m 5 --data-urlencode "${payload}" $url
