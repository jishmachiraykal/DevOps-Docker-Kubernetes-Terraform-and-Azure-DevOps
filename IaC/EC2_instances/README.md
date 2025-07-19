* EC2(Elastic compute cloud) is a virtual server in the aws cloud.Physical server is server in the datacenter.When we deploy applications and databeses to clould its a virtual server.Applications will get response from the region nearest to them. Ex: region = "us-east-1"

* If one of the regions go down, we can serve the application from other region which is advantage of tf

* Physical dataservers are protected by firewall. Noone from outside can access this. To do the same in virtual servers in the cloud, we can use VPC(cirtual provate control) kind of own network and inside that multiple subnets can be created. Subnets will be private and public. Access to private subnet is for the resources inside the VPC only. Public subnets contains http/https servers which can be accessed publicly

* Each regions contain multiple availability zones. If one zone goes down, other zone in that region can be used.

* EC2 instance can be created manually using all the data mentioned above or we can also automate it

* Ingress: Data or traffic coming into a system or networ and egress: data or traffic leaving a system or network

* More info about security groups: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

* Forces new resource in doc means it would delete the existing resource and create new resource. Be careful. Ex: name

* A key pair is needed to connect to EC2 servers. Connect key pair to an EC2 instance. Don't share the .pem file downloaded after creating key pair in cloud. Give only read permission for owner for .pem file saved locally

* Standard structure to store keys locally aws/asw_keys