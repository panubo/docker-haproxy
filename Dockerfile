FROM docker.io/haproxy:1.6.12

RUN apt-get update && \
    apt-get install -y --no-install-recommends busybox-syslogd curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/just-containers/skaware/releases/download/v1.19.1/s6-2.4.0.0-linux-amd64-bin.tar.gz | tar -C / -zxf -

COPY reload.sh /reload
COPY s6 /etc/s6/
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

ENTRYPOINT []
CMD ["/bin/s6-svscan","/etc/s6"]
ENV BUILD_VERSION v1.6.12-1
