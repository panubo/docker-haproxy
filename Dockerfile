FROM docker.io/haproxy:1.6.13

RUN apt-get update && \
    apt-get install -y --no-install-recommends busybox-syslogd curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install socat for use for the haproxy stats socket.
# socat that ships with debian doesn't compile with readline which is used for
# interactive sessions with haproxy socket.
RUN export SOCAT_VERSION=1.7.3.0 \
  && apt-get update \
  && apt-get install -y wget build-essential libssl-dev libreadline-dev libwrap0-dev \
  && cd /usr/local/src \
  && wget http://www.dest-unreach.org/socat/download/socat-${SOCAT_VERSION}.tar.gz \
  && tar -zxf socat-${SOCAT_VERSION}.tar.gz \
  && cd socat-${SOCAT_VERSION} \
  && ./configure \
  && make \
  && make install \
  && cd / \
  && rm -rf /usr/local/src/* \
  && apt-get remove -y wget build-essential libssl-dev libreadline-dev \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/just-containers/skaware/releases/download/v1.19.1/s6-2.4.0.0-linux-amd64-bin.tar.gz | tar -C / -zxf -

COPY reload.sh /reload
COPY s6 /etc/s6/
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

ENTRYPOINT []
CMD ["/bin/s6-svscan","/etc/s6"]
ENV BUILD_VERSION 1.6.13-2
