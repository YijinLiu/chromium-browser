FROM ubuntu:18.10

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y && \
    apt install -qq -y --no-install-recommends \
        bash bash-completion ca-certificates dpkg pkg-config ssh sudo tzdata wget && \
    echo America/Los_Angeles > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

ARG NAME
ARG UID
ARG GID
RUN groupadd -g $GID $NAME && \
    useradd -u $UID -g $NAME --groups sudo,audio,video --shell /bin/bash $NAME && \
    echo "$NAME ALL = NOPASSWD: ALL" > /etc/sudoers.d/$NAME && \
    mkdir /home/$NAME && chown -R $NAME:$NAME /home/$NAME
USER $NAME
WORKDIR /home/$NAME

ARG VERSION
RUN sudo apt install -y chromium-codecs-ffmpeg-extra=${VERSION} chromium-browser=${VERSION}
