load functions.bash
load setup.bash

@test "smoke test" {
	run curl -sSf http://127.0.0.1:${container_http_port}/healthz
	# diag "${output}"
	[[ "${status}" -eq 0 ]]
}
