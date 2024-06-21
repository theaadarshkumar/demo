----------------------------------------------------------------------------------------
How to install docker in Ubuntu ?
----------------------------------------------------------------------------------------
https://docs.docker.com/engine/install/ubuntu/
sudo apt install docker.io
https://get.docker.com

https://docs.docker.com/engine/reference/commandline/container/

-----------------------------------------
Docker Management ?
-----------------------------------------
$ docker --version				= verify Docker version
$ sudo systemctl status docker			= Check Docker is running or not
$ sudo systemctl enable --now  docker		= Enable and Start Docker 
$ sudo systemctl stop docker			= Stop Docker
$ sudo apt purge docker.io			= Uninstall or Remove Docker

Give sudo access to use docker command !
------------------------------------------
$ sudo usermod -a -G docker <user_name>
Re-Login To The System

--------------------------------------------------------------------------------------------------------------------------------------------------------
Docker Commands :-
--------------------------------------------------------------------------------------------------------------------------------------------------------
Basics
----------------------
$ docker --version		= Show version of Docker installed
$ docker -v			= Show version
$ docker info			= Show detailed information about docker
$ docker --help			= Mannuals to use docker commands
$ docker login			= To Loigin Docker-Hub

---------------------------------------------------------------------------------
Images
---------------------------------------------------------------------------------
docker images			= List out images
docker pull <image-name>	= Pulling image from docker-hub
docker pull ubuntu| ngnix | httpd | redis | alpine... etc

docker images -a		= List out all the images
docker images -q		= Only Show numeric IDs

docker rmi <image-ID>		= Remove one or more images
docker rmi -f <image-ID>	= Force Removal of the image 


---------------------------------------------------------------------------------
Containers (docker ps --help)
---------------------------------------------------------------------------------
docker ps 			= List out container
docker ps -a			= List out all the container
docker run <image-name>		= Running Image so that container can create
docekr start <Container-ID> 	= To Start The container  
docker stop <Container-ID>	= To Stop The container

docker run -it ubuntu		= Start the ubuntu container and Login to it
-i = interactive mode
-t = TTY Login


---------------------------------------------------------------------------------
System Commands
---------------------------------------------------------------------------------
docker stats			= Monitoring the memory and CPU used by the container
docker system df		= Showing the Disk Usage of Docker 
docker system prune		= Used to remove unsed data 


--------------------------------------------------------------------------------------------------------------------------------------------------------
Docker Images ! (docker images --help)
--------------------------------------------------------------------------------------------------------------------------------------------------------
What are images ?
----------------
Images are the templates used to create the docker container. Container is a running instance of image. Images are stored in Registries (docker hub).
Docker can build images automatically by reading the instructions from a DockerFile. A single image can be used to create multiple containers.

#docker images -a
#docker images -q
#docker images -f "dangling=flase"
#docker images -f "dangling=true"

Dangling images are the images which are not  associated with any container.
False = Image is associated with container
True = Image is not  associated with container

# docker run ubuntu			= This command will run ubuntu image and associates this image to the container, but container will not be start.
# docker run --name Ubuntu1 -it ubuntu bash = This command will run ubuntu image and container will start with the name Ubuntu1
# docker run -d ubuntu bash		= Run ubuntu image in background
# docker ps 				= Listing running container

# docker rmi image_name			= Removing the image
Note: Running images (Associated with Container) will not remove, first we need to stop and remove the associated container
Note: We can use -f flag to remove running image as well.

# docker rmi -f image_name

docker image ls				= Listing images
docker image build 			= Build an image from dockerFile
docker image history			= Show the history of an image
docker image rm				= Remove docker image
docker image push 			= Push docker image to docker.hub


--------------------------------------------------------------------------------------------------------------------------------------------------------
Docker Container !
--------------------------------------------------------------------------------------------------------------------------------------------------------
What is container ?
--------------------
- A way to package application with all the necessary  dependencies and configurations.
- Prtable artifact, easily shared and moved around.
- Makes development and deployment more efficient.
- Containers are the running instances of Docker images


