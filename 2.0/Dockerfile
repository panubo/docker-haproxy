FROM haproxy:2.0.5-alpine

RUN set -x \
  && apk --no-cache add socat \
  && addgroup -g 1000 haproxy \
  && adduser -s /sbin/nologin -G haproxy -u 1000 -H -D haproxy \
  ;

ENV \
  HAPROXY_USER=haproxy \
  HAPROXY_GROUP=haproxy

CMD ["haproxy", "-S", "/var/run/haproxy-master.sock,mode,660,level,user", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

ENV \
  DATAPLANEAPI_VERSION=1.2.2 \
  DATAPLANEAPI_CHECKSUM=16f1cb5ac5b7fa30cc3c8105291484ce8f566e9a91ab510a74b11c80e17a2a52

RUN set -x \
  && wget 'https://github.com/haproxytech/dataplaneapi/releases/download/v1.2.2/dataplaneapi' \
  && printf "${DATAPLANEAPI_CHECKSUM}  dataplaneapi\n" > SHA256SUM \
  && sha256sum -c SHA256SUM \
  && mv dataplaneapi /usr/local/bin/dataplaneapi \
  && chmod +x /usr/local/bin/dataplaneapi \
  ;

COPY reload.sh /reload
COPY default-backend.http /usr/local/etc/haproxy/errors/default-backend.http
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
