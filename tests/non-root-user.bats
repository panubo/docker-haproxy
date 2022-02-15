MIN_VERSION="2.5"

# This tests if haproxy will start as a non-root user
# Only supported on 2.5 or new of our image

DOCKER_ARGS="--user haproxy:haproxy"

load functions.bash
load setup.bash

@test "non-root user test" {
	# These tests will fail on anything older
	if ! newer_than "${TARGET_VERSION}" "${MIN_VERSION}" ; then
		skip
	fi

	run curl -sSf http://${container_ip}:${PORT}/healthz
	# diag "${output}"
	[[ "${status}" -eq 0 ]]
}
