export JQ_VERSION=1.6
export JQ_PLATFORM=linux
export JQ_ARCH=amd64
docker build --build-arg "JQ_VERSION=${JQ_VERSION}" --build-arg "JQ_PLATFORM=${JQ_PLATFORM}" --build-arg "JQ_ARCH=${JQ_ARCH}" -t sensu-assets-jq:latest .
docker cp $(docker create --rm sensu-assets-jq:latest true):/sensu-assets-jq_${JQ_VERSION}_${JQ_PLATFORM}_${JQ_ARCH}.tar.gz .
