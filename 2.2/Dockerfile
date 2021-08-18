FROM haproxy:2.2.16-alpine

RUN set -x \
  && apk --no-cache add socat \
  ;

ENV \
  HAPROXY_USER=haproxy \
  HAPROXY_GROUP=haproxy

CMD ["haproxy", "-S", "/var/run/haproxy-master.sock,mode,660,level,user", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

ENV \
  DATAPLANEAPI_VERSION=1.2.5 \
  DATAPLANEAPI_CHECKSUM=0359966747490b55e6ea8c75a9b4969c707ce644dd8041ad8afb49882b97f3a1

RUN set -x \
  && wget "https://github.com/haproxytech/dataplaneapi/releases/download/v${DATAPLANEAPI_VERSION}/dataplaneapi" \
  && printf "${DATAPLANEAPI_CHECKSUM}  dataplaneapi\n" > SHA256SUM \
  && sha256sum -c SHA256SUM \
  && mv dataplaneapi /usr/local/bin/dataplaneapi \
  && chmod +x /usr/local/bin/dataplaneapi \
  ;

COPY reload.sh /reload
COPY default-backend.http /usr/local/etc/haproxy/errors/default-backend.http
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
