# Docker HAProxy

[![Status](https://img.shields.io/badge/status-SUPORTED-brightgreen.svg)]()

HAProxy docker image with Panubo's customisations.

## Logging

Before haproxy 1.9 haproxy could not log to stdout. The pre haproxy version 2.0 images use s6 and a small syslog daemon to output the haproxy logs to stdout.

Since haproxy 2.0 the default haproxy.cfg logs to stdout and stderr.

## Reloading

These images ship with a reload command to reload the haproxy config regardless of how the image manages the haproxy process.

```
# if your container is named "haproxy"
docker exec haproxy /reload
```

## Default config file

Each of the images ship with a default haproxy.cfg **DON"T USE THE DEFAULT IN PRODUCTION** these default configs should be a base to build your production config or for testing purposed only.

## Data Plane API

Starting from version 2.0 the image ships with [HAProxy Data Plane API](https://github.com/haproxytech/dataplaneapi) preinstalled.

## Management interface

Each of the images ship with socat installed so the haproxy management interface can easily be used.

```
# from inside the container
# workers socket
socat /var/run/haproxy.sock readline
prompt

# master socket (show proc)
socat /run/haproxy-master.sock readline
```

## Non-root usage

From version 2.5 the image is tested running as non-root user `haproxy`
