provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "71.168.137.191/32"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "jenkins-sg-2022" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["71.168.137.191/32"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["71.168.137.191/32"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.launch-wizard-3
  }
}

resource "aws_instance" "myFirstInstance" {
  ami =  "ami-052efd3df9dad4825"
  key_name    =  "JenkinServerKeypair"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.launch-wizard-3.id]
  tags= {
    Name = "JenkinsServer
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}
