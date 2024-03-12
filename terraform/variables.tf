variable "region" {
  type        = string
  description = "region you want to use"
}

variable "vpc_id" {
  type = string
  description = "VPC ID in EAST"
  
}

variable "subnet_private_a" {

  type        = string
  description = "subnets to support the vpc"

}

variable "subnet_private_b" {

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

variable "cidr_block" {

  type        = string
  description = "VPC cidr range"

}

variable "az1" {

  type        = string
  description = "Avail zone assigned"

}

variable "az2" {

  type        = string
  description = "Avail zone assigned"

}

variable "volume_size" {

  type = string
  default = "10"
  
}

variable "instance_type" {

  type = string
  default = "t2.micro"
}