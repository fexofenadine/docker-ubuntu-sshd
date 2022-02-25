# -----------------------------------------------------------------------------
# This is base image of Ubuntu Rolling with SSHD service.
#
# Authors: Art567, fexofenadine
# Updated: 25th Feb 2022
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

# Base system is the latest rolling version of Ubuntu.
FROM   ubuntu:rolling

# defaults if not specified at build time or runtime
ARG    USERNAME=master
ARG    PASSWORD=password

# default timezone UTC, can be changed at runtime in start script
ENV    TZ "Etc/UTC"

# set PATH and include /home/USERNAME/.local/bin
ENV    PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/${USERNAME}/.local/bin"

# Prepare scripts and configs
ADD    ./scripts/start /start

# edit start cmd script hardcode username. nasty. echo back username variable assignment line from start script
RUN    sed -i "s/%USERNAME%/${USERNAME}/g" /start && \
       cat /start | grep USERNAME=

# Download and install everything from apt repos.
RUN    apt-get -q -y update && \
       DEBIAN_FRONTEND=noninteractive apt-get -q -y dist-upgrade && \
       DEBIAN_FRONTEND=noninteractive apt-get -q -y install nano openssh-server sudo && \
       mkdir /var/run/sshd

# Set root password
RUN    echo root:${PASSWORD} >> /root/passwdfile

# Create user and its password
RUN    useradd -m -G sudo ${USERNAME} && \
       echo ${USERNAME}:${PASSWORD} >> /root/passwdfile

# Apply root password
RUN    chpasswd -c SHA512 < /root/passwdfile && \
	   rm /root/passwdfile

# Port 22 is used for ssh
EXPOSE 22

# Fix startup script permissions
RUN    chmod +x /start

# Set default user's shell to bash
RUN    chsh -s /bin/bash ${USERNAME}

# clean up apt cache
RUN    rm -rf /var/lib/apt/lists/*

# Starting sshd
CMD    ["/start"]