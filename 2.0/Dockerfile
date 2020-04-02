FROM haproxy:2.0.14-alpine

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
  DATAPLANEAPI_VERSION=1.2.4 \
  DATAPLANEAPI_CHECKSUM=3b9b44f1a14ce84c0b5fbb514b8fe01bba10223ac003404929a5bfcddf3bffdf

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
