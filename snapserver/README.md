Building instructions

docker run --rm --privileged -v \
    ~/.docker:/root/.docker homeassistant/amd64-builder \
    --aarch64 -t snapserver -r https://github.com/selleronom/hassio-addons \
    -b branchname
