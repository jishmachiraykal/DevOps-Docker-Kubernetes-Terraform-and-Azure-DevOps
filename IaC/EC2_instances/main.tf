# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}

# Creating EC2 instance. First creating one of the prerequisites security groups
# https -> 80 TCP(port 80 for https), ssh -> 22 TCP and CIDR block to specify range of IP addresses[0.0.0.0/0] 0 means any system everywhere
resource "aws_security_group" "https_server_sg"{
    name = "https_server_sg"
    #virtual private network, which will be available in aws cloud
    vpc_id = "vpc-c49ff1be"

    #tags to allow traffic from https
    ingress = {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      # IP addresses to allow traffic from
      cidr_blocks = ["0.0.0.0/0"]
    }

    #tags to allow traffic from ssh
    ingress = {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      # IP addresses to allow traffic from
      cidr_blocks = ["0.0.0.0/0"]
    }


  #tags to allow traffic to
    egress = {
      from_port = 0
      to_port = 0
      # -1 indicates all protocol
      protocol = -1
      # IP addresses to allow traffic from
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "https_server_sg"
    }
}