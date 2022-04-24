#!/bin/bash
echo "Preparing Squid"

if [ "$AUTH" == "false" ]
then
  echo "http_port ${PORT:=3128})
  http_access allow all" > /etc/squid/squid.conf
else
  
  N=10
  for (( counter=1; counter<=N; counter++ ))
  do
      username=USER_${counter}
      if [[ -n ${!username} ]]
      then
          echo "$username:$(openssl passwd -apr1 "$PASS_1")" >> /etc/squid/passwords
      fi

  done

  if [ -z $USER_1 ]
  then
    echo "Default User is "user1""
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
