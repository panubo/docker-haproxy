MIN_VERSION="2.5"

load functions.bash
load setup.bash

@test "prometheus metrics test" {
	# These tests will fail on anything older
	if ! newer_than "${TARGET_VERSION}" "${MIN_VERSION}" ; then
		skip
	fi

	run curl -sSf http://127.0.0.1:${container_metrics_port}/metrics
	# diag "${output}"
	[[ "${status}" -eq 0 ]]
}
