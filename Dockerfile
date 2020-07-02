FROM alpine AS tectonic

RUN echo -e "http://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories

RUN apk -U upgrade -a
RUN apk --no-cache update

# Install Tectonic

RUN apk --no-cache -U add cargo g++ outils-md5

RUN apk --no-cache -U add git libressl-dev libssl1.1 libcrypto1.1 fontconfig-dev harfbuzz-dev icu-dev graphite2-dev libpng-dev zlib-dev

RUN ldconfig /usr/local/lib

RUN cargo install tectonic

RUN echo -e "<fontconfig>\n\t<dir>/data/fonts</dir>\n\t<dir>~/.fonts</dir>\n</fontconfig>" >  /etc/fonts/local.conf
RUN mkdir /data
RUN mkdir -p /root/.cache/Tectonic
RUN ln -s /data/.cache /root/.cache/Tectonic

ENV PATH="/root/.cargo/bin/tectonic:${PATH}"

WORKDIR /data
ENTRYPOINT ["tectonic"]