docker ps			= Listing running images (Container)
docker ps -a			= Listing all running images
docker ps -q			= Listing all running images (Only Container ID )
docker container ps
docker container ls


--------------------------------------------------------------------------------------------------------------------------------------------------------
ockerFile ? 
--------------------------------------------------------------------------------------------------------------------------------------------------------
What is DockerFile ?
---------------------
It is a simple text file with instructions to build image. Automation of Docker Image Creation.
As we pull docker images from Docker_Hub, we can use DockerFile to create docker image as well.

___________					    _________________
|	   |					    |		    |
|DockerFile| -------->(docker build)---------------> | Docker Image  |
|__________|			      		    |_______________|


Step 1 : Create a file named DockerFile
---------------------------------------
cd ~/Documents
mkdir DockerFiles
cd DockerFiles
sudo vim DockerFile
~ FROM ubuntu
~ MAINTAINER arlanaadarsh <gmail>
~ RUN sudo apt-get update
~ CMD ["echo","Hello World..."]


Step 2 : Now Build the DockerFile
--------------------------------------
sudo docker build <path_DockerFile>
cd  ~/Documents/DockerFile
sudo docker build .

sudo docker build -t ImageName:tagName "locationOfDockerFile"
sudo docker build -t UbuntuMorgan:1.0 .
sudo docker images ls

Step 3 : Run Image to Create Container
--------------------------------------
sudo docker run <ImageID>


____________________________________________________________________________________________________________________________________________________
|																		   |
|	Docker Compose ?															   |
|__________________________________________________________________________________________________________________________________________________|

What is docker-compose ?
------------------------
It is a tool for defining & running multi-container docker applications.
Use Yaml file to configure applications services (docker-compose.yml)
We can start all services with a single commmand : docker-compose up
We can stop all services with a single command : docker-compose down


Install Docker-Compose
--------------------------
Install docker-compose for linux
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
OR
sudo pip install -U docker-compose

sudo docker-compose --version


Create Compose File at any location with the docker-compose.yml.
-----------------------------------------------------------------
cd ~/Documents
mkdir Docker-Compose
cd Docker-Compose
sudo vim docker-compose.yml

version: "3"
services:

 web:
   image: nginx
   volumes:
    - ./templates:/etc/nginx/templates
   ports:
    - "8080:80"
   environment:
    - NGINX_HOST=foobar.com
    - NGINX_PORT=80

 database:
    image: redis


Check The validity and run the docker-compose.yml file 
-----------------------------------------------------------
cd ~/Documents/Docker-Compose/
sudo docker-compose config
sudo docker-compose -d up	(Start in the Deattached Mode or Run in Background)

sudo docker container ls

sudo docker-compose down	(Stop The docker-compose.yml File)


Scale services using docker-compose
-----------------------------------------
docker-compose up -d --scale service_name=quantity

sudo docker-compose up -d --scale database=4
This command wil up the compose file and run 4 database services (redis, as mentioned in the docker-compose.yml)

sudo docker container ls
sudo docker-compose down
sudo docker container ls


_____________________________________________________________________________________________________________________________________________________

Docker Volumes ? (sudo docker volume --help)
_____________________________________________________________________________________________________________________________________________________

What is docker volume ?
-------------------------
In docker whenever we create a container, there must be a some place where container data will be stored.
When container is created, the data of the container_data stroed in it, and if this container removed then data will also be removed (loss)
We can stored the container_data in the docker volumes to make the container data used even after container deleted.

Volumes are the preferred mechanism for presisting data genrated and used by the Docker Containers.


sudo docker volume create <Volume-Name>			= This command is used to create a docker volume
sudo docker volume create Ngnix
sudo docker volume ls					= This command is used to listing the docker volumes
sudo docker volume inspect Ngnix			= To get the details about the Volume.

sudo docker volume rm <Volume				= To remove the docker volume
sudo docker volume rm Ngnix
sudo docker volume prune				= Removed all the unattached volumes (Which are not associated with Containers)

How to attach docker-volume to a docker-container ?
----------------------------------------------------------
