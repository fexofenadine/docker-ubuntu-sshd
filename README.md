Ubuntu Rolling with SSH (Docker)
=========

A Docker file to build a [docker.io] base container with Ubuntu Rolling and a sshd service
[docker.io]: http://docker.io
Nice and easy way to get any server up and running using docker


Instructions
-----------
 - Install Docker first. 
   Read [installation instructions] (http://docs.docker.io/en/latest/installation/).
 
 
 - Clone this repository:
 
   `$ git clone https://github.com/fexofenadine/docker-ubuntu-sshd.git`
 
 
 - Enter local directory:
 
   `$ cd docker-ubuntu-sshd`
 
 - Change passwords in Dockerfile:
 
   `$ vi Dockerfile`
 
 - Build the container:
 
   `$ sudo docker build -t fexofenadine/ubuntu-sshd .`
 
 
 - Run the container:
 
   `$ sudo docker run -d=true --name=ubuntu --restart=always -p=2222:22 -v=/opt/data:/data fexofenadine/ubuntu-sshd /start`
 
 
 - Your container will start and bind ssh to 2222 port.
 
 
 - Find your local IP Address:
 
   `$ ifconfig`
 
 
 - Connect to the SSH server:
 
   `$ ssh root@<ip-address> -p 2222`
 
 
 - If you don't want to deal with root:
 
   `$ ssh master@<ip-address> -p 2222`
 

**VERY IMPORTANT!!!**
-----------

 **Don't forget to change passwords in Dockerfile before building image!**


Versions
-----------
Some branches represents Ubuntu versions.

Branch `master` is always represented by latest Ubuntu Rolling

   For example:
   - 12.04 - Ubuntu 12.04 Rolling
   - 14.04 - Ubuntu 14.04 Rolling
   - 16.04 - Ubuntu 16.04 Rolling

