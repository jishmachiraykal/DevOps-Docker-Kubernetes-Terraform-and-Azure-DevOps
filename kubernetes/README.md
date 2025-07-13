* Group of servers managed together and connected to the cluster

* Multiple instances can be launched using single command and load is balanced

* If one of the instances go down, kubernetes makes other instances running. And also it is possible to switch between multiple releases

* Kubernetes is cloud neutral. Google, Azure and AWS have their own kubernetes to manage

* To manage these clusters we use, Google Kubernetes Engine (GKE): https://cloud.google.com/

* Kubernetes manages servers(virtual servers) which are in cloud. These virtual servers are called by different names in clouds
    AWS: Elastic compute cloud(EC2)
    Azure: Virtual machines
    Google: compute machines
    Kubernetes: nodes

* Cluster is combination of nodes and master nodes. Nodes does the work and master nodes manages everything

* K8S stands for Kubernetes = K8(ubernete)S = 8 middle letters = KOO-BER-NET-EZ(Pronunciation)

* Kubernetes on cloud: Azure(AKS), AWS( Amazon AKS) and Google(GKE). To connect to cluester in GKE, we need to activate cluster shell and it will open a termila in GKE itself where we can deploy the docker containers to kubernetes cluster

* kubectl(Kube controller) is a kubernetes command to connect cluster

