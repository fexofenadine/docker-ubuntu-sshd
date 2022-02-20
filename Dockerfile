# -----------------------------------------------------------------------------
# This is base image of Ubuntu Rolling with SSHD service.
#
# Authors: Art567, fexofenadine
# Updated: 21st Feb 2022
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------


# Base system is the latest rolling version of Ubuntu.
FROM   ubuntu:rolling


# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive
ENV    TZ="Etc/UTC"


# Prepare scripts and configs
ADD    ./scripts/start /start


# Download and install everything from the repos.
RUN    apt-get -q -y update; apt-get -q -y upgrade && \
       apt-get -q -y install sudo openssh-server && \
       mkdir /var/run/sshd


# Set root password
RUN    echo 'root:password' >> /root/passwdfile


# Create user and its password
RUN    useradd -m -G sudo master && \
       echo 'master:password' >> /root/passwdfile


# Apply root password
RUN    chpasswd -c SHA512 < /root/passwdfile && \
       rm /root/passwdfile


# Port 22 is used for ssh
EXPOSE 22


# Assign /data as static volume.
VOLUME ["/data"]


# Fix all permissions
RUN    chmod +x /start


# Starting sshd
CMD    ["/start"]
