#!/bin/sh
echo "Preparing Squid"

if [ "$AUTH" == "false" ]
then
  echo "http_port ${PORT:=3128})
  http_access allow all" > /etc/squid/squid.conf
else
  
  if [ ! -z $USER_1 ]
  then
    echo "${USER_1:=user1}":$(openssl passwd -apr1 ${PASS_1:=passwd123}) > /etc/squid/passwords
  fi
  if [ ! -z $USER_2 ]
  then
    echo "$USER_1":$(openssl passwd -apr1 $PASS_1) > /etc/squid/passwords
  fi
  if [ ! -z $USER_3 ]
  then
    echo "$USER_1":$(openssl passwd -apr1 $PASS_1) > /etc/squid/passwords
  fi
  if [ ! -z $USER_4 ]
  then
    echo "$USER_1":$(openssl passwd -apr1 $PASS_1) > /etc/squid/passwords
  fi
  if [ ! -z $USER_5 ]
  then
    echo "$USER_1":$(openssl passwd -apr1 $PASS_1) > /etc/squid/passwords
  fi

  if [ ! -z $USER_1 ]
  then
    echo "Default User is "user1""
  fi
  if [ ! -z $PASS_1 ]
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
