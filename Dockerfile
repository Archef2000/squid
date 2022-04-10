FROM alpine
WORKDIR /etc/squid
COPY entrypoint.sh /entrypoint.sh
RUN apk add bash openssl squid --no-cache && chmod +x /entrypoint.sh
EXPOSE 3128
ENTRYPOINT /entrypoint.sh
