FROM haproxy:2.5.12-alpine

USER root

RUN set -x \
  && apk --no-cache add socat \
  && mkdir /var/run/haproxy \
  && chmod 1777 /var/run/haproxy \
  && chown haproxy:haproxy /usr/local/etc/haproxy \
  ;

ENV \
  HAPROXY_USER=haproxy \
  HAPROXY_GROUP=haproxy

CMD ["haproxy", "-S", "/var/run/haproxy/haproxy-master.sock,mode,660,level,user", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

ENV \
  DATAPLANEAPI_VERSION=2.4.4 \
  DATAPLANEAPI_CHECKSUM=9fe55a15c419c05f3c7e2d99c0619efb52097ca512c5f945e4425304e712f6ca

RUN set -x \
  && cd /tmp \
  && wget "https://github.com/haproxytech/dataplaneapi/releases/download/v${DATAPLANEAPI_VERSION}/dataplaneapi_${DATAPLANEAPI_VERSION}_Linux_x86_64.tar.gz" \
  && printf "${DATAPLANEAPI_CHECKSUM}  dataplaneapi_${DATAPLANEAPI_VERSION}_Linux_x86_64.tar.gz\n" > SHA256SUM \
  && sha256sum -c SHA256SUM \
  && tar -zxf dataplaneapi_${DATAPLANEAPI_VERSION}_Linux_x86_64.tar.gz build/dataplaneapi \
  && mv build/dataplaneapi /usr/local/bin/dataplaneapi \
  && chmod +x /usr/local/bin/dataplaneapi \
  && rm -rf * \
  ;

COPY reload.sh /reload
COPY default-backend.http /usr/local/etc/haproxy/errors/default-backend.http
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY  dataplaneapi.hcl /etc/haproxy/dataplaneapi.hcl

# Fix permissions
RUN set -x \
  && chown ${HAPROXY_USER}:${HAPROXY_GROUP} /etc/haproxy/dataplaneapi.hcl \
  && chmod 600 /etc/haproxy/dataplaneapi.hcl \
  ;
