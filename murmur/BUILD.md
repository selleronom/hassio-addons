Building instructions

docker run --rm --privileged -v \
    ~/.docker:/root/.docker homeassistant/amd64-builder \
    --armhf -t murmur -r https://github.com/selleronom/hassio-addons
