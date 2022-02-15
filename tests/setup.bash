PORT="${TARGET_PORT:-8080}"

setup() {
	# setup() is run regardless of test skip, since we mainly skip due to a minimum version we'll return early to save time
	if ! newer_than "${TARGET_VERSION}" "${MIN_VERSION}" ; then
		return
	fi
	# setup runs before each test
	# Important: we aren't exposing port etc so running tests in parallel works
	container="$(docker run -d ${DOCKER_ARGS} ${TARGET_IMAGE}:${TARGET_VERSION})"
	container_ip="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${container})"
	( wait_http "http://${container_ip}:${PORT}"; )
}

teardown() {
	# teardown runs after each test
	docker rm -f "${container}" || true
}


# docker create --rm -it --name haproxy-2.5.1 -p 8080:8080 -p 5555:5555 --user haproxy:haproxy panubo/haproxy:2.5.1
# docker inspect --format '{{ .State.Status }}' haproxy-2.5.1