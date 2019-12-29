ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install dep for snapserver and librespot
RUN apt-get update && apt-get -y install \
curl \
apt-transport-https \
gnupg2 \
libavahi-client3 \
libavahi-common3 \
libflac8 \
libogg0 \
libopus0 \
libvorbis0a \
libvorbisenc2 \
&& curl -L https://github.com/badaix/snapcast/releases/download/v0.17.1/snapserver_0.17.1-1_armhf.deb -o snapserver_0.17.1-1_armhf.deb \
&& dpkg -i snapserver_0.17.1-1_armhf.deb \
&& apt-get -f install \
&& curl -sSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v - \
&& echo 'deb https://dtcooper.github.io/raspotify raspotify main' | tee /etc/apt/sources.list.d/raspotify.list \
&& apt-get update \
&& apt-get install -y \
raspotify

# Copy data for add-on
COPY snapserver.conf /etc/
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]