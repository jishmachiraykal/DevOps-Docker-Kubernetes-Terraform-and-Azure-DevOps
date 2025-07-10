Pulling a python application: docker run -p 5000:5000 in28min/hello-world-python:0.0.1.RELEASE and then in browser execute localhost:5000, you will see the hello world message from python. Here we need not to do any setup just run the run the application will be up

* https://hub.docker.com is the docker registry where images are stored. Here in28min/hello-world-python is repo in docker registry and 0.0.1.RELEASE is release tag. This contains everything i.e., application, correct version, libraries. -p(--publish) 5000:5000, docker is connected to bridge network so mapping container port 5000 to host port 5k

* One docker image can have lot of containers. Running version of the image is called containers

* To run the same application like python, java etc same time change the host port and run it like 5001. We can also run two instances of same application running using different host port. Ex: 5001:5000/5002:5000

* Docker registry: https://hub.docker.com/r/in28min/hello-world-python