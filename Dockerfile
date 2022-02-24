# -----------------------------------------------------------------------------
# This is base image of Ubuntu Rolling with SSHD service.
#
# Authors: Art567, fexofenadine
# Updated: 24th Feb 2022
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

# Base system is the latest rolling version of Ubuntu.
FROM   ubuntu:rolling

# defaults if not specified at build time or runtime
ARG    USERNAME=master
ARG    PASSWORD=password

# Prepare scripts and configs
ADD    ./scripts/start /start

# edit start cmd script hardcode username. nasty.
RUN    sed -i "s/%USERNAME%/${USERNAME}/g" /start

# Download and install everything from apt repos.
RUN    dpkg-reconfigure debconf --frontend=noninteractive; \
       apt-get -q -y update; \
       apt-get -q -y dist-upgrade && \
       apt-get -q -y install nano sudo openssh-server && \
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

# clean up apt cache and revert interactivity to normal
#RUN    rm -rf /var/lib/apt/lists/*
#RUN    dpkg-reconfigure debconf --frontend=teletype

# Starting sshd
CMD    ["/start"]