#### Deploying an application to Kubernetes cluster in GKE

    * kubectl create deployment hello-world-rest-api --image=in28min/hello-world-python:0.0.1.RELEASE
    * Exposing the service to outside world: kubectl create expose hello-world-rest-api --type=LoadBalancer --port=8080

    This can be checked under Services and Ingress section in GKE(https://cloud.google.com/)

* kubectl get events shows the entire events happening from creating a node to exposing the service

* kubectl get is a common command to get events/pod/replicaset/deployment/service

* Kubernetes uses one concept and one responsibility. kubectl create deployment created pod/replicaset/deployment and kubectl create expose creates service

#### Pods

    * Pod is the smallest deployable unit in Kubernetes. Creation of container without pod is impossible and container is inside the pod
    * Each pod contains unique IP address and multiple containers. Each of them share resources using local host
    * kubectl explain pods command gives overview about pod. A kubernetes node contains multilple pods and each pods can contain multiple containers
    * kubctl describe pod clusterID gives the details of that cluster
    * If the cluster is not being used for a longer time, it is recommended to delete them

#### Replicaset

    * Replicaset ensures that specific number of pods are running at all times
    * If there are lesser nuumber of pods than what is needed even though we kill the pods, it creates a new pod and runs it
    * Desired number of replicaset can be configured using kubectl scale deployment hello-world-rest-api --replicas=3
    * So even if one pod is killed, replicas make sure to one more again to meet desired level
    * It is always tied with a specific release version

#### Deployment in Kubernetes

    * kubectl set image deployment hello-world-python hello-world-python=DUMMY_IMAGE:TEST.Even though we are giving wrong image name(DUMMY_IMAGE:TEST) the service will not go down. It has 0 downtime
    * Deploying a proper image:  kubectl set image deployment hello-world-python hello-world-python=in28min/hello-world-python:0.0.1.RELEASE
    * When we deploy a new image, the older version of instances will be scadled down by one at a time as new pods are added in new instance. This is a rollout method
    * Deployment is important to make sure new releases of application are upgraded with zero downtime

#### Services

    * Role of the service is to provide always available external interface to the applications which are running inside the pods
    * Service basically allows application to receive traffic through a permanent life time IP address
    * There will be specific load balancer created for each specific service and this is responsible for balancing traffic and always provide service
    * The actions we perform using kubectl service in console can also be performed/checked using GUI in GKE. Ex: events, setting replicas, rolling out update, deploy etc...

#### Master and worker nodes
    
    * All the configuration like events, service, replicaset setting, deployment will be happening inside distribute database in master node
    * All the service request changes comes to API service in master node both from kubectl commands/GUI in GKE
    * Scheduler in the master node is for scheduling the pods in the nodes and controller manager in the master nodes manages the overall health of the cluster. It makes sure the actual kubernetes cluster state matches the desired state
    * All the user applications(hello-world-python) will be running inside pods in worker nodes/node
    * Node agent(kubelet) is responsible for communicating the status with master node(controller manager)
    * Other components of worker nodes is networking component and container runtime
    * Application continue to run even though the master node is down
    * kubectl get componentstatuses gets the status of all the component

* Regions in GKE is to provide availability, latency and legal requirements and use of zones is also availability in multiple zones in the region

* To run the kubectl commands in any OS install Gcloud and kubectl. gcloud auth login login to gcloud

#### Kubernetes Rollout

    * kubectl set image deployment hello-world-python hello-world-python=in28min/hello-world-python:0.0.1.RELEASE --record=true will set the record history and can be checked using kubectl rollout history deployment hello-world-python
    * kubectl rollout undo deployment hello-world-python --to-revision=1 will undo the deployment and can also pause deployment

* Kubernetes can be configured using yaml file as well. kubectl get deployment hello-world-rest-api -o yaml > k_deployment.yaml gives the deployment in a yml file. To deploy with the specific config after chanhing in yml file use kubectl apply -f k_deployment.yaml

* Kubernetes service can also be saved using kubectl get service hello-world-python -o yaml > k_service.yaml

* Deleting a deployment: kubectl delete all -l app=hello-world-python

* Creating a deployment using yaml configuration: kubectl apply -f k_deployment.yaml

#### Understanding yaml configuration file for deployment

    * Metadata section defines data about deployment/service
    * Specs defines the containers for the pods
    * Template is the configuration for pod lables and pod specs
    * Selector is used to map the deployment with the pods using labels
    * maxSurge: how many instances can be created and maxUnavailable is how to instances can be unavailable
    * minreadySeconds is to tell container needs min this much time to apply changes in deployment
    * Replicaset yaml file cannot contain strategy section. Its not supported. Replace deployment with Replicaset in k_deployment.yaml and after running using same command replicaset will be created
    * Replicaset cannot do releases i.e., by changing release version in yaml file. So here we have to use deployment itself
    * Labels are powerful, using labels we can control many things like release strategies, release flow etc...

* A namespace provides a scope to identifiers and prevents name conflicts, whether you're writing code, managing services in Kubernetes, or organizing software systems

* Resources and limits are for memory allocation for the containers. Readiness port get the request and then starts the container. Liveness probe is to check if the container is running properly and if there are any issues

* Similarly for currency exchange and conversion we can make use of deployment.yaml for deployment without making use of environment variables. This is possible because based on the kubernetes service name it will create a environment variables. Ex: if service name is currency_exchange then a CURRENCY_EXCHANGE_SERVICE_HOST environment variable would be created during startup. (-) will be replaced by (_). But this is not highly recommended because we have to depend on injecting something at the startup. So we can directly point out the env in yaml file

```
 env:
        - name: CURRENCY_EXCHANGE_SERVICE_HOST
        value: http://currency-exchange
```

* Kubernetes comes up with automated service discovery system. This is built-in. And that is the reason of connectiing to currency conversion from exchange using url

* kind: ConfigMap configures are the configuration related required for an application and this can be configured as below so that it picks up the value from ConfigMaps from a specific config file in the main deployment file. This is centralized configuration

```
    valueFrom: 
            configMapKeyRef:
            key: CURRENCY_EXCHANGE_SERVICE_HOST
            name: currency-conversion-config-map -->
```

* Creation of multiple load balancer is not recommended because this is expensive in cloud. So to avoid this a service can be created as ingress.yaml using nodePort so that it will routed to appropriate microservice based on the url. type: NodePort. A port will be created for node and talk to it. Ingress creation will take little time about 15-20 min

* Delete the cluster when not in use