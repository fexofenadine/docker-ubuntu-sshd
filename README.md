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
 
 
 - Build the container, specifying username and password as --build-arg(s) as required. If user/pass combo is not passed, it will be set to the default (master:password):
 
   `$ sudo docker build -t fexofenadine/ubuntu .`
 
 
 - You can specify username and password as build arguments as required. If user/pass combo is not passed, it will be set to the default (master:password):
 
   `$ sudo docker build --build-arg USERNAME=fexofenadine --build-arg PASSWORD=mypassword -t fexofenadine/ubuntu .`
  
 
 - Run the container:
 
   `$ sudo docker run -d=true --name=ubuntu --restart=always -e TZ="Europe/Paris" -p=2222:22 fexofenadine/ubuntu /start`
 
 
 - Consider binding your /home directory as a volume for persistent user customizations
 
 
 - Your container will start and bind ssh to 2222 port.
 
 
 - Find your local IP Address:
 
   `$ ifconfig`
 
 
 - Connect to the SSH server:
 
   `$ ssh root@<ip-address> -p 2222`
 
 
 - If you don't want to deal with root:
 
   `$ ssh user@<ip-address> -p 2222`
 

**VERY IMPORTANT!!!**
-----------

 **Don't forget to change passwords in the arguments of your build command before building image!**


Versions
-----------
Some branches represents Ubuntu versions.

This image builds from Ubuntu's rolling image branch.

