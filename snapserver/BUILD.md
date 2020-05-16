Building instructions

docker run --rm --privileged -v \
 ~/.docker:/root/.docker homeassistant/amd64-builder \
 --armhf --armv7 --aarch64 -t snapserver -r https://github.com/selleronom/hassio-addons
