This is a collection of Dockerfile that allow me to run different versions of Firefox in Docker container (mainly on Ubuntu system).

# Why is this needed?

Running Firefox in container allows us to running more than one version of Firefox, simultaneously. This is very helpful for testing web app compatibility and detect browser issue.

# Structure

Different version of Firefox will be in their own folder. The `build.sh` and `run.sh` give an idea on how to build and how to run these containers. They just serve as an example usage.

The `config` folder is added due to the necessary customization for Firefox v57, which uses multi-process and crashes in Docker container. Their only purpose is to turn off multi-process, as documented in:

https://support.mozilla.org/nl/questions/1167673

# Build and Run

To build: `./build.sh`

To run: `./run.sh`. However, additional step may be needed. A typical Dockerfile would look contain:

```Dockerfile
RUN export uid=1000 gid=1000 && \
        mkdir -p /home/developer && \
        echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
        echo "developer:x:${uid}:" >> /etc/group && \
        mkdir /etc/sudoers.d && \
        echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
        chmod 0440 /etc/sudoers.d/developer && \
        chown ${uid}:${gid} -R /home/developer
```

which creates a user `developer` in our container, then run the application on that user behalf. There are couple ways to run a GUI app in Docker container, they are documented in:

http://wiki.ros.org/docker/Tutorials/GUI

Using container's user, with same user's id and group's id (uid and gid) as our host user, is picked as the best approach in this case. If you are the primary user of the computer, it is likely that your `uid` and `gid` will be `1000` and there is no change needed. However, if your have different `uid` and `gid`, then you would need to modify the Dockerfile.
