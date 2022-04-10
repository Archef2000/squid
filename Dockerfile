FROM alpine
WORKDIR /etc/squid
COPY run .
COPY genuser .
COPY genconfig .
RUN apk add squid openssl bash && chmod +x run genuser genconfig
EXPOSE 3128
CMD ["./run"]
