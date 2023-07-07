#this file consists of code for instances and sg
provider "aws" {
region = "ap-northeast-3"
access_key = "AKIAZZ572XAQBNTIUV6N"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0ca0742afa9ee482f"
  instance_type   = "t2.micro"
  key_name        = "keypair"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-3a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte using jenkins pipeline by vijay server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0ca0742afa9ee482f"
  instance_type   = "t2.medium"
  key_name        = "keypair"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-3c"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte using jenkins pipeline by vijay server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

