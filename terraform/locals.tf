# locals.tf - Local Values for AWS Infrastructure
# This file contains local values derived from data sources for easy reference
# across Terraform configurations

locals {
  # Region and Account Information
  region             = data.aws_region.current.region
  account_id         = data.aws_caller_identity.current.account_id
  availability_zones = data.aws_availability_zones.available.names

  # VPC Information
  vpc_id         = data.aws_vpc.selected.id
  vpc_cidr_block = data.aws_vpc.selected.cidr_block
  vpc_name       = "vpc-east-1"

  # Public Subnets
  public_subnets = {
    a = {
      id                = data.aws_subnet.public-subnet-a.id
      cidr_block        = data.aws_subnet.public-subnet-a.cidr_block
      availability_zone = data.aws_subnet.public-subnet-a.availability_zone
      name              = "public-subnet-a"
    }
    b = {
      id                = data.aws_subnet.public-subnet-b.id
      cidr_block        = data.aws_subnet.public-subnet-b.cidr_block
      availability_zone = data.aws_subnet.public-subnet-b.availability_zone
      name              = "public-subnet-b"
    }
  }

  # Private Subnets
  private_subnets = {
    a = {
      id                = data.aws_subnet.private-subnet-a.id
      cidr_block        = data.aws_subnet.private-subnet-a.cidr_block
      availability_zone = data.aws_subnet.private-subnet-a.availability_zone
      name              = "private-subnet-a"
    }
    b = {
      id                = data.aws_subnet.private-subnet-b.id
      cidr_block        = data.aws_subnet.private-subnet-b.cidr_block
      availability_zone = data.aws_subnet.private-subnet-b.availability_zone
      name              = "private-subnet-b"
    }
  }

  # Subnet ID Lists (for easy iteration)
  public_subnet_ids = [
    data.aws_subnet.public-subnet-a.id,
    data.aws_subnet.public-subnet-b.id
  ]

  private_subnet_ids = [
    data.aws_subnet.private-subnet-a.id,
    data.aws_subnet.private-subnet-b.id
  ]

  all_subnet_ids = concat(local.public_subnet_ids, local.private_subnet_ids)

  # Subnet mappings by availability zone
  public_subnets_by_az = {
    (data.aws_subnet.public-subnet-a.availability_zone)  = data.aws_subnet.public-subnet-a.id
    (data.aws_subnet.public-subnet-b.availability_zone)  = data.aws_subnet.public-subnet-b.id
  }

  private_subnets_by_az = {
    (data.aws_subnet.private-subnet-a.availability_zone) = data.aws_subnet.private-subnet-a.id
    (data.aws_subnet.private-subnet-b.availability_zone) = data.aws_subnet.private-subnet-b.id
  }

  # AMI Information
  ec2_base_ami = {
    id            = data.aws_ami.ec2_base.id
    name          = data.aws_ami.ec2_base.name
    description   = data.aws_ami.ec2_base.description
    creation_date = data.aws_ami.ec2_base.creation_date
    architecture  = data.aws_ami.ec2_base.architecture
    owner_id      = data.aws_ami.ec2_base.owner_id
  }

  # Environment-specific configurations
  environment_config = {
    name_prefix = "${terraform.workspace}-"
    
    # Common instance types by use case
    instance_types = {
      micro  = "t3.micro"
      small  = "t3.small"
      medium = "t3.medium"
      large  = "t3.large"
    }
    
    # Common ports
    ports = {
      http    = 80
      https   = 443
      ssh     = 22
      mysql   = 3306
      postgres = 5432
      redis   = 6379
    }
  }

  # Network configuration helpers
  network = {
    vpc_id              = local.vpc_id
    public_subnet_ids   = local.public_subnet_ids
    private_subnet_ids  = local.private_subnet_ids
    availability_zones  = local.availability_zones
    
    # First available subnets (useful for single-AZ resources)
    first_public_subnet  = local.public_subnet_ids[0]
    first_private_subnet = local.private_subnet_ids[0]
    
    # Subnet count for validation
    public_subnet_count  = length(local.public_subnet_ids)
    private_subnet_count = length(local.private_subnet_ids)
  }

}
