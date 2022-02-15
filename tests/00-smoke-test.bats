load functions.bash
load setup.bash

@test "smoke test" {
	run curl -sSf http://${container_ip}:${PORT}/healthz
	# diag "${output}"
	[[ "${status}" -eq 0 ]]
}
