FROM alpine:3.15.4

LABEL   os="alpine" \
        container.description="mkcert" \
        version="1.0.0" \
        imagename="mkcert" \
        maintainer="devops@governance.foundation" \
        test.command="/bin/sh -c 'test ! -f mkcert.key && mkcert -install && mkcert -key-file mkcert.key -cert-file mkcert.pem -client localhost 127.0.0.1 ::1 && ls -l'" \
        test.verify="The local CA is now installed in the system trust store!"

WORKDIR /mkcert

RUN apk --no-cache add curl
RUN curl -JLO "https://dl.filippo.io/mkcert/v1.4.4?for=linux/amd64" && \
  chmod +x mkcert-v1.4.4-linux-amd64 && \
  mv mkcert-v1.4.4-linux-amd64 /bin/mkcert

CMD ["./mkcert"]
