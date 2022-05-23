#!/bin/bash
echo "Preparing Squid"

if [ "$AUTH" == "false" ]
then
  echo "http_port ${PORT:=3128}
  http_access allow all" > /etc/squid/squid.conf
else
  
  echo "$USER_1:$(openssl passwd -apr1 "$PASS_1")" >> /etc/squid/passwords
  echo "$USER_2:$(openssl passwd -apr1 "$PASS_2")" >> /etc/squid/passwords
  echo "$USER_3:$(openssl passwd -apr1 "$PASS_3")" >> /etc/squid/passwords
  echo "$USER_4:$(openssl passwd -apr1 "$PASS_4")" >> /etc/squid/passwords
  echo "$USER_5:$(openssl passwd -apr1 "$PASS_5")" >> /etc/squid/passwords
  echo "$USER_6:$(openssl passwd -apr1 "$PASS_6")" >> /etc/squid/passwords
  echo "$USER_7:$(openssl passwd -apr1 "$PASS_7")" >> /etc/squid/passwords
  echo "$USER_8:$(openssl passwd -apr1 "$PASS_8")" >> /etc/squid/passwords
  echo "$USER_9:$(openssl passwd -apr1 "$PASS_9")" >> /etc/squid/passwords
  echo "$USER_10:$(openssl passwd -apr1 "$PASS_10")" >> /etc/squid/passwords


  if [ -z $USER_1 ]
  then
    echo "Default User is "user_1""
  fi
  if [ -z $PASS_1 ]
  then
    echo "Default Password is "passwd123""
  fi

  echo "auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
  auth_param basic realm proxy
  acl authenticated proxy_auth REQUIRED
  http_access allow authenticated
  http_port ${PORT:=3128}
  http_access allow all" > /etc/squid/squid.conf
fi
echo "Starting Squid"
if [ "$LOG" = "true" ]
then
squid -N $@
else
squid -N $@ 2> /dev/null
fi

#N=10
#for (( counter=1; counter<=N; counter++ ))
#do
#    username=user${counter}
#    password=PASS_${counter}
#    if [[ -n ${!username} ]]
#    then
#        echo "$username:$(openssl passwd -apr1 "$password")" >> /etc/squid/passwords
#    fi
#done
