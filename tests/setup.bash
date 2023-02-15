PORT="${TARGET_PORT:-8080}"
TARGET_VERSION="$(docker inspect --format '{{range .Config.Env}}{{println .}}{{end}}' ${TARGET_IMAGE} | sed -E -e '/HAPROXY_VERSION/!d' -e 's/^[^=]+=//')"

setup() {
	# setup() is run regardless of test skip, since we mainly skip due to a minimum version we'll return early to save time
	if ! newer_than "${TARGET_VERSION}" "${MIN_VERSION}" ; then
		return
	fi
	# setup runs before each test
	# Important: we aren't exposing port etc so running tests in parallel works
	container="$(docker run -d ${DOCKER_ARGS} -p "${PORT}" -p 5555 -p 9000 ${TARGET_IMAGE})"
	container_ip="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${container})"
	container_http_port="$(docker inspect --format '{{(index (index .NetworkSettings.Ports "'${PORT}'/tcp") 0).HostPort}}' ${container})"
	container_api_port="$(docker inspect --format '{{(index (index .NetworkSettings.Ports "5555/tcp") 0).HostPort}}' ${container})"
	container_metrics_port="$(docker inspect --format '{{(index (index .NetworkSettings.Ports "9000/tcp") 0).HostPort}}' ${container})"
	( wait_http "http://127.0.0.1:${container_http_port}"; )
}

teardown() {
	# teardown runs after each test
	docker rm -f "${container}" || true
}


# docker create --rm -it --name haproxy-2.5.1 -p 8080:8080 -p 5555:5555 --user haproxy:haproxy panubo/haproxy:2.5.1
# docker inspect --format '{{ .State.Status }}' haproxy-2.5.1