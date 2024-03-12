data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vpc_east_1"]
  }
}

data "aws_subnet" "public-subnet-a" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-a"]
  }
}

data "aws_subnet" "public-subnet-b" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-b"]
  }
}

data "aws_subnet" "private-subnet-a" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-a"]
  }
}

data "aws_subnet" "private-subnet-b" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-b"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["ssh_access"]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "tag:Name"
    values = ["http_access"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

data "template_file" "ec2_base" {
    template = file("${path.module}/script.sh")
  
}