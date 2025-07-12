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
    6. Even if there is no repo, and you try to push the image it will create a repository and push the image

##### TODO:
    * Create an account in dockerhub and push the image to it

* If there is no change in the files and you are building the same image again, the data will be used from cache and build time is less

* Depedency layer will not change oftem(requirement.txt) and code layer will change often. So we can separate dependency layer from code layer, so that it will be used from cache in dockerfile. To do that, in docker file first copy the depedency file to working directory and do the installation. After that copy everything(COPY . /workspace) to working directory. So the installation uses dependency layer alone

* Make sure layers are cached as much as possible so that a efficient docker image can be built

* ENTRYPOINT: does not worry about command line. Execution command will be static. But it can be overrriden using a --entrypoint option while running docker

* CMD: whatever is passed from command line will be overtide the instruction in the dockerfile

* Names can be given to containers using --name=name while running the docker and 2 containers with the same name cannot be launched simultaneously, remove one and relaunch the containers

* If 2 containers are part of bridge network(docker network inspect bridge), they cannot communicate each other via local host. As a workaround link them using --link name-of-other-container --name=name ---env CURRENCY_EXCHANGE_SERVICE=https://currency-exchange while running docker.But this is not the recommended option

* ENV/--env is used to set the environment variables in dockerfile. Any container created would be assigned to bridge network by default. But when we use host network container will directly run on host and other options is none(no network). Use docker network ls command to explore these options. We cannot use none to connect the microservices. Host networking is supported only on Linux. So custom network can be created(docker network create name_of_the_network). Launch it using --network=name_of_custom_network while docker run. Ex: docker run -p 8000:8000 --name=name ---env CURRENCY_EXCHANGE_SERVICE=https://currency-exchange --network=name_of_custom_network repo_name/code_name:tag(in28min/hello-world-python:0.0.1.RELEASE)

#### Simplifying microservice launch

* As we saw in the previous section docker command is expanding and if there are multiple microservices instances it becomes difficult to link and use it. Docker compose is the solution. Install docker compose if it is not installed already. Refer to docker-compose.yml under microservices in DevOps-master-class/projects repo

* To launch it go to docker_compose.yml file path and run docker-compose up/docker-compose up -d(detached mode)

* To stop the microservice container run docker-compose down. To check events, use docker-cpmpose events. docker-compose config command is useful to find if there are any issues in yml file

* docker-compose images and docker-compose ps to list down images and containers respectively. docker-compose top to check the top-most events happening. Can use pause/unpause/stop/kill commads similar to docker container commands