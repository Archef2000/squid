FROM alpine
COPY run .
RUN apk add squid openssl && chmod +x run
EXPOSE 3128
CMD ["./run"]
