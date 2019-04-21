FROM ubuntu:16.04

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
RUN wget -O chrome64_${VERSION}.deb https://www.slimjet.com/chrome/download-chrome.php?file=lnx%2Fchrome64_${VERSION}.deb
RUN sudo apt install -y --no-install-recommends ./chrome64_${VERSION}.deb
