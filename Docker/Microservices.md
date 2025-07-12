#### What is a microservice

    *  Small autonumous service that work together
    * Developing a single application as a suite of small services each running in its own process and communicating with lightweight mechanism
    * Can be written using different programming languages and use different data storage technologies

    Microservices are services exposed by REST with small well chosen deployable units and cloud enabled. Cloud enabled means should able to enable different instance on a different microservices without much effort if there is a too much load on one instance

#### Advantages of microservice
    
    * Enabled to adapt new technology and process because each microservice will be using different languages and technology
    * Dynamic scaling: In Amazon shopping applcation, the load will vary according to season like black Friday, Big billion days etc.. If a microservice is cloud enaled then it can scale the load dynamically and hardware can be procured and released as well
    * Faster release cycle: bringing new features to market

#### Challenges of microservice

    * Since there will be huge no.of deployments compared to monolithic application, the process becomes difficult and here docker comes into picture
    * Hence using docker we need not to worry about deployments. Need to create a efficient docker image using any technology and build it
    * No more local issues using docker because everything will be handled inside docker
