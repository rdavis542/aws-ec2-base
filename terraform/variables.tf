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
  default = "us-east-1a"

}

variable "azB" {

  type        = string
  description = "Avail zone assigned"
  default = "us-east-1b"

}


variable "azC" {

  type        = string
  description = "Avail zone assigned"
  default = "us-east-1c"

}


variable "default_tags" {
  description = "Default tags too apply to all resources"
  default = ""
}
variable "volume_size" {

  type    = string
  default = "20"

}

variable "instance_type" {

  type    = string
  default = "t2.micro"
}

