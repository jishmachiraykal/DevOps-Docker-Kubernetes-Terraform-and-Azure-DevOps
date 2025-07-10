* Pulling a python application: docker run -p 5000:5000 in28min/hello-world-python:0.0.1.RELEASE and then in browser execute localhost:5000, you will see the hello world message from python. Here we need not to do any setup just run the run the application will be up

* https://hub.docker.com is the docker registry where images are stored. Here in28min/hello-world-python is repo in docker registry and 0.0.1.RELEASE is release tag. This contains everything i.e., application, correct version, libraries. -p(--publish) 5000:5000, docker is connected to bridge network so mapping container port 5000 to host port 5k

* One docker image can have lot of containers. Running version of the image is called containers

* To run the same application like python, java etc same time change the host port and run it like 5001. We can also run two instances of same application running using different host port. Ex: 5001:5000/5002:5000

* Docker registry: https://hub.docker.com/r/in28min/hello-world-python

* Docker commands: https://github.com/in28minutes/devops-master-class/tree/master/docker#commands

* Executing the container in a detached mode: docker run -d(detached mode) -p 5000:5000 in28min/hello-world-python:0.0.1.RELEASE ( logs will not be seen in terminal)

* See the logs of container: docker logs IMAGEID(substring of first part of image ID is also fine, no need of full image ID)

* To check the running containers: docker container ls

* Stopping the container: docker stop IMAGEID

#### Architecture of docker

    1. Docker client receives the command
    2. Sends it out to docker daemon which is responsible for execution of the commnand
    3. Docker daemon is reponsible for many things like managing container, local images, pulling the image from the repo(image registry) and pushing images to image repo once we create the docker images

* Uses of docker:
    1. Standardized application packaging
    2. Multi platform support
    3. Light-weight
    4. Isolation

* If there is no tag provided latest tag will be taken to pull the image

* Docker pull command will not create container unlike docker run, it will just pull the image and make it available locally

* To know what images are available do docker search imagename and look for official image [OK]

* Getting the history of images: docker image history in28min/hello-world-python:0.0.1.RELEASE. It will list all the layers which is applied during each phase

* Removing the docker image: docker image remove repo+tag or imageID

* Docker image rm removes the image from local machine and not delete from the docker hub (https://hub.docker.com) and to remove there should not be any running containers. If so stop the container and then remove it

* docker container stop will stop the application gracefully whereas docker container kill will not give application the time to shutdown gracefully. This will immediately kill the application

* docker container inspect container ID gives the full details of the container like creation date, what it contains, which image it is created from, platform

* docker container prune will remove all the containers at once. And we also have the commands like docker container pause/unpause to pause and unpause the containers

* docker system df is useful to see disk space used by docker. Type docker system --help for more commands

* docker system events gives the details of what is happening once the docker command is triggered

* docker stats containerID shows the statistics ex: CPU usage, memory usage, limit and name

* We can also configure the statistics while launching the docker. Ex: docker run -p 5000:5000 -m 512m --cpu-quota(50000) in28min/hello-world-python:0.0.1.RELEASE

* Total CPU quota is 100000, so half is 50000

#### Docker file
    1. Docker file contains as the instructions to run the image
    2. FROM inside dockerfile contains the base image upon which we build docker image
    3. Build a image using dockerfile: docker build -t in28min/hello-world-python:0.0.2.RELEASE . // .(dot) indicates current build directory
    4. After build run docker: docker run -p 5000:5000 in28min/hello-world-python:0.0.1.RELEASE
    5. Once after building and running, base image will also be listed in docker images. It will be downloaded onto local machine

#### Pushing docker image built to dockerhub
    1. If it is a organization it will be pushed to cloud as dockerhub is public registry and everyone can access it
    2. Signup for dockerhub: https://app.docker.com/signup
    3. DockerID is the repo name which we give while sign up. Ex: in28min is dockerID and application is hello-world-python
    4. This dockerID should be given while pushing the image to dockerhub
    5. docker push in28min/hello-world-python:0.0.1.RELEASE

##### TODO:
    * Create an account in dockerhub and push the image to it
