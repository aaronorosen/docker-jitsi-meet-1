#!/bin/bash
docker build -t jibri jibri/.

# docker build -t jitsi-meet-base base/.
# docker build -t jits-meet-web web/. --build-arg SSH_KEY="$(cat ~/.ssh/id_rsa)" --no-cache
# docker build -t prosody prosody/.
# docker build -t base-java base-java/.
# docker build -t jicofo jicofo/.
# docker build -t jvb jvb/.

