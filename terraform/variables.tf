variable "region" {
  type        = string
  description = "region you want to use"
}

variable "subnet_private_a" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_private_b" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_private_c" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_public_a" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_public_b" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_public_c" {

  type        = string
  description = "subnets to support the vpc"

}

variable "cidr_block" {

  type        = string
  description = "VPC cidr range"

}

variable "azA" {

  type        = string
  description = "Avail zone assigned"

}

variable "azB" {

  type        = string
  description = "Avail zone assigned"

}


variable "azC" {

  type        = string
  description = "Avail zone assigned"

}


variable "default_tags" {
  description = "Default tags too apply to all resources"
  default = {
    "Environment"    = "Development"
    "Infrastructure" = "VPC"
    "REPO"           = "aws-ec2-base"
  }

}
variable "volume_size" {

  type    = string
  default = "20"

}

variable "instance_type" {

  type    = string
  default = "t2.micro"
}

