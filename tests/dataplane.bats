MIN_VERSION="2.5"

# This tests if haproxy will start as a non-root user
# Only supported on 2.5 or new of our image

DOCKER_ARGS="--user haproxy:haproxy"

load functions.bash
load setup.bash

@test "dataplane api test" {
	# These tests will fail on anything older
	if ! newer_than "${TARGET_VERSION}" "${MIN_VERSION}" ; then
		skip
	fi

	# Quick info test
	# curl -sSf -X GET --user admin:adminpwd http://${container_ip}:5555/v2/info

	( wait_http "http://127.0.0.1:${container_api_port}"; )

	# Add a server to the default backend
	curl -sSf -X POST \
	  --user admin:adminpwd \
	  -H "Content-Type: application/json" \
	  -d '{"name": "websrv3", "address": "192.168.1.1", "port": 8088, "check": "enabled", "maxconn": 30, "weight": 10}' \
	  "http://127.0.0.1:${container_api_port}/v2/services/haproxy/configuration/servers?backend=default&version=1&force_reload=true"

	# The forced reload seems to be quick enough
	# sleep 1

	# run docker exec "${container}" grep websrv3 /usr/local/etc/haproxy/haproxy.cfg

	# Check the management socket so we can confirm the reload was successful
	run docker exec "${container}" sh -c 'echo "show servers conn default" | socat /var/run/haproxy/haproxy.sock stdio | grep default/websrv3'

	diag "${output}"
	[[ "${status}" -eq 0 ]]
}
