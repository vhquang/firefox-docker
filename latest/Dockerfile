FROM ubuntu:16.04
LABEL maintainer "Quang Vu <vhquang@gmail.com>"

RUN apt-get update && \
        apt-get install -y firefox

# get your uid and gid on your host machine with `id`
RUN export uid=1000 gid=1000 && \
        mkdir -p /home/developer && \
        echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
        echo "developer:x:${uid}:" >> /etc/group && \
        mkdir /etc/sudoers.d && \
        echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
        chmod 0440 /etc/sudoers.d/developer && \
        chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

ENTRYPOINT ["/usr/bin/firefox"]
