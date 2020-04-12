Building instructions

docker run --rm --privileged -v \
    ~/.docker:/root/.docker homeassistant/amd64-builder \
    --aarch64 -t snapclient -r https://github.com/selleronom/hassio-addons \
    -b branchname

docker run --rm --privileged -v \
    ~/.docker:/root/.docker -v /home/erik/git/hassio-addons/snapclient:/data homeassistant/amd64-builder \
    --all -t /data