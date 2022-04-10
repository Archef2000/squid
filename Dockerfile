FROM alpine
WORKDIR /etc/squid
COPY entrypoint.sh /entrypoint.sh
RUN apk add squid
RUN chmod +x /entrypoint.sh 
RUN apk add bash 
RUN apk add openssl
EXPOSE 3128
ENTRYPOINT /entrypoint.sh
