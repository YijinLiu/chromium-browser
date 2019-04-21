Build docker containers with old version of Chromium browser for testing purpose.

Usage:
<pre>
export VERSION=68.0.3440.84
make VERSION=${VERSION}
wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
docker run -it --user=$USER -e DISPLAY=unix$DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix" \
    -v /dev/shm:/dev/shm --security-opt seccomp=$HOME/chrome.json --device /dev/dri \
    --name chromium-${VERSION} $USER/chromium_browser:${VERSION}
</pre>
See [google-chrome-stable](https://www.ubuntuupdates.org/pm/google-chrome-stable) for list of existing versions.

NOTE: You might need to change the base image version based on the Chromium version you use.
