#!/usr/bin/env sh

set -eo pipefail

HAPROXY_PID_FILE="${HAPROXY_PID_FILE:-/var/run/haproxy.pid}"

if [[ -e "${HAPROXY_PID_FILE}" ]]; then
	pid="$(cat ${HAPROXY_PID_FILE})"
elif [[ "$(cat /proc/1/cmdline)" == haproxy* ]]; then
	pid="1"
else
	echo "Can't find haproxy pid"
	exit 1
fi

kill -SIGUSR2 "${pid}"
